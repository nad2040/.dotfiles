# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME/.zsh}/.zsh_plugins.txt

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode
set -o vi

autoload -U compinit && compinit
autoload -U colors && colors

setopt nonomatch
setopt pushd_ignore_dups
setopt autopushd

SAVEHIST=10000
HISTSIZE=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS


export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
# export PS1="%B%F{blue}%n%b%f@%F{green}%m %F{yellow}%2~ %f% "
export ZSH="$HOME/.zsh"

source "$ZSH/alias.zsh"
source "$ZSH/function.zsh"

# autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"

# Handle Mac platforms
CPU=$(uname -p)
if [[ "$CPU" == "arm" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    alias oldbrew=/usr/local/bin/brew
else
    export PATH="/usr/local/bin:$PATH"
fi

export MC="$HOME/Library/Application Support/minecraft/"
export WORK="$HOME/Desktop/work/"
export HOMEBREW_GITHUB_API_TOKEN=`cat ~/.homebrewapi`
export HOMEBREW_NO_INSTALL_CLEANUP=

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/Users/danliu/.local/bin:$PATH"
export PATH="/Users/danliu/bin:$PATH"

export MANPATH="/usr/local/share/man:$MANPATH"

eval "$(zoxide init zsh --cmd cd)"

# opam configuration
[[ ! -r /Users/danliu/.opam/opam-init/init.zsh ]] || source /Users/danliu/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
