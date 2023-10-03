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

weather(){ curl "wttr.in/newyork"; }
moon(){ curl "wttr.in/Moon"; }
cmdfu(){ curl "https://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext" --silent | bat -l bash; }
