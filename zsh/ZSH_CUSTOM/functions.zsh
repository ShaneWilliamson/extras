function rebase () {
  if [ $# -ne 1 ]; then
    echo "1 argument expected; you must provide the commit hash/branch you wish to rebase onto"
    return
  fi
  git rebase --exec 'git commit --amend --no-edit -n -S' "$1"
}

function rebasei () {
  if [ $# -ne 1 ]; then
    echo "1 argument expected; you must provide the commit hash/branch you wish to rebase onto"
    return
  fi
  git rebase -i --exec 'git commit --amend --no-edit -n -S' "$1"
}

function readmd () {
  if [ $# -ne 1 ]; then
    echo "1 argument expected; provide the markdown-formatted file you wish to view"
    return
  fi
  pandoc "$1" | lynx -stdin -vikeys -nopause
}

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
