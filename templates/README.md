[![Build Status](https://travis-ci.org/sigo/polish-dictionary.svg?branch=master)](https://travis-ci.org/sigo/polish-dictionary)


# polish-dictionary

Polish dictionary, with everyday automated build, as `.txt` plain file.

**NOTE: This project is under active development. Do not use it yet.**

**Dictionary status:**

- [permalink to dictionary](https://raw.githubusercontent.com/sigo/polish-dictionary/master/dist/pl.txt) (always newest version),
- generation date: $CREATE_DATE,
- number of words: $WORDS.

If there's no updates for a few days - it's normal. Just dictionary doesn't have any updates at this moment.


## Usage

1. Download dictionary release.
2. Clone repository.
3. Install via `npm` or `yarn`.


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


## How it works?

Group of good people from <https://sjp.pl/> created and maintaining probably most up-to-date and valuable Polish dictionary in the world. However, they only provide [their work](https://sjp.pl/slownik/en/) as aspell, ispell and myspell dictionary packages.

**tl;dr:** Every day, this _library_, pull newest available aspell dictionary, dump it and push back to repository.

1. Every day CI trigger build based on [.travis.yml config](.travis.yml).
    1. Build docker image ([scripts/docker_build.sh](scripts/docker_build.sh)).
    2. Run docker container on built image ([scripts/docker_run.sh](scripts/docker_run.sh)).
    3. Push back dictionary to repository if there's update ([scripts/dictionary_deploy.sh](scripts/dictionary_deploy.sh)).


## Manual generation of dictionary

You can manual generate the dictionary on the system with any shell (e.g. `sh`) and `docker`. With below example, dictionary on your computer will be dumped to `dist/pl.txt`.

It is important to **run scripts from root of the repository**. Executing commands from other directory will return error (sorry, it is just shell scripts 🙃).

```sh
export DOCKER_IMAGE="polish-dictionary"
export DICTIONARY="dist/pl.txt"
./scripts/docker_build.sh
./scripts/docker_run.sh
docker rmi "${DOCKER_IMAGE}"
```

After executing above commands, image and container will be deleted.


## Credits

- [SJP team](https://sjp.pl/), for best Polish dictionary.


## Licenses

- All code, scripts etc. in this repository is licensed with **MIT license**.
- One exception is dictionary itself. It is licensed with: **GPL 2, LGPL 2.1, MPL 1.1, CC BY 4.0 and Apache 2.0** ([details](https://sjp.pl/slownik/en/)).
