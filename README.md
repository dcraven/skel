This repository exists to ease the setup of new shell accounts. It contains:

* Shell configurations (bashrc, bash_aliases, inputrc etc)
* Vim configurations (vimrc, etc)
* Fonts
* Any neato scripts I find
* An install script.

The install script attempts to backup any existing dotfiles in a new folder called ~/dotfiles_old, and
creates symlinks in their place that point to the associated files in your local Git cloned repo. If on
a MacOS machine, it tries to install fonts to ~/Library/Fonts, otherwise the fonts will be located in
~/.fonts which will work in most Linux environments.

## Installation
    ./install.sh
    
## Attention MacOS Users
This configuration assumes you are using GNU coreutils rather than the ones shipped with your machine.
This means that without the GNU versions things like `ls` will break. To remedy this, install 
[homebrew](brew.sh) by pasting this in your terminal:

    ruby -e "$(url -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Make a new shell source your `~/.profile` by putting this in your `~/.bash_profile`:

    source ~/.profile

Put the following in your `~/.profile`:

    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH
    source ~/.bashrc

Then type:

    brew install coreutils

And now Bob may or may not be your uncle.

## Warranty
None.

This is a configuration that I like and it works for me. You are free to use it, but at your own risk.
