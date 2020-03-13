# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If this is an xterm set more declarative titles 
# "dir: last_cmd" and "actual_cmd" during execution
# If you want to exclude a cmd from being printed see line 156
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\$(print_title)\a\]$PS1"
    __el_LAST_EXECUTED_COMMAND=""
    print_title () 
    {
        __el_FIRSTPART=""
        __el_SECONDPART=""
        if [ "$PWD" == "$HOME" ]; then
            __el_FIRSTPART=$(gettext --domain="pantheon-files" "Home")
        else
            if [ "$PWD" == "/" ]; then
                __el_FIRSTPART="/"
            else
                __el_FIRSTPART="${PWD##*/}"
            fi
        fi
        if [[ "$__el_LAST_EXECUTED_COMMAND" == "" ]]; then
            echo "$__el_FIRSTPART"
            return
        fi
        #trim the command to the first segment and strip sudo
        if [[ "$__el_LAST_EXECUTED_COMMAND" == sudo* ]]; then
            __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND:5}"
            __el_SECONDPART="${__el_SECONDPART%% *}"
        else
            __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND%% *}"
        fi 
        printf "%s: %s" "$__el_FIRSTPART" "$__el_SECONDPART"
    }
    put_title()
    {
        __el_LAST_EXECUTED_COMMAND="${BASH_COMMAND}"
        printf "\033]0;%s\007" "$1"
    }
    
    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    update_tab_command()
    {
        # catch blacklisted commands and nested escapes
        case "$BASH_COMMAND" in 
            *\033]0*|update_*|echo*|printf*|clear*|cd*)
            __el_LAST_EXECUTED_COMMAND=""
                ;;
            *)
            put_title "${BASH_COMMAND}"
            ;;
        esac
    }
    preexec_functions+=(update_tab_command)
    ;;
*)
    ;;
esac



    # === Packages Quentin NAMBOT ===
source /home/qnambot/Scripts/packages/mvncolor.sh
source /home/qnambot/Scripts/packages/runLatex.sh
source /home/qnambot/Scripts/packages/file.sh
source /home/qnambot/Scripts/packages/move.sh
source /home/qnambot/Scripts/packages/latex.sh
source /home/qnambot/Scripts/packages/kineos.sh
source /home/qnambot/Scripts/packages/init.sh
source /home/qnambot/Scripts/packages/global.sh

export VISUAL=vim
export EDITOR="$VISUAL"

replaceAll() {
  find . -name '*.$1' -exec sed -i -e 's/$2/$3/g' {} \;
}

export LOOKALIKE=/home/qnambot/Documents/lookalike
export MAIN=$LOOKALIKE/src/main/scala/fr/m6/lookalike
export TEST=$LOOKALIKE/src/test/scala/fr/m6/lookalike
 export PATH=~/.npm-global/bin:$PATH

export BOLD=`tput bold`
export UNDERLINE_ON=`tput smul`
export UNDERLINE_OFF=`tput rmul`
export TEXT_BLACK=`tput setaf 0`
export TEXT_RED=`tput setaf 1`
export TEXT_GREEN=`tput setaf 2`
export TEXT_YELLOW=`tput setaf 3`
export TEXT_BLUE=`tput setaf 4`
export TEXT_MAGENTA=`tput setaf 5`
export TEXT_CYAN=`tput setaf 6`
export TEXT_WHITE=`tput setaf 7`
export BACKGROUND_BLACK=`tput setab 0`
export BACKGROUND_RED=`tput setab 1`
export BACKGROUND_GREEN=`tput setab 2`
export BACKGROUND_YELLOW=`tput setab 3`
export BACKGROUND_BLUE=`tput setab 4`
export BACKGROUND_MAGENTA=`tput setab 5`
export BACKGROUND_CYAN=`tput setab 6`
export BACKGROUND_WHITE=`tput setab 7`
export RESET_FORMATTING=`tput sgr0`

