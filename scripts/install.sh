#!/usr/bin/env bash

# Init Flow - Local Installer
# Copyright (c) 2026 Jacivaldo Carvalho
# Licensed under the MIT License.

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/initflow"

INSTALL_DIR="${HOME}/.local/bin"
TARGET="${INSTALL_DIR}/initflow"

log_info() {
    printf '[INFO] %s\n' "$1"
}

log_success() {
    printf '[SUCCESS] %s\n' "$1"
}

log_error() {
    printf '[ERROR] %s\n' "$1" >&2
}

main() {
    log_info "Starting Init Flow installation..."

    if [[ ! -f "$SOURCE" ]]; then
        log_error "Init Flow executable not found: $SOURCE"
        exit 1
    fi

    if [[ ! -x "$SOURCE" ]]; then
        log_error "Init Flow executable is not executable."
        log_error "Run: chmod +x scripts/initflow"
        exit 1
    fi

    mkdir -p "$INSTALL_DIR"

    # Check existing files and symbolic links.
    if [[ -e "$TARGET" || -L "$TARGET" ]]; then

        if [[ -L "$TARGET" ]]; then
            existing_source="$(readlink -f -- "$TARGET" || true)"
            expected_source="$(realpath -- "$SOURCE")"

            if [[ "$existing_source" == "$expected_source" ]]; then
                log_success "Init Flow is already installed."
                exit 0
            fi

            log_error "An existing symbolic link was found: $TARGET"
            log_error "Existing installation will not be overwritten."
            exit 1
        fi

        log_error "An existing file or directory was found: $TARGET"
        log_error "Installation aborted to prevent overwriting."
        exit 1
    fi

    log_info "Creating symbolic link..."

    ln -s -- "$SOURCE" "$TARGET"

    log_success "Init Flow installed successfully!"

    printf '\n'
    printf 'Executable: %s\n' "$TARGET"
    printf '\n'

    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        log_info "Add the following directory to your PATH:"
        printf '\n'
        # Print the command literally so users can copy it.
        # shellcheck disable=SC2016
        printf 'export PATH="$HOME/.local/bin:$PATH"\n'
        printf '\n'
    else
        log_success "Installation directory is already in PATH."
    fi

    printf 'Run: initflow --help\n'
}

main "$@"
