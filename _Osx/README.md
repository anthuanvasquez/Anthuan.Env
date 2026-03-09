# Commands

## Change Screenshots Location

```zsh
defaults write com.apple.screencapture location ~/Documents/Screenshots
killall SystemUIServer
```

## System Preferences

Create 3 Dock spacers:

```zsh
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' && \
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' && \
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' && \
killall Dock
```

## Autohide Dock

```zsh
defaults write com.apple.dock autohide -boolean true && \
killall Dock
```

## Display hidden Finder files/folders

```zsh
defaults write com.apple.finder AppleShowAllFiles -boolean true && \
killall Finder
```
