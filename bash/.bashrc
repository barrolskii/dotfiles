#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

source $HOME/.bash_shortcuts
source $HOME/.config/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

PS1='[\u@\h \w]$(__git_ps1 " (%s)")\$ '


# Quick source bashrc if adding aliases on the fly
alias sbr="source ~/.bashrc"

alias gp="git push"
alias gs="git status"
alias gd="git diff"
alias gc="git commit"
alias gca="git commit -am"

alias cls="clear"
alias stow="stow --target=$HOME"

# I use the tui interface so much might as well make it default
alias gdb="gdb -tui"

alias valgrind="valgrind --leak-check=full -s"

# Quick quit the terminal because I'm too lazy to type the entire thing
alias q="exit"

PATH=$HOME/Dev/Scripts:$PATH
export TEMPLATES="$HOME/Dev/Templates"
export PATH="$HOME/neovim/bin:$PATH"
export PATH="~/.emacs.d/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

# Set bash to edit in vi mode
set -o vi

set bell-style none

set colored-stats on
set colored-completion-prefix on

# Map case treats the '-' character like '_' and vice versa
# but we need ignore case to be on for this to work
set completion-ignore-case on
set completion-map-case on 

cmkdir()
{
	[ -z "$1" ] && echo "cmkdir: missing operand" && return

	mkdir $1
	cd $1
}

