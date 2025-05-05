#!/usr/bin/env zsh
#
# index.bash  ← you can rename to zsh-branching.plugin.zsh
# A small Oh My Zsh plugin to fuzzy‐select and act on Git branches.

# bail out early if Git or fzf aren’t installed
if ! command -v git >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1; then
  return
fi

# The main function: lists origin-tracking branches, lets you pick one,
# then on keypress does checkout, delete, force-delete, or remote-delete.
git_fzf_branch() {
  local branches
  branches="$(git branch -vv | grep origin | awk '{print $1}')"
  # if no branches found, exit
  [[ -z $branches ]] && echo "No origin-tracking branches." && return

  printf '%s\n' $branches | fzf \
    --height 40% --reverse --border \
    --preview 'git log --oneline --graph --color=always {1}' \
    --bind "enter:execute(git checkout {1})+abort" \
    --bind "D:execute(git branch -d {1} && echo \"Soft-deleted {1}\")+reload(printf '%s\n' $branches)" \
    --bind "ctrl-d:execute(git branch -D {1} && echo \"Force-deleted {1}\")+reload(printf '%s\n' $branches)" \
    --bind "ctrl-r:execute(git push origin --delete {1} && echo \"Remote-deleted {1}\")+reload(printf '%s\n' $branches)" \
    --bind "esc:abort"
}

# Expose it via a simple alias
alias gbs='git_fzf_branch'
#!/usr/bin/env zsh
#
# zsh-branching.plugin.zsh
# A small Oh My Zsh plugin to fuzzy‐select and act on Git branches.

# bail out early if Git or fzf aren’t installed
if ! command -v git >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1; then
  return
fi

# Your branch‐helper function
git_fzf_branch() {
  local branches
  branches="$(git branch -vv \
    | grep origin \
    | awk '{print $1 == "*" ? $2 : $1}')"

  [[ -z $branches ]] && echo "No origin-tracking branches." && return

  printf '%s\n' $branches | fzf \
    --height 40% --reverse --border \
    --preview 'git log --oneline --graph --color=always {1}' \
    --bind "enter:execute(git checkout {1})+abort" \
    --bind "D:execute(git branch -d {1} && echo \"Soft-deleted {1}\")+reload(printf '%s\n' $branches)" \
    --bind "ctrl-d:execute(git branch -D {1} && echo \"Force-deleted {1}\")+reload(printf '%s\n' $branches)" \
    --bind "ctrl-r:execute(git push origin --delete {1} && echo \"Remote-deleted {1}\")+reload(printf '%s\n' $branches)" \
    --bind "esc:abort"
}

# Your existing alias
alias gbs='git_fzf_branch'

# New convenience aliases
alias gits='git status'
alias gita='git add .'