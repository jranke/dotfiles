# vim: foldmethod=marker ts=4 sw=4
# editor {{{
# Prefer neovim over vim over vi
if [ -e /usr/bin/nvim ]
then
    EDITOR=/usr/bin/nvim
else 
    if [ -e /usr/bin/vim ]
    then
		EDITOR=/usr/bin/nvim
    else
		EDITOR=/usr/bin/vi
    fi
fi
# }}}
# R {{{
# littler scripts distributed with the littler package
PATH=/usr/local/lib/R/site-library/littler/examples:"${PATH}"

# RPython
export RPYTHON_PYTHON_VERSION=3

# Vim-R-plugin
# From r-plugin-bash-setup help page in Vim-R-plugin (Debian package 1.2-1)
# Change the TERM environment variable (to get 256 colors) and make Vim 
# connect to th X Server even if running in a terminal emulator (many of 
# the plugin features depend on this). Now only needed for "old" vim
# like vim 7.4 from Debian stable
if [ "x$DISPLAY" != "x" ]
then
		if [ "screen" = "$TERM" ]
		then
				export TERM=screen-256color
		else
				export TERM=xterm-256color
		fi
		alias vim='vim --servername VIM'
fi

alias tarxz='tar --use-compress-program=pxz -c -v -f'

# Path where the R sources are
export RTOP=~/svn/R
# }}}
# debian {{{
export DEBEMAIL=jranke@uni-bremen.de
export DEBFULLNAME="Johannes Ranke"
# }}}
# rdkit {{{
# RDKIT (commented out on 2015-10-02 as I am using the Debian package python-rdkit
#export RDBASE="$HOME/git/rdkit"
#export LD_LIBRARY_PATH="$RDBASE/lib"
#export PYTHONPATH="${PYTHONPATH}:$RDBASE:$HOME/ariance/aeras/libreoffice:$HOME/py"
# }}}
# prompt {{{
force_color_prompt=yes

# identify the current chroot 
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
				# We have color support; assume it's compliant with Ecma-48
				# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
				# a case would tend to support setf rather than setaf.)
				color_prompt=yes
		else
				color_prompt=
		fi
fi

source ~/.git-prompt.sh

if [ "$color_prompt" = yes ]; then
		PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1)\$ "
else
		PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$(__git_ps1)\$ "
fi
unset color_prompt force_color_prompt
# }}}
# history {{{
# See bash(1) for more options
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# }}}
# ls, dir and grep {{{
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -lh'
# }}}
# alert {{{
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# }}}
# bash completion {{{
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# }}}
# {{{varia
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# }}}
export EDITOR PATH
