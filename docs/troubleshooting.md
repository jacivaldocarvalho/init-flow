
# Troubleshooting Guide

This guide covers common installation, configuration, and runtime
issues related to Init Flow and its dependencies.

> **Status:** Init Flow is under development. Some CLI-specific
> troubleshooting procedures apply to the planned implementation.

## 1. Command Not Found

### Problem

```text
initflow: command not found
```

### Possible Causes

- Init Flow has not been installed.
- The executable is not included in `PATH`.
- The symbolic link is missing or broken.

### Solution

Check whether the executable is available:

```bash
command -v initflow
```

Verify the installation directory:

```bash
ls -l "$HOME/.local/bin/initflow"
```

Ensure the directory is included in `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

For a persistent Bash configuration, add the export command
to `~/.bashrc` if it is not already present.

---

## 2. Permission Denied

### Problem

```text
Permission denied
```

### Possible Cause

The CLI script does not have executable permissions.

### Solution

From the Init Flow repository directory:

```bash
chmod +x scripts/initflow
```

Verify:

```bash
ls -l scripts/initflow
```

The executable permission should be present.

Avoid running Init Flow with `sudo`.

---

## 3. Git Not Installed

### Problem

```text
git: command not found
```

### Solution

On Ubuntu or Debian:

```bash
sudo apt update
sudo apt install -y git
```

Verify:

```bash
git --version
```

---

## 4. GitHub CLI Not Installed

### Problem

```text
gh: command not found
```

### Solution

On Ubuntu or Debian:

```bash
sudo apt install -y gh
```

Verify:

```bash
gh --version
```

For other installation methods, visit:

https://cli.github.com/

---

## 5. GitHub Authentication Failed

### Problem

Init Flow cannot authenticate with GitHub.

### Solution

Check authentication status:

```bash
gh auth status
```

Authenticate if necessary:

```bash
gh auth login
```

Follow the interactive instructions.

Verify authentication again:

```bash
gh auth status
```

Do not share authentication tokens or credentials.

---

## 6. SSH Authentication Failed

### Problem

```text
Permission denied (publickey).
```

### Possible Cause

Git is configured to use SSH, but the SSH key is not
properly configured or registered with GitHub.

### Solution

Test SSH connectivity:

```bash
ssh -T git@github.com
```

Check existing SSH keys:

```bash
ls -la ~/.ssh
```

Follow GitHub's official SSH documentation:

https://docs.github.com/en/authentication/connecting-to-github-with-ssh

GitHub CLI authentication and Git SSH authentication
are related but may require separate configuration.

---

## 7. Repository Already Exists

### Problem

A GitHub repository with the requested name already exists.

### Solution

Check the repository:

```bash
gh repo view OWNER/REPOSITORY
```

Replace `OWNER` and `REPOSITORY` with the appropriate values.

Choose another name or manually connect an existing repository.

Init Flow will not overwrite existing remote repositories.

---

## 8. Local Directory Already Exists

### Problem

The requested project directory already exists.

### Solution

Check the directory:

```bash
ls -ld "$HOME/projects/my-project"
```

Choose another project name or inspect the existing directory.

Init Flow will not automatically delete or overwrite
existing project directories.

---

## 9. Git Remote Configuration Error

### Problem

```text
error: remote origin already exists.
```

### Solution

Inspect configured remotes:

```bash
git remote -v
```

If the existing remote is incorrect, update it:

```bash
git remote set-url origin <repository-url>
```

Replace `<repository-url>` with the correct Git URL.

Avoid removing or replacing remotes without checking
their current configuration.

---

## 10. Git Push Authentication Failed

### Problem

The repository was created successfully, but `git push`
fails due to authentication errors.

### Solution

Check the remote URL:

```bash
git remote -v
```

For HTTPS authentication, GitHub CLI may help configure
Git credentials:

```bash
gh auth setup-git
```

For SSH remotes, verify SSH authentication:

```bash
ssh -T git@github.com
```

The authentication method must match the configured
Git remote transport.

---

## 11. Visual Studio Code Does Not Open

### Problem

The project is created, but Visual Studio Code
does not open automatically.

### Solution

Check whether the `code` command exists:

```bash
command -v code
```

Try opening a project manually:

```bash
code "$HOME/projects/my-project"
```

If the command is unavailable, review the official
Visual Studio Code installation instructions:

https://code.visualstudio.com/docs/setup/linux

An editor launch failure should not delete a
successfully created project.

---

## 12. Git Commit Identity Not Configured

### Problem

```text
Author identity unknown
```

### Solution

Configure your Git identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

Verify:

```bash
git config --global user.name
git config --global user.email
```

---

## 13. Partial Project Creation Failure

### Problem

The local project directory was created, but the
GitHub repository creation failed.

### Expected Behavior

Init Flow will preserve the local directory and
report the failure.

### Recovery

Inspect the local directory:

```bash
ls -la "$HOME/projects/my-project"
```

Check whether a Git repository was initialized:

```bash
git -C "$HOME/projects/my-project" status
```

Check whether the remote repository exists:

```bash
gh repo view OWNER/REPOSITORY
```

Do not delete local or remote resources without
verifying their contents.

---

## 14. Collecting Diagnostic Information

When reporting an issue, include relevant environment
and tool information.

```bash
uname -a
bash --version
git --version
gh --version
gh auth status
```

Do not include authentication tokens, private keys,
or sensitive environment variables in issue reports.

Review command output before sharing it publicly.

## Reporting Issues

If the problem persists, open an issue:

https://github.com/jacivaldocarvalho/init-flow/issues

Use the Bug Report template and provide:

- A description of the issue.
- Steps to reproduce.
- Expected and actual behavior.
- Operating system information.
- Relevant tool versions.
- Sanitized error messages.

For contribution guidelines, see
[CONTRIBUTING.md](../CONTRIBUTING.md).
