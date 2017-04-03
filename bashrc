RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"

# Debian packaging envs
export DEBFULLNAME="Dennis Craven"
export EMAIL="dcraven@gmail.com"
export DEBEMAIL="dcraven@gmail.com"
export DEBUILD_DPKG_BUILDPACKAGE_OPTS="-i"
export QUILT_PATCHES=debian/patches

export NODE_PATH=~/.node_modules

# Make Vim the default terminal editor
export EDITOR=/usr/bin/vim

# Make grep beeeeautiful!
export GREP_OPTIONS='--color=auto'

export PAGER='less -F'

# Make bash use the full width of the term after it's reasized
shopt -s checkwinsize
shopt -s cdspell
shopt -s cmdhist

# Turn on grep colorization
  if echo hello | grep --color=auto l &>/dev/null 2>&1; then
    export GREP_OPTIONS="--color=auto $GREP_OPTIONS"
    export GREP_COLOR='0;32'
  fi

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

PATH=/usr/local/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# MAC: HOMEBREW: Add gnu-tools folder with proper names to $PATH
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Add .bin direcory to $PATH if it exists
if [ -d "$HOME/.bin" ]; then
   PATH="$HOME/.bin:$PATH"
fi

# Define credentials here
if [ -f ~/.bash_creds ]; then
    . ~/.bash_creds
fi

# Define your own aliases here ...
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Define your own functions here ...
if [ -f ~/.bash_functions ]; then
   . ~/.bash_functions
fi

# Source the completions script
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Custom host-specific settings and variables can go here
if [ -f ~/.bashrc.$HOSTNAME ]; then
   . ~/.bashrc.$HOSTNAME
fi

# If we have it installed, make use of the cdargs shortcuts
if [ -f /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
   source /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi

# Remove duplicate entries from history
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:l:ls:ll:[bf]g:clear:exit:history:history *:history|*:cd:cd -:df"

# Keeps lots of history
export HISTFILESIZE=1280000
export HISTSIZE=1280000

# Prompt
PS1="${debian_chroot:+($debian_chroot)}\u@\h:\[\033[32m\]\w $YELLOW\$(parse_git_branch)\[\033[00m\]> "


