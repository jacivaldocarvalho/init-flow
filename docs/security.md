
# Security and Safe Usage

This document describes the security considerations, safeguards, and operational limitations of Init Flow.

## 1. Security Principles

Init Flow is designed around the following principles:

- Avoid overwriting existing files and directories.
- Validate project names before creating resources.
- Use the official GitHub CLI for authentication.
- Never store GitHub credentials or access tokens.
- Avoid executing commands with elevated privileges.
- Preserve local project files when remote operations fail.
- Keep automated tests isolated from real user projects.

## 2. GitHub Authentication

Init Flow uses the GitHub CLI (`gh`) to interact with GitHub.

Users must authenticate using:

```bash
gh auth login
```

Init Flow does not request, collect, or store GitHub access tokens.

Authentication and credential management are delegated to the GitHub CLI.

Users should follow GitHub's recommended authentication and account security practices.

## 3. Local File Protection

Before creating a project, Init Flow checks whether the target directory already exists.

If a conflicting file, directory, or symbolic link is detected, project creation is aborted.

Init Flow does not intentionally overwrite existing project directories.

The default project directory is:

```text
~/projects/
```

## 4. Repository Visibility

In the current development version, Init Flow creates public GitHub repositories.

Users should avoid placing confidential information, credentials, API keys, or private business data in repositories intended for publication.

Private repository support is planned for a future release.

## 5. Installation Safety

The local installer creates a symbolic link at:

```text
~/.local/bin/initflow
```

Before installation, it checks for existing files and symbolic links.

The installer:

- Does not require `sudo`.
- Does not overwrite existing files.
- Does not replace conflicting symbolic links.
- Detects broken symbolic links.
- Supports repeated execution when the correct installation already exists.
- Does not automatically modify shell configuration files.

Users should review installation scripts before executing them.


### Safe Uninstallation

Init Flow provides a local uninstaller that removes only the installation symbolic link when it points to the expected executable.

The uninstaller:

- Does not require administrator privileges.
- Does not delete user projects or GitHub repositories.
- Does not remove the source repository.
- Does not modify shell configuration files.
- Protects regular files and conflicting symbolic links.
- Refuses to remove broken symbolic links.
- Supports repeated execution safely.

The uninstaller does not perform recursive deletion of user directories.


## 6. Automated Test Isolation

The automated integration and installer tests use temporary directories created with `mktemp -d`.

Temporary resources are removed when the test scripts exit normally or through errors handled by the shell.

Tests use mocked Git, GitHub CLI, and VS Code commands where appropriate.

They are designed not to create real GitHub repositories or modify the user's existing installation.

Unexpected process termination, such as `SIGKILL` or system shutdown, may prevent automatic cleanup.

## 7. Error Handling and Partial Failures

Init Flow performs dependency and authentication checks before creating a local project.

However, failures may occur during Git initialization or GitHub repository creation.

In these situations, local project directories may remain on disk.

Users should inspect partially created resources before attempting another operation.

Init Flow does not automatically delete partially created projects.

## 8. Known Limitations

The current development version has the following limitations:

- Public GitHub repositories only.
- No automatic rollback of partially completed operations.
- No built-in confirmation prompt before repository creation.
- Automated tests do not cover every possible system or network failure.
- GitHub permissions and network availability can affect repository creation.

Additional safeguards will be considered before the first stable release.

## 9. Reporting Security Issues

If you discover a potential security vulnerability, avoid publicly disclosing sensitive exploit details before the issue can be reviewed.

Contact the maintainer through an appropriate private communication channel.

For non-sensitive bugs and improvements, use GitHub Issues:

https://github.com/jacivaldocarvalho/init-flow/issues

## 10. Security Recommendations

Before using Init Flow:

1. Review the source code and installation instructions.
2. Verify that Git and GitHub CLI are installed from trusted sources.
3. Confirm the GitHub account authenticated with `gh auth status`.
4. Avoid running Init Flow with root privileges.
5. Check project names and repository visibility before creation.
6. Review generated resources before committing or pushing code.

Security is an ongoing part of the Init Flow development process.