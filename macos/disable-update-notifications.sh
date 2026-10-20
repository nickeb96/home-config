#!/bin/sh

defaults write com.apple.SoftwareUpdate MajorOSUserNotificationDate -date "$(date '+%F %T %z' -d 'now + 6 months')"

defaults write com.apple.SoftwareUpdate UserNotificationDate -date "$(date '+%F %T %z' -d 'now + 6 months')"

