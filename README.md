[![Build Status](https://travis-ci.org/sigo/polish-dictionary.svg?branch=master)](https://travis-ci.org/sigo/polish-dictionary)


# polish-dictionary

Polish dictionary, with everyday automated build; as `.txt` plain file.

**Dictionary status:**

- [permalink to dictionary](https://raw.githubusercontent.com/sigo/polish-dictionary/master/dist/pl.txt) (always newest version),
- generation date: Wed, 26 Sep 2018 18:08:09 +0000,
- number of words: 4075569.

If there's no updates for a few days - it's normal. Just dictionary doesn't have any updates at this moment.


## For what?

Use it for whatever you need:

- prepare dictionary for applications you're using,
- prepare passwords list 😎 (just for educational purpose only, of course),
- use it in your words-game,
- waste ton of paper sheets by printing whole dictionary.


## Why?

Some time ago I've created [Polish dictionary for JetBrains IDEs](https://github.com/sigo/jetbrains-polish-dictionary). I'd like to update it automatically. Unfortunately I didn't found any automated Polish dictionary sources.

So... I just created it.

This repository doesn't have any connections with JetBrains or any other applications. It is just `.txt` dictionary.


## How?

Group of good people from <https://sjp.pl/> created and maintaining probably most up-to-date and valuable Polish dictionary in the world. However, they only provide [their work](https://sjp.pl/slownik/en/) as aspell, ispell and myspell dictionary packages.

Every day, this _library_, pull newest available aspell dictionary, dump it and push back to repository.


## Credits

- [SJP team](https://sjp.pl/), for best Polish dictionary.


## Licenses

- All code, scripts etc. in this repository is licensed with **MIT license**.
- One exception is dictionary itself. It is licensed with: **GPL 2, LGPL 2.1, MPL 1.1, CC BY 4.0 and Apache 2.0** ([details](https://sjp.pl/slownik/en/)).
