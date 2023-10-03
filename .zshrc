#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode
set -o vi

autoload -U compinit && compinit
autoload -U colors && colors

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
source "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"

# syntax highlighting
source "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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
export HOMEBREW_NO_INSTALL_CLEANUP=FALSE

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/Users/danliu/.local/bin:$PATH"
export PATH="/Users/danliu/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

