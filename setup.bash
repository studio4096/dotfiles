#!/usr/bin/env bash
CURRENT=$(cd $(dirname $0) && pwd)
# TODO : Write usage.
usage_exit() { cat << __USAGE__ 1>&2
Usage: $0 -p prefix [-o php [-o ie [-o vagrant] ... ] ]
options:
    p : install directory prefix
    o : (OSX only)zsh, osx_defaults, js, php, ie, vagrant, wordpress
    h : Show help
__USAGE__
exit 1;}

OPTIND_OLD=$OPTIND
OPTIND=1
while getopts p:o:hy OPT
do
    case $OPT in
        p)  prefix=$OPTARG
            ;;
        o)  arr_opt_feature+=($OPTARG)
            ;;
        h)  usage_exit
            ;;
        y)  flag_yes=1
            ;;
        \?) usage_exit
            ;;
    esac
done
shift $(($OPTIND - 1))
OPTIND=$OPTIND_OLD
[[ -n "$prefix" ]] || prefix=$HOME/studio4096/dotfiles

if [[ "$OSTYPE" =~ ^darwin ]]; then
    echo "OSTYPE is $OSTYPE "
    osx_product_version=$(sw_vers -productVersion)
    osx_major_version=`echo ${osx_product_version} | cut -d '.' -f 1`
    osx_minor_version=`echo ${osx_product_version} | cut -d '.' -f 2`
    echo $osx_major_version
    echo $osx_minor_version
    echo "OS X product version : $osx_product_version"
fi
user_group=$(id -g -n)
echo "Your user and group : $USER:$user_group"

# functions
in_array() {
    local haystack=${1}[@]
    local needle=${2}
    for i in ${!haystack}; do
        if [[ ${i} == ${needle} ]]; then
            return 0
        fi
    done
    return 1
}
function notify() {
    local msg=$1; shift
    local subtitle=$1; shift
    local title=$1; shift
    [[ "$OSTYPE" =~ ^darwin ]]&& return
    [[ $osx_major_version -lt 10 ]]&&[[ $osx_minor_version -lt 9 ]]&& return

    [[ -z "$title" ]]&& title=Terminal
    local script;
    script="display notification \"$msg\" with title \"$title\""
    [[ -n "$subtitle" ]]&& script+=" subtitle \"$subtitle\""
    echo "$script"|osascript
}


function echo_separator() {
    local title="$1"
    echo -e "\n### $title ############################################################"
}
function abort() {
    local msg=$1
    echo $msg
    exit 1
}

function install_xcode_clt () {
    echo_separator 'X Code Command Line Tools'
    echo 'Check that X Code Command Line Tools was installed.'
    #refs. http://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed
    if [[ "$osx_product_version" =~ ^10\.10\. ]]; then 
        xcode-select -p
        ret_status=$?
    elif [[ "$osx_product_version" =~ ^10\.9\. ]]; then 
        pkgutil --pkg-info=com.apple.pkg.CLTools_Executables
        ret_status=$?
    elif [[ "$osx_product_version" =~ ^10\.8\. ]]; then 
        pkgutil --pkg-info=com.apple.pkg.DeveloperToolsCLI
        ret_status=$?
    else
        echo 'Unsupported OS X version.'
        echo 'Cannot check for Homebrew installation.'
        echo 'Please install manually.'
        sleep 3
    fi
    if [[ $ret_status != 0 ]]; then
        echo 'Install X Code Command Line Tools.'
        cat << 'EOF'
It will produce a similar alert box. 
"Get Xcode", "Not Now", "Install"
-> Click "Install" to download and install Xcode Command Line Tools.
EOF
        sleep 3
        xcode-select --install
    else
        echo 'X Code Command Line Tools is already installed.'
    fi
    read -p 'Press enter key if done correctly.'
}


