#!/usr/bin/env bash

# ネットワークボリュームに.DS_Storeを作らない
# Disabling the creation of .DS_Store files on network volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# 撮影した画像のファイル名を変更する
# rename screencaptured file name.
defaults write com.apple.screencapture name capture

# 撮影した画像の保存先を変更する
# change screencaptured file directory.
SCREENCAPTURE_LOCATION=~/Pictures/ScreenCapture
mkdir -p "$SCREENCAPTURE_LOCATION"
defaults write com.apple.screencapture location "$SCREENCAPTURE_LOCATION"

#Show the ~/Library folder
chflags nohidden ~/Library

#Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

killall SystemUIServer
