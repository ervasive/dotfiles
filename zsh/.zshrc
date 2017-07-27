#!/bin/bash

# ------------------------------
# Zplug
# ------------------------------

# shellcheck source=/dev/null
source "$HOME/.dotfiles/zsh/.zplug/init.zsh"

# Oh-my-zsh stuff
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/misc", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/bower", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

zstyle :omz:plugins:ssh-agent agent-forwarding on

# Plugins
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug load
# ------------------------------
# Zplug - END
# ------------------------------

#
# Preferred editor for local and remote sessions
# ------------------------------
export EDITOR='nvim'

#
# Vim/Neovim session restore
# ------------------------------
function nvim() {
    if test $# -gt 0; then
        env nvim "$@"
    elif test -f Session.vim; then
        env nvim -S
    else
        env nvim -c Obsession
      fi
}

#
# Update dotfile dependencies (plugins and stuff)
# ------------------------------
function udd() {
  echo "============================================================"
  echo "Updating Dotfiles submodules..."
  echo "============================================================"
  cd ~/.dotfiles && git submodule foreach --recursive git pull origin master

  # Zplug
  echo ""
  echo ""
  echo "============================================================"
  echo "Updating ZSH plugins..."
  echo "============================================================"
  zplug update

  # Tmux plugin manager
  echo ""
  echo ""
  echo "============================================================"
  echo "Updating Tmux plugins..."
  echo "============================================================"
  $HOME/.dotfiles/tmux/.tmux/plugins/tpm/bin/update_plugins all

  # Neovim
  echo ""
  echo ""
  echo "============================================================"
  echo "Updating Neovim plugins & plugin manager..."
  echo "============================================================"
  nvim --headless -c 'PlugUpdate' -c 'PlugUpgrade' -c 'qa!' > /dev/null 2>&1
}

#
# Update system installed packages
# ------------------------------
function usp() {
  # Brew packages
  if hash brew 2>/dev/null; then
    echo "============================================================"
    echo "Updating Brew packages..."
    echo "============================================================"
    brew update && brew upgrade
  fi

  # Yarn packages
  if hash yarn 2>/dev/null; then
    echo ""
    echo ""
    echo "============================================================"
    echo "Updating Yarn packages..."
    echo "============================================================"
    yarn global upgrade
  fi

  # NPM packages
  if hash npm 2>/dev/null; then
    echo ""
    echo ""
    echo "============================================================"
    echo "Updating NPM packages..."
    echo "============================================================"
    npm update -g
  fi

  # Composer packages
  if hash composer 2>/dev/null; then
    echo ""
    echo ""
    echo "============================================================"
    echo "Updating Composer packages..."
    echo "============================================================"
    composer global update
  fi

  # Stack packages
  if hash stack 2>/dev/null; then
    echo ""
    echo ""
    echo "============================================================"
    echo "Updating Stack..."
    echo "============================================================"
    stack update && stack upgrade
  fi

  # Pip packages
  if hash pip 2>/dev/null; then
    echo ""
    echo ""
    echo "============================================================"
    echo "Updating Python packages..."
    echo "============================================================"
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  fi

  # Pip3 packages
  if hash pip3 2>/dev/null; then
    echo ""
    echo ""
    echo "============================================================"
    echo "Updating Python 3 packages..."
    echo "============================================================"
    pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  fi
}

# Copy text to system clipboard (https://github.com/wincent/clipper)
# ------------------------------
alias clip="nc -U ~/.clipper.sock"

#
# Additional pathes
# ------------------------------
export PATH="/usr/local/sbin:$HOME/.local/bin:$PATH"

if hash stack 2>/dev/null; then
  PATH="$PATH:`stack path --bin-path`"
fi

if hash npm 2>/dev/null; then
  PATH="$HOME/.node_modules/bin:$PATH"
fi

if hash composer 2>/dev/null; then
  PATH="$HOME/.composer/vendor/bin:$PATH"
fi

if hash ruby 2>/dev/null && hash gem 2>/dev/null; then
  PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
# ------------------------------
[ -f ~/.localrc ] && . ~/.localrc
