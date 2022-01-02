#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
XCODE_VERSION=${1:+"-$1"}

XCODE_RESOURCES_DIR=/Applications/Xcode${XCODE_VERSION}.app/Contents/Frameworks/IDEKit.framework/Versions/A/Resources
XCODE_USER_DATA_DIR=$HOME/Library/Developer/Xcode/UserData

if [[ -d $XCODE_RESOURCES_DIR ]]; then
    ln -sf "${CURRENT_DIR}/IDETextKeyBindingSet.plist" "${XCODE_RESOURCES_DIR}"
fi

if [[ -d $XCODE_USER_DATA_DIR ]]; then
    ln -sf "${CURRENT_DIR}/KeyBindings/" "${XCODE_USER_DATA_DIR}"
fi
