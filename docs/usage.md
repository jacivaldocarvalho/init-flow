
# Usage Guide

This guide describes Init Flow v0.2.0.

## Command Syntax

Init Flow follows a command-based CLI structure:

```bash
initflow <command> [arguments] [options]
```

Available commands:

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

The default project directory is:

```text
~/projects/
└── my-project/
    └── .git/
```

README.md is generated only with `--readme`. No commit or push is performed.

## Output

Successful creation reports the project name, directory, `main` branch, and GitHub URL when a remote repository was created. Dry-run lists planned operations and states that remote availability was not verified.

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

The command reports a missing project name and exits with a nonzero status.

### Invalid Project Name

```bash
initflow create "my project"
```

The command reports the invalid name and exits with a nonzero status.

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

These commands are available.

## Create Options

| Option | Description |
|---|---|
| `--private` | Create a private repository |
| `--readme` | Generate an initial README |
| `--description TEXT` | Set the GitHub repository description |
| `--local` | Create a local Git project without GitHub integration |
| `--path DIRECTORY` | Specify a custom projects base directory |
| `--no-editor` | Skip automatic editor launch |
| `--dry-run` | Show planned operations without creating anything |

`--local` cannot be combined with `--private` or `--description`. All other combinations are supported. Paths may be absolute or relative; relative paths resolve from the working directory where Init Flow was invoked. Path precedence is `--path` > `INITFLOW_PROJECTS_DIR` > `$HOME/projects`. Dry-run does not verify remote availability or require Git, GitHub CLI, authentication, or VS Code.

### Examples

Create a private repository:

```bash
initflow create my-api --private
```

Create a local project with a README:

```bash
initflow create my-api --local --readme --no-editor
```

Choose a custom directory:

```bash
initflow create my-project --path ~/workspace

initflow create my-project --description "Tools & automation" --dry-run
```

## Additional Documentation

- [Installation Guide](installation.md)
- [Architecture](architecture.md)
- [Troubleshooting](troubleshooting.md)
- [Project Roadmap](roadmap.md)
