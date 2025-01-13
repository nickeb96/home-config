#!/bin/sh

defaults write com.apple.SoftwareUpdate MajorOSUserNotificationDate -date "$(date -d "$(defaults read com.apple.SoftwareUpdate MajorOSUserNotificationDate) + 6 months")"
