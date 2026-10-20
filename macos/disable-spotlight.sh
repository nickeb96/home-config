#!/bin/sh

# disable indexing
sudo mdutil -a -i off

# erase existing indexes
sudo mdutil -a -E

# disable searching and indexing
sudo mdutil -a -d

# disable launch daemon
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist


