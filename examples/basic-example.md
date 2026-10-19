
# Basic Example — Creating a GitHub Project

This example demonstrates how Init Flow will simplify the
process of creating a new software project.

> **Status:** This example describes the planned behavior of
> Init Flow. The CLI is currently under development.

## Scenario

A developer wants to create a new project named `my-api`
and publish its source code on GitHub.

Without automation, this process requires several
manual commands.

Init Flow aims to simplify these steps.

## 1. Traditional Workflow

Create a local directory:

```bash
mkdir -p ~/projects/my-api
cd ~/projects/my-api
```

Initialize Git:

```bash
git init -b main
```

Create a public GitHub repository and configure the remote:

```bash
gh repo create my-api \
    --public \
    --source=. \
    --remote=origin
```

Open the project in Visual Studio Code:

```bash
code .
```

This workflow requires multiple commands and repeated
configuration for every new project.

## 2. Init Flow Workflow

With Init Flow, the same initialization process will
require only one command:

```bash
initflow create my-api
```

The CLI will automatically:

1. Validate the project name.
2. Check the required dependencies.
3. Verify GitHub authentication.
4. Check for existing local and remote projects.
5. Create the project directory.
6. Initialize Git with the `main` branch.
7. Create the public GitHub repository.
8. Configure the Git remote.
9. Open the project in Visual Studio Code.

## 3. Expected Terminal Output

The output may look similar to:

```text
$ initflow create my-api

[INFO] Validating project name...
[INFO] Checking dependencies...
[INFO] Checking GitHub authentication...
[INFO] Checking existing projects...
[INFO] Creating project directory...
[INFO] Initializing Git...
[INFO] Creating GitHub repository...
[INFO] Configuring remote origin...
[INFO] Opening Visual Studio Code...

[SUCCESS] Project created successfully!

Project: my-api
Directory: /home/user/projects/my-api
Repository: https://github.com/username/my-api
Branch: main
```

The actual output will be finalized during CLI implementation.

## 4. Generated Project Structure

The local project will have the following structure:

```text
~/projects/
└── my-api/
    └── .git/
```

The initial release will not automatically generate
a README, `.gitignore`, license, or initial commit.

These features are planned for future releases.

## 5. Add Your First Files

Create a README:

```bash
cd ~/projects/my-api
printf '# My API\n' > README.md
```

Check the repository status:

```bash
git status
```

## 6. Publish Your First Commit

Stage your files:

```bash
git add README.md
```

Create the initial commit:

```bash
git commit -m "chore: initial commit"
```

Push the main branch:

```bash
git push -u origin main
```

The project is now available on GitHub.

## 7. Verify the Repository

Check the configured remote:

```bash
git remote -v
```

View the repository in your browser:

```bash
gh repo view --web
```

## Benefits

Init Flow aims to provide:

- Faster project initialization.
- Consistent Git configuration.
- Fewer repetitive commands.
- Reduced manual setup errors.
- Integration with existing development tools.
- A foundation for future project templates.

## Next Steps

Explore the project documentation:

- [Installation Guide](../docs/installation.md)
- [Usage Guide](../docs/usage.md)
- [Architecture](../docs/architecture.md)
- [Project Roadmap](../docs/roadmap.md)

For planned improvements and new features, visit:

https://github.com/jacivaldocarvalho/init-flow
