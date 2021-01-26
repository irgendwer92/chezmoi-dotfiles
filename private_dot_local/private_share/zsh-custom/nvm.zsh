# ln -s $(pwd)/nvm.zsh ~/.oh-my-zsh/custom/nvm.zsh

# INSTALL NVM:
# export NVM_DIR="$HOME/.nvm" && (git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR" && cd "$NVM_DIR" && git fetch --tags origin && git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`)


# load nvm and hook the cd command
# to look for a .nvmrc in the current directory
# and activate the specified node version

# possible locations for nvm
# the first match is used
POSSIBLE_LOCATIONS="/usr/share/nvm:$HOME/.nvm"

# find nvm install location
for p in $(echo $POSSIBLE_LOCATIONS | tr ":" "\n"); do
  if [[ -r $p ]]; then
    NVM_PATH="$p"
    break;
  fi
done

if [[ -d $NVM_PATH ]]; then

  # configure nvm download folder
  [ -z "$NVM_PATH" ] && export NVM_DIR="$HOME/.nvm"
  
  # activate node version manager
  source "$NVM_PATH/nvm.sh"
  source "$NVM_PATH/bash_completion"
  # source "$NVM_PATH/install-nvm-exec"
  
  # place this after nvm initialization!
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"
  
    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
  
      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
  
fi
