export PATH=~/bin:$PATH
export NODEBREW_ROOT=$(brew --prefix)/var/nodebrew
[ -d $NODEBREW_ROOT/current ] && export PATH=$NODEBREW_ROOT/current/bin:$PATH

# LC_ALLがja_JP.UTF-8になっていない場合、wineで起動する環境も英語ロケールになってしまうため、日本語ロケールを設定する。
export LC_ALL=ja_JP.UTF-8

if [[ "$OSTYPE" =~ ^darwin ]]; then
    # for brew-file
    export HOMEBREW_BREWFILE=~/Brewfile.local
    #If you want to automatically update Brewfile after brew install/uninstall, please use brew-wrap.
    if [ -f $(brew --prefix)/etc/brew-wrap ];then
      source $(brew --prefix)/etc/brew-wrap
    fi

    # for bash-completion2(bash 4+)
    #if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
    #  . $(brew --prefix)/share/bash-completion/bash_completion
    #fi
    # for bash-completion(bash 3)
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    # for java
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi

[ -f ~/.aliases ]&& source ~/.aliases
[ -f ~/.bashrc.personal ]&& . ~/.bashrc.personal
[ -f ~/.bashrc.local ]&& . ~/.bashrc.local
