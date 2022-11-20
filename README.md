# Arch update counter - plasma widget

![screenshot of the plugin](git-assets/img/screenshot.png)

## Description

Counts the number of pacman update available.

Refresh each 30 minutes or on click.

## Installation

Place the source (`archupdate-plasmoid` folder) in `~/.local/share/plasma/plasmoids/` or dl via [the KDE store](https://store.kde.org/browse?cat=418&ord=latest)

## Configuration

| Name | Description | Result |
|--|--|--|
| Interval configuration | set the interval between each execution of the update check function | the `updater` is launch each X minutes |

## Todo

- [x] update the ui when `cmd` call `count`
- [ ] execute db update before the calcul
- [ ] add config :
  - [ ] icon choice
  - [ ] icon color
  - [ ] text color
  - [x] interval choice

## Want to participate ?

Do not hesitate to open a mr or an issue.

