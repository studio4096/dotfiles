PATH=
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi
export PATH=~/bin:$PATH
export NODEBREW_ROOT=$(brew --prefix)/var/nodebrew
[ -d $NODEBREW_ROOT/current ] && export PATH=$NODEBREW_ROOT/current/bin:$PATH

export LANG=ja_JP.UTF-8
export NODE_ENV=development

typeset -U path PATH
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # for brew-file
    export HOMEBREW_BREWFILE=~/Brewfile.local
    #If you want to automatically update Brewfile after brew install/uninstall, please use brew-wrap.
    #if [ -f $(brew --prefix)/etc/brew-wrap ];then
    #  source $(brew --prefix)/etc/brew-wrap
    #fi

    # for java
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi

