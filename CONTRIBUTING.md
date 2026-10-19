
# Contributing to Init Flow

Thank you for your interest in contributing to Init Flow!

Init Flow is an open-source project focused on simplifying and automating
software project initialization through a command-line interface.

Contributions of all sizes are welcome, including bug fixes, documentation
improvements, automated tests, and new features.

## Getting Started

1. Fork the repository.
2. Clone your fork locally.
3. Create a branch for your contribution.
4. Make your changes.
5. Test and review your changes.
6. Commit your changes.
7. Open a pull request.

```bash
git clone git@github.com:YOUR_USERNAME/init-flow.git
cd init-flow

git checkout -b feat/my-feature
```

Replace `YOUR_USERNAME` with your GitHub username.

## Branch Naming

Use descriptive branch names with the following prefixes:

- `feat/` - New features.
- `fix/` - Bug fixes.
- `docs/` - Documentation changes.
- `refactor/` - Code improvements without behavior changes.
- `test/` - Test additions or improvements.
- `chore/` - Maintenance tasks.

Examples:

```text
feat/private-repositories
fix/github-auth-validation
docs/installation-guide
test/cli-arguments
```

## Commit Messages

Follow the Conventional Commits specification.

Format:

```text
<type>(optional-scope): <description>
```

Examples:

```text
feat(cli): add project creation command
fix(github): improve authentication validation
docs(readme): update installation instructions
test(cli): add argument validation tests
chore(ci): configure shellcheck workflow
```

Keep commit messages clear, concise, and written in English.

## Code Guidelines

- Use Bash for the initial CLI implementation.
- Follow consistent formatting and naming conventions.
- Quote shell variables appropriately.
- Validate user input and external dependencies.
- Handle errors explicitly.
- Avoid unnecessary external dependencies.
- Keep scripts modular and maintainable.
- Use English for code comments and user-facing messages.
- Never commit credentials, tokens, or sensitive information.

## Testing

Before submitting a pull request:

1. Run available automated tests.
2. Check shell scripts using ShellCheck.
3. Verify that existing functionality remains unaffected.
4. Update documentation when necessary.

Testing commands will be documented as the test suite is implemented.

## Pull Requests

When opening a pull request:

- Clearly describe the proposed changes.
- Explain why the changes are necessary.
- Reference related issues when applicable.
- Include testing information.
- Keep changes focused on a specific objective.

## Reporting Bugs

Use the GitHub issue templates to report bugs.

Include:

- A clear description of the problem.
- Steps to reproduce the issue.
- Expected and actual behavior.
- Operating system and relevant tool versions.
- Logs or error messages when available.

Remove credentials and sensitive information from logs before sharing them.

## Suggesting Features

Feature suggestions are welcome.

Describe the problem being solved, the proposed functionality,
and how it would improve the project.

## License

By contributing to Init Flow, you agree that your contributions
will be licensed under the project's MIT License.
