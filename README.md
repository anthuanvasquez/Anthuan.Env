# FAANG-style Dotfiles 🚀

This repository contains my personal, automated, and modular configuration. It is designed for extreme portability and declarative configuration across macOS, Linux, and WSL.

## 🏗️ Structure

- `home/`: Files that are symlinked directly to your `$HOME`.
- `config/`: Modular logic (shell, git, vscode).
- `packages/`: Declarative package lists (Brewfile, etc).
- `os/`: OS-specific system adjustments.
- `bin/`: Personal binaries and scripts added to your `$PATH`.
- `modules/`: Modular installation and configuration for specific tools (Node, Docker, etc).
- `scripts/`: Internal logic for repository management (linking, backups).

## 🚀 Quick Install

To set up a new machine from scratch:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/anthuanvasquez/dotfiles/master/bootstrap)"
```

## 🛠️ Local Execution

If you have already cloned the repository:

```bash
./install
```

## 🧩 Design Principles

1. **Portability**: Works across multiple platforms.
2. **Modularity**: Clear separation between environment, aliases, functions, and tools.
3. **Automation**: A single command to recreate the entire environment.
4. **Declarative**: The repository is the source of truth for the machine's state.

---
Maintained by [Anthuan Vasquez](https://github.com/anthuanvasquez)
