#!/usr/bin/env bash

# Init Flow - CLI Tests
# Copyright (c) 2026 Jacivaldo Carvalho
# Licensed under the MIT License.

set -euo pipefail

TEST_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CLI="${TEST_DIR}/../scripts/initflow"

PASSED=0
FAILED=0

assert_success() {
    local description="$1"
    shift

    if "$@" >/dev/null 2>&1; then
        printf '[PASS] %s\n' "$description"
        PASSED=$((PASSED + 1))
    else
        printf '[FAIL] %s\n' "$description"
        FAILED=$((FAILED + 1))
    fi
}

assert_failure() {
    local description="$1"
    shift

    if "$@" >/dev/null 2>&1; then
        printf '[FAIL] %s\n' "$description"
        FAILED=$((FAILED + 1))
    else
        printf '[PASS] %s\n' "$description"
        PASSED=$((PASSED + 1))
    fi
}

main() {
    printf 'Running Init Flow CLI tests...\n\n'

    assert_success "Help command" \
        "$CLI" --help

    assert_success "Short help option" \
        "$CLI" -h

    assert_success "Version command" \
        "$CLI" --version

    assert_success "Short version option" \
        "$CLI" -v

    assert_failure "Missing arguments" \
        "$CLI"

    assert_failure "Unknown command" \
        "$CLI" unknown

    assert_failure "Create without project name" \
        "$CLI" create

    assert_failure "Create with too many arguments" \
        "$CLI" create project extra

    assert_failure "Invalid project name with spaces" \
        "$CLI" create "invalid project"

    assert_failure "Invalid project name with slash" \
        "$CLI" create "invalid/project"

    assert_failure "Invalid project name with special characters" \
        "$CLI" create "project@123"

    assert_success "Parse all compatible options" \
        "$CLI" create parsed --private --readme --description "Special & spaces" --path "relative path" --no-editor --dry-run

    assert_success "Parse local dry run" \
        "$CLI" create parsed --local --readme --no-editor --dry-run

    assert_failure "Reject duplicate value option" \
        "$CLI" create parsed --path one --path two --dry-run

    assert_failure "Reject missing description" \
        "$CLI" create parsed --description --dry-run

    assert_failure "Reject incompatible local and private" \
        "$CLI" create parsed --local --private --dry-run

    assert_failure "Reject incompatible local and description" \
        "$CLI" create parsed --local --description text --dry-run

    assert_failure "Reject unknown create option" \
        "$CLI" create parsed --unknown --dry-run

    printf '\n'
    printf 'Passed: %d\n' "$PASSED"
    printf 'Failed: %d\n' "$FAILED"

    if [[ "$FAILED" -gt 0 ]]; then
        exit 1
    fi

    printf '\nShow! All tests passed.\n'
}

main "$@"
