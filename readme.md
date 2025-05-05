# zsh-branching

An [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) plugin that enhances your Git workflow by providing a fuzzy-finder interface for branch operations. Powered by [fzf](https://github.com/junegunn/fzf), `zsh-branching` lets you quickly switch branches, delete local branches (soft or force), remove remote branches, and run common Git commands—all from one intuitive UI.

## Features

- **Fuzzy branch selection**: Lists all local branches tracking `origin/*` for easy navigation.
- **Interactive preview**: See a one-line, graph view of commits for any branch before you act.
- **Key bindings**:

  - `Enter` → Checkout the selected branch
  - `D` → Soft-delete local branch (`git branch -d`)
  - `Ctrl-d`→ Force-delete local branch (`git branch -D`)
  - `Ctrl-r`→ Delete remote branch (`git push origin --delete`)
  - `Esc` → Quit without action

- **Reloads after delete**: Continue managing branches without restarting the tool.
- **Convenience aliases**:

  - `gits` → `git status`
  - `gita` → `git add .`

## Requirements

- Zsh (tested on Zsh 5.8+)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [fzf](https://github.com/junegunn/fzf)
- Git

## Installation

### Manual

```bash
# Clone into Oh My Zsh’s custom plugins folder
git clone https://github.com/youruser/zsh-branching.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-branching

# Enable plugin: add to your ~/.zshrc
plugins=( ... zsh-branching )

# Reload your shell
exec zsh
```

### GitHub CLI

```bash
# Use gh to clone
gh repo clone youruser/zsh-branching \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-branching

# Then enable and reload as above
```

## Usage

- Run the fuzzy branch selector:

  ```bash
  gbs
  ```

  Use the displayed key bindings to switch or delete branches.

- Run common Git commands:

  ```bash
  gits  # shows git status
  gita  # stages all changes (git add .)
  ```

## License

Licensed under the [MIT License](LICENSE).
