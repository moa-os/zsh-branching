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
  # 1. List branches with upstream info
  # 2. Keep only those tracking origin/
  # 3. Strip leading “* ” or spaces
  # 4. Cut out just the branch name
  branches=$(
   git branch -vv \
    | grep origin \
    | sed -E '
          s/^\* ([^ ]+).*/* \1/;
          s/^  ([^ ]+).*$/  \1/
        '
  )

  [[ -z $branches ]] && echo "No origin-tracking branches." && return


  printf '%s\n' $branches | fzf \
    --height 40% --reverse --border \
    --preview 'git log --oneline --graph --color=always {1}' \
    --bind "enter:execute(git checkout {1})+abort" \
    --bind "esc:abort"
}


# Your existing alias
alias gbs='git_fzf_branch'

# New convenience aliases
alias gits='git status'
alias gita='git add .'