newJava(){
  if [[ $# == 1 ]]
  then
    if ([ $1 == "-h" ] || [ $1 == '--help' ])
    then
      echo "Manuel
Init a java file with the good name of class.
User : newJava Class
Create Class.java"
    else
      echo "public class $1
{

}" >> $1.java;
      atom $1.java;
    fi
  else
    echo "Missing file. open -h for more informations"
  fi
}

newPython()
{
  touch $1.py;
  echo "#!/usr/bin/env python3
" >> $1.py;
  atom $1.py
}


newC(){
  touch $1.c;
  echo "#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
" >> $1.c;
  atom $1.c
}

newBash(){
  touch $1.sh
  echo "#!/bin/bash
" >> $1.sh
  atom $1.sh
}

new(){
  if [[ $# == 1 ]]
  then
    if ([ $1 == "-h" ] || [ $1 == '--help' ])
    then
      echo "Manuel
Create and prefill a file.
Known types:
  * .java - Create file and init the class with the goodname
  * .c - Create file and include some basics
  * .py - Create file and add the #!/bin/env/python3"
    else
      if [ ! -f $1 ]
      then
        touch $1

        fullfilename=$(basename $1)
        filename=${fullfilename%.*}
        extension="${fullfilename##*.}"

        case "$extension" in
          "java")
            newJava $filename
            ;;

          "py")
            newPython $filename
            ;;

          "c")
            newC $filename
            ;;

          "sh")
            newBash $filename
            ;;

          *)
            echo "Type of file not recognized. Don't hesitate to update me ;)"
        esac
      else
        echo "File already exist."
      fi
    fi




  else
    echo "Missing name of file. open -h for more informations"
  fi
}


# Open file
open(){
  if [[ $# == 1 ]]
  then
    if ([ $1 == "-h" ] || [ $1 == '--help' ])
    then
      echo "Manual
Give the name of file to open it in the good way.
Example:
  open README.md #Open the README with grip"
    fi

    fullfilename=$(basename $1)
    extension="${fullfilename##*.}"

    case "$extension" in
      "md")
        grip -b "$1" 2>/dev/null &
        ;;
      *)
        xdg-open "$1"
    esac


  else
    echo "Missing file. open -h for more informations"
  fi
}

md2pdf() {
  fullfilename=$(basename $1)
  filename=${fullfilename%.*}

  pandoc $1 -f gfm -o $filename.pdf
}

color_output() {
  sed -e "s/\(INFO\)/${TEXT_BLUE}${BOLD}\1${RESET_FORMATTING}/g" \
               -e "s/\(WARN\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}/g" \
               -e "s/\(ERROR\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" 
               $1
}

spark-submit() {
  ~/spark-2.4.3-bin-hadoop2.7/bin/spark-submit $@ 2>&1 >/dev/null | color_output
}
spark-shell() {
  ~/spark-2.4.3-bin-hadoop2.7/bin/spark-shell
}

copyF() {
  xclip -sel copy < "$1"
}

copyT() {
  echo "$1" | xclip -sel copy
}

replaceAll() {
  find . -name '*.*' -exec sed -i -e 's/$1/$2/g' {} \;
}

gitTree() {
  git log --graph --oneline --all
}


#VIM

testPath() {
  path=$(echo $1 | sed  's;main/;test/;g' | sed 's;\(\.[a-z]*\);*\1;g') 
  echo -n $path | xclip -sel c
}

copy() {
  echo "$1" | xclip -sel c
}


scalatest() {
  className=$(echo $1 | sed 's/.*src\/test\/scala\///g' | sed 's/\.scala//g' | sed 's/\//./g') 
  echo "mvn test -Dsuites=$className"| xclip -sel c
}


parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(⎇ \1)/'
}



anyjobs() { [[ "$1" != 0 ]] && echo "(↶ $1) "; }
PS1='\033[1;33m[\D{%H:%M}] \[\033[1;32m\]$(realpath .) \[\033[1;91m\]$(anyjobs \j)\[\033[1;34m\]$(parse_git_branch)\[\033[00m\]\n$ '

set -o vi

export -f testPath
export -f copy 
export -f scalatest 
if [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

term() {
  if [ $# -eq 0 ]
  then 
    name="default"
  else 
    name="$1"
  fi
  tmux attach -t $name || tmux new -s $name
}

