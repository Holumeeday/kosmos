# playkosmos_v3

A new Flutter project.

## Getting Started

---

# Git Hooks

### Setting Up Pre-Commit Hook

1. Open your terminal and navigate to the project directory.

2. Make the script executable:

In the project directory run...

_Windows_
```bash
git config core.hooksPath '.githooks/'
```

_Linux/MacOS_
```bash
git config core.hooksPath '~/.githooks'
```

---

The pre-commit hook will automatically run before each commit. If there are mismatches in localizations, it will print error messages and prevent the commit.

### Bypassing the Pre-Commit Hook

If you need to bypass the pre-commit hook for a specific commit, you can use the `--no-verify` option with the `git commit` command:

```bash
git commit --no-verify -m "Your commit message"
```

This will skip the pre-commit hook for the current commit.

---

**Note:** Ensure that you have Dart installed on your machine, and the paths in the pre-commit script are correctly set according to the project.

--- 

