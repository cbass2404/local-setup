 export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

autoload -U add-zsh-hook

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    echo "Node version matches version in use"
    if [ "$nvmrc_node_version" = "N/A" ]; then
      echo "Node version not found locally, installing new version"
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      echo "Node version does not match required version, using different version"
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

if [[ $PWD/ = /Users/cory/dev/Yum/** ]]; then 
  export CI_JOB_TOKEN=glpat-KiNZStEYrUBsSYJxjYSN
  echo CI_JOB_TOKEN set
  export PACKAGE_REGISTRY_TOKEN=glpat-KiNZStEYrUBsSYJxjYSN
  echo PACKAGE_REGISTRY_TOKEN set
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
source <(ng completion script)
