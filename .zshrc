export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME/.zsh}/.zsh_plugins.txt

source <(fzf --zsh)

# vim mode
set -o vi
bindkey -v

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

export MC="$HOME/Library/Application Support/minecraft/"
export WORK="$HOME/Desktop/work/"
export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.homebrewapi)
export HOMEBREW_NO_INSTALL_CLEANUP=

export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/danliu/.local/bin:$PATH"
export PATH="/Users/danliu/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"

export MANPATH="/usr/local/share/man:$MANPATH"

eval "$(zoxide init zsh --cmd cd)"

# opam configuration
[[ ! -r /Users/danliu/.opam/opam-init/init.zsh ]] || source /Users/danliu/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# source $(brew --prefix autoenv)/activate.sh
# AUTOENV_ENABLE_LEAVE="yes"

source <(kubectl completion zsh)

eval "$(starship init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/danliu/.lmstudio/bin"
# End of LM Studio CLI section

eval "$(direnv hook zsh)"
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
