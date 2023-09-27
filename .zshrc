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

# autoload -U compinit && compinit

SAVEHIST=10000
HISTSIZE=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PS1="%B%F{blue}%n%b%f@%F{green}%m %F{yellow}%2~ %f% "
alias ls='eza -a --color=always --group-directories-first'
alias ll='eza -alh'
alias tree='eza --tree -a'
alias h='history'
alias v='nvim'
alias brewup='brew update; brew upgrade; brew cleanup -s; brew doctor'
alias ..='cd ..'

alias as='as -arch arm64'
alias ld='ld -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64'

export ZSH="$HOME/.zsh"

# autosuggestions
source "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"

# syntax highlighting
source "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# vim mode
set -o vi

setopt pushd_ignore_dups
setopt autopushd

function ...()
{
  if [ $# -eq 1 ]; then
    i=$1
    while [ $i -gt 0 ]; do
      cd ..
      i=$[$i-1]
    done
  fi
}


function d()
{
  if [ $# -eq 1 ]; then
    cd +$1
  else
    dirs -v
  fi
}

function setjdk() {
  unset JAVA_HOME
  export JAVA_HOME=`/usr/libexec/java_home -v $@`
  echo "JAVA_HOME:" $JAVA_HOME
  java -version
}

function unziphere() {
  if [ $# -eq 1 ]; then
    tmp='tmp'
  else
    tmp=$2
  fi
  mkdir $tmp
  unzip $1 -d $tmp
  mv $tmp/*/* .
  rm -r $tmp
}

function ghlatest() {
#    URL=`curl -s https://api.github.com/repos/$1/$2/releases \
#    | grep browser_download_url \
#    | head -n1 \
#    | cut -d'"' -f4`
#    curl -sOL $URL
    gh release download $(gh release list -R $1/$2 | head -1 | awk -F'\t' '{print $3}') -R $1/$2
}

# handle dotfiles using bare git repo
function dots () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

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


weather(){ curl wttr.in/newyork; }
moon(){ curl wttr.in/Moon; }
cmdfu(){ curl "https://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext" --silent | bat -l bash; }
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export HOMEBREW_GITHUB_API_TOKEN=`cat ~/.homebrewapi`
export HOMEBREW_NO_INSTALL_CLEANUP=FALSE
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

