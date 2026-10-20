# Init Flow

[![CI](https://github.com/jacivaldocarvalho/init-flow/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/jacivaldocarvalho/init-flow/actions/workflows/ci.yml)
[![Bash](https://img.shields.io/badge/Bash-CLI-4EAA25?style=flat-square&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=flat-square&logo=git&logoColor=white)](https://git-scm.com/)
[![GitHub CLI](https://img.shields.io/badge/GitHub-CLI-181717?style=flat-square&logo=github&logoColor=white)](https://cli.github.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
![Status](https://img.shields.io/badge/Status-In%20Development-orange?style=flat-square)
[![GitHub Release](https://img.shields.io/github/v/release/jacivaldocarvalho/init-flow?style=flat-square)](https://github.com/jacivaldocarvalho/init-flow/releases)


**Automate local project creation and GitHub repository setup directly from your terminal.**

**Init Flow** is an open-source Command-Line Interface (CLI) built with Bash to simplify and standardize the initialization of software development projects.

The goal is to eliminate repetitive setup tasks, allowing developers to start new projects with a single command.

**Project Status:** Active development — v0.1.0 released and available for installation from source. Automated tests and GitHub Actions CI are operational.

## Overview

Init Flow aims to automate the project initialization process, from creating a local directory to configuring a remote Git repository.

The planned command is:

```bash
initflow create my-project
```

Once implemented, this command will:

1. Create a project directory under `~/projects/`.
2. Initialize Git with `main` as the default branch.
3. Create a public GitHub repository.
4. Configure the `origin` remote.
5. Open the project in Visual Studio Code.

## Tech Stack

| Technology | Purpose |
|---|---|
| Bash | CLI development |
| Git | Source code version control |
| GitHub CLI | GitHub repository management |
| Visual Studio Code | Development environment |
| ShellCheck | Static analysis for shell scripts |
| GitHub Actions | Continuous integration |

## Planned Requirements

- Linux (Ubuntu/Debian)
- Bash
- Git
- GitHub CLI (`gh`) with an authenticated account
- Visual Studio Code with the `code` command available

## Installation

Init Flow can be installed locally from the source repository using the provided installation script.

For detailed setup instructions, requirements, and troubleshooting, see the [Installation Guide](docs/installation.md).


### Uninstallation

To uninstall Init Flow from your local environment, navigate to the cloned repository and run:

```bash
./scripts/uninstall.sh
```

The uninstaller safely removes the installation symbolic link without deleting user projects, GitHub repositories, or source files.

For more information, see the [Installation Guide](docs/installation.md).


## Documentation

- [Installation](docs/installation.md)
- [Usage](docs/usage.md)
- [Architecture](docs/architecture.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Roadmap](docs/roadmap.md)
- [Security and Safe Usage](docs/security.md)

## Roadmap

Planned features and improvements:

- [ ] Create local projects and public GitHub repositories.
- [ ] Validate CLI arguments, dependencies, and authentication.
- [ ] Implement `--help` and `--version`.
- [ ] Add automated tests and static analysis.
- [ ] Support private GitHub repositories.
- [ ] Generate README, `.gitignore`, and LICENSE files.
- [ ] Provide project templates for Python, Go, and Node.js.
- [ ] Add GitLab integration.
- [ ] Support custom configuration options.

See the [Project Roadmap](docs/roadmap.md) for further details.

## Contributing

Contributions, bug reports, and feature suggestions are welcome.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a contribution.


## Security and Safe Usage

Init Flow is designed to minimize unintended changes to local files and GitHub repositories.

Key safeguards include:

- Project name validation.
- Protection against overwriting existing project directories.
- GitHub authentication through the official GitHub CLI.
- No direct storage of GitHub credentials or access tokens.
- Safe installation without `sudo` or overwriting existing files.
- Isolated automated tests using temporary directories.
- Preservation of local project files when remote operations fail.

**Important:** The current development version creates **public GitHub repositories**. Do not use it to publish confidential or sensitive information.

Init Flow is under active development, and not all failure scenarios are covered by automated tests.

For detailed security considerations, known limitations, and recommended practices, see the [Security and Safe Usage Guide](docs/security.md).


## Author

**Jacivaldo Carvalho**

Telecommunications Engineer | DevOps Engineer | SRE | Networking

[GitHub](https://github.com/jacivaldocarvalho) | [LinkedIn](https://www.linkedin.com/in/jacivaldocarvalho) | [Website](https://www.jacivaldocarvalho.com/)

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.