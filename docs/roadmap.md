
# Init Flow — Project Roadmap

This document outlines the planned development of Init Flow.

Init Flow aims to provide a lightweight, extensible, and reliable CLI
for automating software project initialization.

Features and release targets may change based on technical requirements,
community feedback, and project priorities.


## v0.1.0 — Core CLI

**Goal:** Deliver the first functional version of Init Flow.

**Status:** Implementation complete — release preparation in progress.

### Features

- [x] Implement the `initflow` Bash executable.
- [x] Support `initflow create <project-name>`.
- [x] Validate project names and CLI arguments.
- [x] Check required dependencies.
- [x] Verify GitHub CLI authentication.
- [x] Create local project directories.
- [x] Initialize Git with the `main` branch.
- [x] Create public GitHub repositories.
- [x] Configure the `origin` remote.
- [x] Open projects in Visual Studio Code.
- [x] Implement `--help` and `--version`.
- [x] Handle tested errors and partial failures.
- [x] Provide safe local installation and uninstallation scripts.

### Quality and Documentation

- [x] Implement automated CLI tests.
- [x] Implement integration tests with mocked dependencies.
- [x] Implement installer and uninstaller tests.
- [x] Configure ShellCheck.
- [x] Configure GitHub Actions CI.
- [x] Document installation and usage.
- [x] Document the initial architecture.
- [x] Document security considerations and troubleshooting.
- [x] Provide basic usage examples.


### Quality and Documentation

- [ ] Implement automated CLI tests.
- [ ] Configure ShellCheck.
- [ ] Configure GitHub Actions CI.
- [ ] Document installation and usage.
- [ ] Document the initial architecture.
- [ ] Provide basic usage examples.

## v0.2.0 — Configuration and Customization

**Goal:** Introduce configurable project initialization.

- [ ] Support private repositories with `--private`.
- [ ] Generate README files with `--readme`.
- [ ] Generate `.gitignore` files.
- [ ] Add license generation.
- [ ] Support custom project directories.
- [ ] Support configurable default settings.
- [ ] Make automatic editor launching optional.

## v0.3.0 — Project Templates

**Goal:** Support language-specific project initialization.

- [ ] Add Python project templates.
- [ ] Add Go project templates.
- [ ] Add Node.js project templates.
- [ ] Implement `initflow templates list`.
- [ ] Support template selection during project creation.
- [ ] Allow custom templates.

## v0.4.0 — Git Provider Integration

**Goal:** Extend repository management beyond GitHub.

- [ ] Add GitLab support.
- [ ] Introduce provider selection.
- [ ] Support provider-specific authentication.
- [ ] Improve remote repository configuration.
- [ ] Add provider integration tests.

## v1.0.0 — Stable Release

**Goal:** Deliver a stable and documented CLI.

- [ ] Stabilize the command interface.
- [ ] Improve cross-environment compatibility.
- [ ] Provide a reliable installation and update process.
- [ ] Expand automated test coverage.
- [ ] Complete user and contributor documentation.
- [ ] Publish the first stable release.

## Future Ideas

Potential improvements beyond the initial roadmap:

- Interactive project creation.
- Plugin-based architecture.
- Custom project scaffolding.
- Docker project initialization.
- CI/CD pipeline templates.
- Terraform infrastructure templates.
- DevOps and SRE project templates.
- Additional Git providers.

## Contributing

Community contributions are welcome.

To suggest a feature or improvement, open an issue using the
[Feature Request template](../.github/ISSUE_TEMPLATE/feature_request.md).

See [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution guidelines.

## Release Policy

Init Flow follows Semantic Versioning.

- **MAJOR:** Breaking changes.
- **MINOR:** Backward-compatible features.
- **PATCH:** Backward-compatible bug fixes.

During the `0.x` development cycle, the CLI may introduce breaking
changes as its interface and architecture evolve.

Release dates are not fixed. Versions will be published after their
planned functionality has been implemented, tested, and documented.
