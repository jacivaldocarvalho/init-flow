
# Usage Guide

This guide describes the planned command-line interface and expected
behavior of Init Flow.

> **Status:** Init Flow is under development. The commands described
> below are planned and are not yet available for general use.

## Command Syntax

Init Flow follows a command-based CLI structure:

```bash
initflow <command> [arguments] [options]
```

The initial release will support:

| Command | Description |
|---|---|
| `initflow create <name>` | Create a new project |
| `initflow --help` | Display help information |
| `initflow --version` | Display the installed CLI version |

## Creating a Project

To initialize a new project:

```bash
initflow create my-project
```

The command is designed to:

1. Validate the project name.
2. Check required dependencies.
3. Verify GitHub CLI authentication.
4. Check for conflicting local directories and remote repositories.
5. Create a local project directory.
6. Initialize Git with the `main` branch.
7. Create a public GitHub repository.
8. Configure the `origin` remote.
9. Open the project in Visual Studio Code.

### Expected Directory Structure

The default project directory is planned to be:

```text
~/projects/
└── my-project/
    └── .git/
```

No README, `.gitignore`, LICENSE, or initial commit will be
generated automatically in the first release.

## Expected Output

A successful execution may display output similar to:

```text
[INFO] Validating project name...
[INFO] Checking dependencies...
[INFO] Checking GitHub authentication...
[INFO] Creating local project...
[INFO] Initializing Git repository...
[INFO] Creating GitHub repository...
[INFO] Configuring remote origin...
[INFO] Opening Visual Studio Code...

[SUCCESS] Project created successfully.

Local path: /home/user/projects/my-project
Repository: https://github.com/username/my-project
```

This output is illustrative. The final messages may change
during implementation.

## Publishing Your First Commit

After creating your project and adding the initial files:

```bash
cd ~/projects/my-project

git add .
git commit -m "chore: initial commit"
git push -u origin main
```

Before staging files, verify that sensitive information is
properly excluded using `.gitignore`.

For subsequent changes:

```bash
git add .
git commit -m "feat: add new functionality"
git push
```

## Project Name Validation

Project names must follow the initial validation rules:

- Must not be empty.
- Must start with an alphanumeric character.
- May contain letters, numbers, dots, underscores, and hyphens.
- Must not contain spaces or path separators.
- Must not contain parent directory references.

### Valid Examples

```text
my-project
api-service
devops_lab
project.v2
```

### Invalid Examples

```text
my project
../project
/project
```

Additional GitHub repository naming restrictions may apply.

## Error Handling

Init Flow will report errors and stop critical operations
when necessary.

### Missing Arguments

```bash
initflow create
```

Expected behavior:

```text
[ERROR] Missing project name.

Usage: initflow create <project-name>
```

### Invalid Project Name

```bash
initflow create "my project"
```

Expected behavior:

```text
[ERROR] Invalid project name.
```

### Existing Local Directory

If the target directory already exists, Init Flow will
stop without overwriting existing files.

### Existing GitHub Repository

If the repository already exists in the authenticated
GitHub account, Init Flow will report the conflict.

### Authentication Failure

If GitHub CLI authentication is unavailable or invalid,
Init Flow will stop before creating the project.

Authenticate using:

```bash
gh auth login
```

### Partial Failure

If an error occurs after the local directory has been created,
Init Flow will preserve the directory for inspection.

It will not automatically delete local files or remote
repositories.

### Editor Launch Failure

If the project and GitHub repository are created successfully
but Visual Studio Code cannot be opened, Init Flow will
report the editor failure separately.

The project will remain available.

## Help and Version

Display command help:

```bash
initflow --help
```

Display the installed version:

```bash
initflow --version
```

These commands will be implemented in the first functional release.

## Planned Options

The following options are planned for future versions and
are not available in the initial release.

| Option | Description |
|---|---|
| `--private` | Create a private repository |
| `--readme` | Generate an initial README |
| `--gitignore` | Generate a language-specific `.gitignore` |
| `--license` | Add a project license |
| `--template` | Initialize a project from a template |
| `--path` | Specify a custom project directory |
| `--no-editor` | Skip automatic editor launch |

### Future Usage Examples

Create a private repository:

```bash
initflow create my-api --private
```

Create a Python project:

```bash
initflow create my-api --template python
```

Choose a custom directory:

```bash
initflow create my-project --path ~/workspace
```

## Additional Documentation

- [Installation Guide](installation.md)
- [Architecture](architecture.md)
- [Troubleshooting](troubleshooting.md)
- [Project Roadmap](roadmap.md)
