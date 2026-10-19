#!/usr/bin/env bash

# Init Flow - Installer Tests
# Copyright (c) 2026 Jacivaldo Carvalho
# Licensed under the MIT License.

set -euo pipefail

TEST_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER="${TEST_DIR}/../scripts/install.sh"
SOURCE="${TEST_DIR}/../scripts/initflow"

TEST_ROOT="$(mktemp -d)"
PASSED=0
FAILED=0

cleanup() {
    rm -rf -- "$TEST_ROOT"
}

trap cleanup EXIT

pass() {
    printf '[PASS] %s\n' "$1"
    PASSED=$((PASSED + 1))
}

fail() {
    printf '[FAIL] %s\n' "$1"
    FAILED=$((FAILED + 1))
}

run_installer() {
    local test_home="$1"

    HOME="$test_home" bash "$INSTALLER" >/dev/null 2>&1
}

main() {
    local test_home
    local target

    printf 'Running Init Flow installer tests...\n\n'

    # Test 1: First installation.
    test_home="${TEST_ROOT}/first-install"
    mkdir -p "$test_home"

    if run_installer "$test_home"; then
        target="${test_home}/.local/bin/initflow"

        if [[ -L "$target" ]] &&
           [[ "$(readlink -f "$target")" == "$(realpath "$SOURCE")" ]]; then
            pass "First installation creates the correct symbolic link"
        else
            fail "First installation creates the correct symbolic link"
        fi
    else
        fail "First installation creates the correct symbolic link"
    fi

    # Test 2: Repeated installation.
    if run_installer "$test_home"; then
        pass "Repeated installation succeeds"
    else
        fail "Repeated installation succeeds"
    fi

    # Test 3: Existing regular file.
    test_home="${TEST_ROOT}/existing-file"
    target="${test_home}/.local/bin/initflow"
    mkdir -p "$(dirname "$target")"
    printf 'existing file\n' > "$target"

    if run_installer "$test_home"; then
        fail "Existing regular file is protected"
    elif [[ "$(cat "$target")" == "existing file" ]]; then
        pass "Existing regular file is protected"
    else
        fail "Existing regular file is protected"
    fi

    # Test 4: Existing symbolic link to another file.
    test_home="${TEST_ROOT}/different-link"
    target="${test_home}/.local/bin/initflow"
    mkdir -p "$(dirname "$target")"
    printf 'another executable\n' > "${TEST_ROOT}/other"
    ln -s "${TEST_ROOT}/other" "$target"

    if run_installer "$test_home"; then
        fail "Existing symbolic link is protected"
    elif [[ "$(readlink "$target")" == "${TEST_ROOT}/other" ]]; then
        pass "Existing symbolic link is protected"
    else
        fail "Existing symbolic link is protected"
    fi

    # Test 5: Broken symbolic link.
    test_home="${TEST_ROOT}/broken-link"
    target="${test_home}/.local/bin/initflow"
    mkdir -p "$(dirname "$target")"
    ln -s "${TEST_ROOT}/missing-executable" "$target"

    if run_installer "$test_home"; then
        fail "Broken symbolic link is protected"
    elif [[ -L "$target" ]] &&
         [[ "$(readlink "$target")" == "${TEST_ROOT}/missing-executable" ]]; then
        pass "Broken symbolic link is protected"
    else
        fail "Broken symbolic link is protected"
    fi

    printf '\nPassed: %d\n' "$PASSED"
    printf 'Failed: %d\n' "$FAILED"

    if [[ "$FAILED" -gt 0 ]]; then
        exit 1
    fi

    printf '\nShow! All installer tests passed.\n'
}

main "$@"