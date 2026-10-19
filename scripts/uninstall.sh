#!/usr/bin/env bash

# Init Flow - Local Uninstaller
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
    local installed_source
    local expected_source

    log_info "Starting Init Flow uninstallation..."

    if [[ ! -e "$TARGET" && ! -L "$TARGET" ]]; then
        log_success "Init Flow is not installed."
        exit 0
    fi

    if [[ ! -L "$TARGET" ]]; then
        log_error "Installation target is not a symbolic link: $TARGET"
        log_error "No files were removed."
        exit 1
    fi

    installed_source="$(readlink -f -- "$TARGET" || true)"
    expected_source="$(realpath -- "$SOURCE")"

    if [[ "$installed_source" != "$expected_source" ]]; then
        log_error "Symbolic link points to a different installation."
        log_error "Target: $TARGET"
        log_error "No files were removed."
        exit 1
    fi

    log_info "Removing Init Flow symbolic link..."

    rm -- "$TARGET"

    log_success "Init Flow uninstalled successfully."

    printf '\n'
    printf 'Removed: %s\n' "$TARGET"
    printf 'Source files preserved: %s\n' "$SCRIPT_DIR"
    printf '\n'
}

main "$@"