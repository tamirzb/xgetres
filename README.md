# xgetres

xgetres is a simple utility which prints the value of an X resource.

## Example

    $ cat ~/.Xresources
    simple: 1
    *wildcard: 2
    $ xgetres simple
    1
    $ xgetres foo.wildcard
    2

## Build & installation

First make sure you have libx11.

In order to build, simply run:

    $ make

Then in order to install, run:

    $ sudo make install

Installation location is determined by the `PREFIX` variable
(`/usr/local` by default).
