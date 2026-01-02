# vim: foldmethod=marker ts=4 sw=4
# editor {{{
# Prefer neovim over vim over vi
EDITOR=/usr/bin/vim
export EDITOR
# }}}
# R {{{
# littler scripts distributed with the littler package
PATH=/usr/local/lib/R/site-library/littler/examples:"${PATH}"
PATH=/usr/lib/R/site-library/littler/examples:"${PATH}"

# Path where the R sources are
export RTOP=~/svn/R
# }}}
# Julia {{{
alias julia='/home/jranke/git/julia/julia'
# }}}
# debian {{{
export DEBEMAIL=jranke@uni-bremen.de
export DEBFULLNAME="Johannes Ranke"
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
#shopt -s histappend
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
# {{{varia
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# }}}
# {{{ local/bin
PATH=~/.local/bin:"${PATH}"
export PATH
# }}}
# {{{ reticulate
export RETICULATE_PYTHON=/usr/bin/python3
export RETICULATE_AUTOCONFIGURE=FALSE 
# }}}
# ripgrep->fzf->vim [QUERY] from https://junegunn.github.io/fzf/tips/ripgrep-integration/
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

