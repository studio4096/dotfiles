PATH=
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi
export PATH=~/bin:$PATH

export LANG=ja_JP.UTF-8

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


