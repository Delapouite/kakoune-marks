# kakoune-marks

[kakoune](http://kakoune.org) plugin to highlight previously saved selections (marks).

## Install

Add `marks.kak` to your autoload dir: `~/.config/kak/autoload/`.

## Usage

Craft some selections and save them in a register. For example `"aZ` to store them
in the `a` register. Move along and do some other stuff…

Later you need to restore these selections but you have a hard time remembering their
precise locations: use the `:show-marks` command to highlight them.
Use `:hide-marks` when you don't need this extra layer of info anymore.

## Screenshots

Selections being saved in the `a` register.

![selections](https://raw.githubusercontent.com/delapouite/kakoune-marks/master/01.png)

Marks being displayed with `:show-marks`. Letters `a` are shown on boundaries (anchor / cursor).

![marks](https://raw.githubusercontent.com/delapouite/kakoune-marks/master/02.png)

## See also

- [kakoune-mark](https://github.com/fsub/kakoune-mark) - highlight all occurrences of one or several words in different colors
- [kakoune-registers](https://github.com/Delapouite/kakoune-registers)
- [kakoune-easymotion](https://github.com/danr/kakoune-easymotion) - inspiration for the "veil" effect.

## Licence

MIT
