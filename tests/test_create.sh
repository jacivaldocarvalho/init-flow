#!/usr/bin/env bash

# Init Flow - Create Command Integration Tests
# Copyright (c) 2026 Jacivaldo Carvalho
# Licensed under the MIT License.

set -euo pipefail

TEST_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CLI="${TEST_DIR}/../scripts/initflow"

ORIGINAL_PATH="$PATH"
TEST_ROOT="$(mktemp -d)"
MOCK_BIN="${TEST_ROOT}/bin"

PASSED=0
FAILED=0

cleanup() {
    rm -rf -- "$TEST_ROOT"
}

trap cleanup EXIT

mkdir -p "$MOCK_BIN"

cat > "${MOCK_BIN}/git" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "-C" && "${3:-}" == "init" ]]; then
    if [[ -n "${MOCK_LOG:-}" ]]; then printf 'git\n' >> "$MOCK_LOG"; fi
    exit 0
fi

exit 1
EOF

cat > "${MOCK_BIN}/gh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
if [[ -n "${MOCK_LOG:-}" ]]; then printf 'gh:%s\n' "$*" >> "$MOCK_LOG"; fi

case "${1:-}" in
    auth)
        [[ "${2:-}" == "status" ]]
        ;;
    api)
        if [[ "${2:-}" == "user" ]]; then
            printf 'mock-user\n'
            exit 0
        fi

        if [[ "${2:-}" == "-i" ]]; then
            status="${MOCK_REMOTE_STATUS:-404}"

            case "$status" in
                200|404|403)
                    printf 'HTTP/2 %s\n' "$status"
                    exit 0
                    ;;
                *)
                    exit 1
                    ;;
            esac
        fi

        exit 1
        ;;
    repo)
        if [[ "${2:-}" == "create" ]]; then
            [[ "${MOCK_CREATE_FAILURE:-0}" != "1" ]]
        else
            exit 1
        fi
        ;;
    *)
        exit 1
        ;;
esac
EOF

cat > "${MOCK_BIN}/code" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
if [[ -n "${MOCK_LOG:-}" ]]; then printf 'code\n' >> "$MOCK_LOG"; fi

[[ "${MOCK_CODE_FAILURE:-0}" != "1" ]]
EOF

chmod +x "${MOCK_BIN}/git" "${MOCK_BIN}/gh" "${MOCK_BIN}/code"

export PATH="${MOCK_BIN}:${ORIGINAL_PATH}"
export INITFLOW_PROJECTS_DIR="${TEST_ROOT}/projects"

if [[ "$(command -v gh)" != "${MOCK_BIN}/gh" ]]; then
    printf '[FAIL] GitHub CLI mock is not active\n' >&2
    exit 1
fi

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

reset_mocks() {
    unset MOCK_REMOTE_STATUS
    unset MOCK_CREATE_FAILURE
    unset MOCK_CODE_FAILURE
}

