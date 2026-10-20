
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-10-19

### Added

- Initial functional release of the Init Flow CLI.
- `initflow create <project-name>` command.
- `--help` and `--version` options.
- Project name and CLI argument validation.
- Required dependency checks for Git, GitHub CLI, and Visual Studio Code.
- GitHub CLI authentication verification.
- Local project directory creation.
- Git repository initialization using the `main` branch.
- Public GitHub repository creation.
- Automatic configuration of the `origin` remote.
- Automatic project opening in Visual Studio Code.
- Error handling for existing projects, GitHub API failures, and repository creation failures.
- Local installation and uninstallation scripts with symbolic link protection.
- Automated CLI, integration, installer, and uninstaller tests.
- GitHub Actions CI with Bash syntax validation, ShellCheck, and automated tests.
- MIT License, contribution guidelines, and GitHub issue and pull request templates.
- Architecture, installation, usage, security, troubleshooting, and roadmap documentation.
- Basic usage examples.

### Security

- Validation of project names before filesystem and GitHub operations.
- Protection against overwriting existing local projects.
- Verification of GitHub repository availability before creation.
- Safe handling of installation and uninstallation symbolic links.
- Documentation of public repository visibility and current security limitations.

[Unreleased]: https://github.com/jacivaldocarvalho/init-flow/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/jacivaldocarvalho/init-flow/releases/tag/v0.1.0