# .dotfiles
dotfiles


## Install
```
git init --bare ~/.dotfiles
alias dots="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dots config status.showUntrackedFiles no
dots config core.excludesfile .dotsignore
dots remote add origin git@github.com:nad2040/.dotfiles.git
dots branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
dots fetch --all
dots switch -f macos
dots branch -d master
```