main() {
    printf 'Running Init Flow create integration tests...\n\n'

    reset_mocks

    assert_success \
        "Create project with mocked dependencies" \
        "$CLI" create integration-project

    if [[ -d "${INITFLOW_PROJECTS_DIR}/integration-project" ]]; then
        printf '[PASS] Local project directory created\n'
        PASSED=$((PASSED + 1))
    else
        printf '[FAIL] Local project directory created\n'
        FAILED=$((FAILED + 1))
    fi

    assert_failure \
        "Reject existing local project" \
        "$CLI" create integration-project

    printf 'keep\n' > "${INITFLOW_PROJECTS_DIR}/integration-project/README.md"
    assert_failure "Protect existing README" "$CLI" create integration-project --readme
    if [[ "$(<"${INITFLOW_PROJECTS_DIR}/integration-project/README.md")" == keep ]]; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    ln -s "${TEST_ROOT}/missing-target" "${INITFLOW_PROJECTS_DIR}/linked-project"
    assert_failure "Protect existing symlink" "$CLI" create linked-project --local --no-editor
    if [[ -L "${INITFLOW_PROJECTS_DIR}/linked-project" ]]; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    reset_mocks
    export MOCK_REMOTE_STATUS=200

    assert_failure \
        "Reject existing GitHub repository" \
        "$CLI" create existing-remote

    reset_mocks
    export MOCK_REMOTE_STATUS=403

    assert_failure \
        "Reject GitHub API permission error" \
        "$CLI" create forbidden-remote

    reset_mocks
    export MOCK_REMOTE_STATUS=network-error

    assert_failure \
        "Reject GitHub API connectivity error" \
        "$CLI" create network-error

    reset_mocks
    export MOCK_CREATE_FAILURE=1

    assert_failure \
        "Handle GitHub repository creation failure" \
        "$CLI" create failed-remote

    if [[ -d "${INITFLOW_PROJECTS_DIR}/failed-remote" ]]; then
        printf '[PASS] Preserve local directory after remote failure\n'
        PASSED=$((PASSED + 1))
    else
        printf '[FAIL] Preserve local directory after remote failure\n'
        FAILED=$((FAILED + 1))
    fi

    reset_mocks
    export MOCK_CODE_FAILURE=1

    assert_success \
        "Preserve successful creation when VS Code fails" \
        "$CLI" create editor-failure

    reset_mocks
    export MOCK_LOG="${TEST_ROOT}/calls"
    assert_success "Private repository" "$CLI" create private-project --private --no-editor
    if grep -Fq -- '--private' "$MOCK_LOG"; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    : > "$MOCK_LOG"
    assert_success "Description and README" "$CLI" create described --description "A description: \$special & spaces" --readme --no-editor
    if [[ -f "${INITFLOW_PROJECTS_DIR}/described/README.md" ]] && grep -Fq -- "A description: \$special & spaces" "$MOCK_LOG"; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    : > "$MOCK_LOG"
    assert_success "Local project at custom path" "$CLI" create local-project --local --path "${TEST_ROOT}/custom path" --no-editor
    if [[ -d "${TEST_ROOT}/custom path/local-project" ]] && ! grep -Eq 'gh:|code' "$MOCK_LOG"; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    assert_failure "Reject local private" "$CLI" create bad-private --local --private
    assert_failure "Reject local description" "$CLI" create bad-description --local --description text
    assert_failure "Reject duplicate option" "$CLI" create duplicate --readme --readme
    assert_failure "Reject missing value" "$CLI" create missing --path
    assert_failure "Reject unknown option" "$CLI" create unknown --unknown

    : > "$MOCK_LOG"
    assert_success "Dry run without integrations" "$CLI" create planned --dry-run --readme --private --no-editor
    if [[ ! -e "${INITFLOW_PROJECTS_DIR}/planned" ]] && [[ ! -s "$MOCK_LOG" ]]; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    assert_success "Dry run with no external commands on PATH" env PATH=/nonexistent /usr/bin/bash "$CLI" create independent --dry-run --no-editor
    if [[ ! -e "${INITFLOW_PROJECTS_DIR}/independent" ]]; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    preview_output="$("$CLI" create remote-preview --dry-run --no-editor)"
    if [[ "$preview_output" == *'Remote availability has not been verified'* ]]; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    (
        cd "$TEST_ROOT"
        "$CLI" create relative-project --local --path 'relative projects' --no-editor >/dev/null
    )
    if [[ -d "${TEST_ROOT}/relative projects/relative-project" ]]; then PASSED=$((PASSED + 1)); else FAILED=$((FAILED + 1)); fi

    printf '\nPassed: %d\n' "$PASSED"
    printf 'Failed: %d\n' "$FAILED"

    if [[ "$FAILED" -gt 0 ]]; then
        exit 1
    fi

    printf '\nShow!All integration tests passed.\n'
}

main "$@"
