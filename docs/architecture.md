
# Init Flow — Architecture

## Overview

Init Flow is a lightweight command-line tool designed to automate
the initialization of software development projects.

The initial implementation uses Bash and integrates with Git,
GitHub CLI, and Visual Studio Code.

The architecture prioritizes:

- Simplicity and maintainability.
- Minimal external dependencies.
- Input validation.
- Explicit error handling.
- Safe filesystem operations.
- Extensibility for future features.

## High-Level Architecture

```text
                  +-------------------------+
                  |       Developer         |
                  +------------+------------+
                               |
                               v
                  +-------------------------+
                  |       Init Flow         |
                  |      Bash CLI           |
                  +------------+------------+
                               |
                               v
                  +-------------------------+
                  |    Command Dispatcher   |
                  |    create / help /      |
                  |         version         |
                  +------------+------------+
                               |
                               v
                  +-------------------------+
                  |   Input Validation      |
                  |   Dependency Checks     |
                  |   Authentication        |
                  +------------+------------+
                               |
                               v
                  +-------------------------+
                  |   Project Initialization|
                  |   Directory + Git       |
                  +------------+------------+
                               |
                               v
                  +-------------------------+
                  |   GitHub Integration    |
                  |   Repository + Remote   |
                  +------------+------------+
                               |
                               v
                  +-------------------------+
                  |    Editor Integration   |
                  |       VS Code           |
                  +-------------------------+
```

## Project Structure

```text
init-flow/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   └── pull_request_template.md
├── docs/
├── examples/
├── scripts/
│   └── initflow
├── tests/
├── .gitignore
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

The `scripts/initflow` executable will contain the initial CLI
implementation.

The `tests/` directory will contain automated tests.

GitHub Actions workflows will be stored in `.github/workflows/`.

## CLI Interface

The planned command structure is:

```bash
initflow <command> [arguments] [options]
```

### Initial Commands

| Command | Description |
|---|---|
| `initflow create <name>` | Create a new project |
| `initflow --help` | Display CLI help |
| `initflow --version` | Display CLI version |

Additional commands and options will be introduced in future releases.

## Project Creation Workflow

The initial `create` command will follow these steps:

1. Parse command-line arguments.
2. Validate the project name.
3. Verify required dependencies.
4. Verify GitHub authentication.
5. Check whether the local directory already exists.
6. Check whether the target GitHub repository already exists.
7. Create the local project directory.
8. Initialize Git with the `main` branch.
9. Create the GitHub repository.
10. Configure the `origin` remote.
11. Open the project in Visual Studio Code.
12. Display the operation result.

## Input Validation

Project names must:

- Not be empty.
- Start with an alphanumeric character.
- Contain only letters, numbers, dots, underscores, and hyphens.
- Not contain path separators.
- Not reference parent directories.

The CLI must reject invalid input before modifying the filesystem.

## Dependency Management

The initial implementation requires:

- Bash
- Git
- GitHub CLI (`gh`)
- Visual Studio Code (`code`)

Dependencies will be checked before project creation.

Future versions may support optional editor integration.

## GitHub Integration

GitHub repository operations will use the official GitHub CLI.

Example:

```bash
gh repo create <repository-name> \
    --public \
    --source=. \
    --remote=origin
```

GitHub authentication will be verified using:

```bash
gh auth status
```

Repository creation must not proceed if authentication fails.

## Error Handling

The CLI must:

- Exit with a non-zero status when a critical operation fails.
- Display actionable error messages.
- Avoid overwriting existing projects.
- Avoid deleting user files automatically.
- Preserve local files when remote repository creation fails.
- Distinguish critical errors from optional editor launch failures.

Automatic deletion of remote repositories is not part of the
initial implementation.

## Security Considerations

Init Flow must follow these practices:

- Quote shell variables.
- Validate user-provided paths and names.
- Avoid evaluating user input as shell commands.
- Never store GitHub authentication tokens.
- Use the existing GitHub CLI authentication mechanism.
- Avoid logging credentials or sensitive environment variables.
- Avoid destructive operations without explicit user confirmation.

## Testing Strategy

The initial test suite will cover:

- Command parsing.
- Project name validation.
- Missing dependencies.
- GitHub authentication failures.
- Existing local directories.
- Existing remote repositories.
- Successful project initialization.
- Error handling.

External commands should be mocked where appropriate to avoid
creating real GitHub repositories during automated tests.

## Future Extensibility

The architecture may evolve to support:

- Additional Git providers.
- Project templates.
- Custom configuration files.
- Optional editor integration.
- CI/CD scaffolding.
- Infrastructure automation templates.

The CLI interface should remain consistent whenever possible.

## Design Principles

Init Flow follows four main principles:

1. **Keep it simple:** Avoid unnecessary complexity.
2. **Fail safely:** Validate before making changes.
3. **Automate repetitive tasks:** Reduce manual setup.
4. **Design for extension:** Allow new features without major rewrites.