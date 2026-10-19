
# Installation Guide

This guide describes how to prepare your environment and install
Init Flow on Linux.

> **Status:** Init Flow is under development. The installation
> procedure will become available after the first functional release.

## Supported Platforms

The initial version targets:

- Ubuntu
- Debian
- Other Linux distributions with Bash and compatible dependencies
  (not yet officially tested)

Windows and macOS support are not included in the initial release.

## Prerequisites

Init Flow requires the following tools:

| Tool | Purpose |
|---|---|
| Bash | Execute the CLI |
| Git | Initialize and manage repositories |
| GitHub CLI | Create GitHub repositories |
| Visual Studio Code | Open newly created projects |

## Install Dependencies

### Ubuntu / Debian

Update package information:

```bash
sudo apt update
```

Install Git and GitHub CLI:

```bash
sudo apt install -y git gh
```

Verify the installation:

```bash
git --version
gh --version
```

Bash is normally available by default on Ubuntu and Debian.

Check its version:

```bash
bash --version
```

## Configure Git

If Git is not already configured, set your identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

Verify:

```bash
git config --global --list
```

## Authenticate GitHub CLI

Authenticate with your GitHub account:

```bash
gh auth login
```

Follow the interactive instructions.

Select the appropriate authentication method for your environment.

Verify authentication:

```bash
gh auth status
```

Init Flow will use the existing GitHub CLI authentication.

It will not require storing GitHub credentials in its own
configuration files.

## Visual Studio Code

Install Visual Studio Code using the official instructions:

https://code.visualstudio.com/docs/setup/linux

Verify that the `code` command is available:

```bash
command -v code
```

The initial version of Init Flow will use this command to open
newly created projects.


### Install Init Flow

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/jacivaldocarvalho/init-flow.git
cd init-flow
```

Make the installer executable:

```bash
chmod +x scripts/install.sh scripts/initflow
```

Run the safe installer:

```bash
./scripts/install.sh
```

The installer creates a symbolic link at:

```text
~/.local/bin/initflow
```

It checks for existing files and symbolic links before installation.

The installer will not overwrite an existing file, replace a conflicting symbolic link, or automatically modify shell configuration files.

If Init Flow is already installed from the same source, the installer exits successfully without making changes.

### Configure PATH

If `~/.local/bin` is not already in your `PATH`, add it to your shell configuration.

For Bash:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Only add this configuration if it is not already present.

### Verify Installation

```bash
command -v initflow
initflow --version
initflow --help
```

Expected version:

```text
Init Flow v0.1.0-dev
```

### Security Considerations

Init Flow does not require administrator privileges for local installation.

Review [Security and Safe Usage](security.md) for additional information about installation safeguards, repository visibility, and known limitations.


## Create Your First Project

Once the CLI is available:

```bash
initflow create my-project
```

By default, Init Flow is planned to create projects under:

```text
~/projects/
```

The command will initialize a local Git repository, create a
public GitHub repository, configure the remote, and open the
project in Visual Studio Code.

## Updating Init Flow

For a Git-based installation, updates will be performed from
the cloned repository:

```bash
git pull --ff-only
```

The symbolic link will continue pointing to the updated CLI.

## Troubleshooting

If you encounter installation or configuration problems,
refer to the [Troubleshooting Guide](troubleshooting.md).

## Security Notes

- Never share GitHub authentication tokens.
- Avoid running installation scripts from untrusted sources.
- Review scripts before executing them.
- Do not run Init Flow with `sudo`.
- Keep Git and GitHub CLI updated.


## Uninstallation

Init Flow provides a safe local uninstaller.

Navigate to the cloned Init Flow repository:

```bash
cd /path/to/init-flow
```

Run the uninstaller:

```bash
./scripts/uninstall.sh
```

The uninstaller removes only the `~/.local/bin/initflow` symbolic link when it points to the executable in the current source directory.

The uninstaller:

- Does not require administrator privileges.
- Does not remove the source repository.
- Does not delete user projects or GitHub repositories.
- Does not modify shell configuration files.
- Refuses to remove regular files or links to other installations.
- Supports repeated execution safely.

After uninstallation, the source code remains available for future installation.
