# Arch update counter - plasma widget

![screenshot of the plugin](git-assets/img/screenshot.png)

## Description

Counts the number of pacman update available.

Refresh each 30 minutes, on click or on the interval you set.

`new in 4.0.0` And you can update via the context menu or the middle click of your mouse !

`new in 4.1.0` Custom setting for the update command !

## Dependencies

You need to have the [`pacman-contrib`](https://archlinux.org/packages/extra/x86_64/pacman-contrib/) and the [konsole](https://archlinux.org/packages/extra/x86_64/konsole/) package installed.

Idealy you have `kdialog` too, but it's not mandatory.

## Manual installation

Place the source (`a2n.archupdate.plasmoid` folder) in `~/.local/share/plasma/plasmoids/` or dl via [the KDE store](https://www.pling.com/p/1940819/)

## Configuration

| Name | Description | Result |
|--|--|--|
| Interval configuration | set the interval between each execution of the update check function | the `updater` is launch each X minutes |
| Debug | Enable the debug mode if set to true | Show each command launch by the plasmoid |
| Close at end | if true add the `--noclose` flag into the `konsole` command | Prevent the console to close at the end of the command |
| Command | The command you want to execute when the `update` action is called | Pass the command to `konsole -e` |

### Regarding the customization of the command

Is up to you to double check the command you want to exec.

In no case I'm responsible of anything if your system break due to your command.

The program launch the command with `konsole -e`. So you can test your command or script with `konsole -e "my_command"`.

The default command is: `konsole -e (--noclose) 'sudo pacman -Syu'` where `noclose` is optional.

## Code of conduct, license, authors, changelog, contributing

See the following file :
- [code of conduct](CODE_OF_CONDUCT.md)
- [license](LICENSE)
- [authors](AUTHORS)
- [contributing](CONTRIBUTING.md)
- [changelog](CHANGELOG)
- [security](SECURITY.md)

## Roadmap

- [x] ~~update the ui when `cmd` call `count`~~
- [x] ~~execute db update before the calcul~~
- ~~setup a auto release w/ github action (ci/cd)~~
- [ ] add config :
  - [ ] icon choice
  - [ ] icon color
  - [ ] text color
  - [x] ~~interval choice~~

## Want to participate? Have a bug or a request feature?

Do not hesitate to open a pr or an issue. I reply when I can.

## Want to support my work?

- [Give me a tips](https://ko-fi.com/a2n00)
- [Give a star on github](https://github.com/bouteillerAlan/archupdate)
- [Add a rating and a comment on Pling](https://www.pling.com/p/1940819/)
- [Become a fan on Pling](https://www.pling.com/p/1940819/)
- Or just participate to the developement :D

### Thanks !
