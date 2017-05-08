#!/bin/sh

# ------------------------------
# Zplug
# ------------------------------
source $HOME/.zplug/init.zsh

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

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
# ------------------------------
# Zplug - END
# ------------------------------

#
# Preferred editor for local and remote sessions
# ------------------------------
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

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

# Copy text to system clipboard (https://github.com/wincent/clipper)
# ------------------------------
alias clip="nc -U ~/.clipper.sock"

#
# Additional pathes
# ------------------------------
export PATH="/usr/local/sbin:$HOME/.local/bin:$PATH"


# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
# ------------------------------
[ -f ~/.localrc ] && . ~/.localrc
