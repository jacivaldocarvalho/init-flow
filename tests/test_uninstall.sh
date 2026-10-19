#!/usr/bin/env bash

# Init Flow - Uninstaller Tests
# Copyright (c) 2026 Jacivaldo Carvalho
# Licensed under the MIT License.

set -euo pipefail

TEST_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER="${TEST_DIR}/../scripts/install.sh"
UNINSTALLER="${TEST_DIR}/../scripts/uninstall.sh"

TEST_ROOT="$(mktemp -d)"
PASSED=0
FAILED=0

cleanup() {
    if [[ -n "${TEST_ROOT:-}" && -d "$TEST_ROOT" ]]; then
        rm -rf -- "$TEST_ROOT"
    fi
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
    HOME="$1" bash "$INSTALLER" >/dev/null 2>&1
}

run_uninstaller() {
    HOME="$1" bash "$UNINSTALLER" >/dev/null 2>&1
}

main() {
    local test_home
    local target

    printf 'Running Init Flow uninstaller tests...\n\n'

    # Test 1: Install and uninstall.
    test_home="${TEST_ROOT}/normal"
    mkdir -p "$test_home"

    if run_installer "$test_home" &&
       run_uninstaller "$test_home"; then

        target="${test_home}/.local/bin/initflow"

        if [[ ! -e "$target" && ! -L "$target" ]]; then
            pass "Uninstallation removes the symbolic link"
        else
            fail "Uninstallation removes the symbolic link"
        fi
    else
        fail "Uninstallation removes the symbolic link"
    fi

    # Test 2: Repeated uninstallation.
    if run_uninstaller "$test_home"; then
        pass "Repeated uninstallation succeeds"
    else
        fail "Repeated uninstallation succeeds"
    fi

    # Test 3: Existing regular file.
    test_home="${TEST_ROOT}/regular-file"
    target="${test_home}/.local/bin/initflow"
    mkdir -p "$(dirname "$target")"
    printf 'protected\n' > "$target"

    if run_uninstaller "$test_home"; then
        fail "Existing regular file is protected"
    elif [[ "$(cat "$target")" == "protected" ]]; then
        pass "Existing regular file is protected"
    else
        fail "Existing regular file is protected"
    fi

    # Test 4: Symbolic link to another installation.
    test_home="${TEST_ROOT}/different-link"
    target="${test_home}/.local/bin/initflow"
    mkdir -p "$(dirname "$target")"
    printf 'other\n' > "${TEST_ROOT}/other"
    ln -s "${TEST_ROOT}/other" "$target"

    if run_uninstaller "$test_home"; then
        fail "Different installation is protected"
    elif [[ "$(readlink "$target")" == "${TEST_ROOT}/other" ]]; then
        pass "Different installation is protected"
    else
        fail "Different installation is protected"
    fi

    # Test 5: Broken symbolic link.
    test_home="${TEST_ROOT}/broken-link"
    target="${test_home}/.local/bin/initflow"
    mkdir -p "$(dirname "$target")"
    ln -s "${TEST_ROOT}/missing" "$target"

    if run_uninstaller "$test_home"; then
        fail "Broken symbolic link is protected"
    elif [[ -L "$target" ]]; then
        pass "Broken symbolic link is protected"
    else
        fail "Broken symbolic link is protected"
    fi

    printf '\nPassed: %d\n' "$PASSED"
    printf 'Failed: %d\n' "$FAILED"

    if [[ "$FAILED" -gt 0 ]]; then
        exit 1
    fi

    printf '\nAll uninstaller tests passed.\n'
}

main "$@"