function install_homebrew () {
    echo_separator 'Install Homebrew'
    if [ -x "`which brew`" ]; then
        echo "Homebrew is already installed."
        return
    fi

    echo "Homebrew is not installed."
    # TODO : multiple users対応どうしようか...
    # /usr/localのパーミッション、グループの書き込みを許可。
    # umaskでグローバルにやるなら/etc/profileの最終行に以下を追加する形になるが、
    # secondary user側の.bashrcとかに書く運用でカバーする。
    # $ umask 0002

    brew_prefix=/usr/local
    echo "chgrp -R $user_group $brew_prefix"
    sudo chgrp -R $user_group $brew_prefix
    echo "chmod g+w $brew_prefix"
    sudo chmod g+w $brew_prefix

    # install home brew
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

function modified_etc_paths() {
    echo_separator 'Add prefix of Homebrew(/usr/local/bin) to /etc/paths to .'
    # modified path
    # /usr/local/binを一番上に持ってくる
    # TODO /usr/local/sbin/
    paths_file=/etc/paths
    if [ ! -f ${paths_file}.orig ]; then
        echo 'Backup /etc/paths. as /etc/paths.orig'
        sudo cp -a ${paths_file}{,.orig}
    fi
    echo 'Edit /etc/paths.'
    num=$(grep -n "^$(brew --prefix)/bin\$" $paths_file | sed 's/:.*//')
    sudo ed $paths_file << EOF
${num}t0
$(($num+1))d
wq
EOF
    # set PATH
    PATH=
    if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
    fi
    echo $PATH
}

function bundle_brewfile () {
    echo_separator 'Bundle Homebrew formula'
    # BrewfileがHomebrewのデフォルトでは無くなったので
    # rcmdnkさんのbrew-fileを使う
    # gitリポジトリとも連携できる
    brew install rcmdnk/file/brew-file
    # 現状をリストアップする場合
    # # brew file init
    # cask可能なappのリストアップ。TODO python のエラー出るけどよくわからじ...
    # # brew file casklist


    brew file install -f $HOME/Brewfile
    # リポジトリ
    # # brew file pull
    # # brew file push
    source $HOME/.bash_profile
    # bundle Brewfile.local
    if [ -f $HOMEBREW_BREWFILE ]; then
        brew file install
    fi
    notify 'Homebrew fomulas are installed.'
}

function show_manual_operations() {
    cat << 'EOF'
## Manually configure iTerm.
Preferences…
    General>Quit when all windows are closed -> Check ON
    General>Confirm closing multiple sessions -> Check OFF
    General>Confirm "Quit iTerm2 (⌘Q)" command -> Check OFF
    General>Characters considered part of word for selection -> Add "@" and ":"
    Profile>Terminal>Scrollback Lines -> 10000に増やす
    Profile>Terminal>Save lines to scroll back when an app status bar is present -> Check ON
    Profile>Terminal>Report Terminal Type -> Change to "xterm-256color"
    Profile>Terminal>Silence bell -> Check ON
    Profile > Text > Double-Width Characters > Treat ambiguous-width characters as double width. -> Check ON
EOF
}

# --- MAIN ------------------------------
if [[ "$OSTYPE" =~ ^darwin ]]; then

    install_xcode_clt
    install_homebrew
    modified_etc_paths
    bundle_brewfile
    in_array arr_opt_feature js           && bash $CURRENT/bin/setup_frontend_env.bash
    in_array arr_opt_feature osx_defaults && bash $CURRENT/bin/setup_osx_defaults.bash
    in_array arr_opt_feature php          && bash $CURRENT/bin/setup_php_env.bash
    in_array arr_opt_feature vagrant      && bash $CURRENT/bin/setup_vagrant.bash
    in_array arr_opt_feature wordpress    && bash $CURRENT/bin/setup_wordpress_env.bash
    in_array arr_opt_feature ie           && bash $CURRENT/bin/setup_modern.ie.bash
    in_array arr_opt_feature zsh          && bash $CURRENT/bin/setup_zsh.bash
fi
#bash $CURRENT/setup_dotfiles.bash

# TODO $HOME以下にしか対応していない(prefixも同様。)
mkdir -p $HOME/bin
(
    cd $HOME
    for f in $(cat << 'EOF'
.aliases
.bash_profile
.bashrc
.gitconfig
.gitignore
.gitmessage
.zshenv
.zshrc
Brewfile
EOF
); do
        [ -f $HOME/$f ] && cp -p $f ${f}.bk$(date +%Y%m%d)
        ln -s $prefix/$f
    done
)
for f in `ls $prefix/.*.sample $prefix/*.sample`; do
    cp -p $f $HOME/$(basename $f | sed 's/\.sample$//')
done

show_manual_operations
notify 'Install was done.'
