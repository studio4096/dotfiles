# studio4096 team dotfiles

Note: Still in development

## What's in it?

- X Code Command Line Tools installation
- Homebrew installation
- Homebrew packages installation
    - refs. Brewfile
- /etc/paths setting
- dotfiles

and etc..

## Installation

```
curl -fsSL https://raw.githubusercontent.com/studio4096/dotfiles/master/bootstrap.pl | perl -
```

### Options

Available options.

- prefix : checkout directory.
- no-homebrew : without Homebrew.
- no-brewfile : without Brewfile installation.
- osx_defaults : with .
- zsh : with zsh.
- js : with frontend deveropment env.
- php : with php and composer.
- vagrant : with vagrant.
- wordpress : with vccw.(requires vagrant)
- ie : with modern.ie.(requires vagrant)

ex.
```
curl -fsSL https://raw.githubusercontent.com/studio4096/dotfiles/master/bootstrap.pl | perl - --prefix ~/team/dotfiles --js
```

## Uninstallation

未実装。

他のパッケージ群は個別にお願いします

### homebrew
```
grep `brew --prefix` /etc/shells
#ログインシェルと/etc/pathsを戻す
chsh -s /bin/bash
sudo cp -a /etc/paths{.orig,}
cd `brew --prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew
```

