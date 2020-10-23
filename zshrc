#!/bin/zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

ssh-agent-helper() {
export SSH_AUTH_SOCK=~/.tmp/ssh-agent.sock
[[ ! -d ~/.tmp ]] && mkdir ~/.tmp

check-ssh-agent() {
    [[ -S "$SSH_AUTH_SOCK" ]] && { ssh-add -l >& /dev/null || [[ $? -ne 2 ]]; }
}

check-ssh-agent || eval "$(ssh-agent -s -a ${SSH_AUTH_SOCK})"
}

#PROMPT="%n@%m"
if [[ "$(uname 2> /dev/null)" == "Linux" ]]; then
        PROMPT_COLOR="green"
        [[ "$(whoami)" == "root" ]] && PROMPT_COLOR="red"
        PROMPT="%{$fg_bold[${PROMPT_COLOR}]%}%n@%m %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
else
        PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
fi

PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

#autoload -U promptinit; promptinit
# prompt suse

if [[ "$(uname 2> /dev/null)" == "Linux" ]]; then
### Linux ###
# plugins
plugins=(
        git
)

ssh-agent-helper
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

else
### MAC OS ###
# plugins
plugins=(
        git
        brew
    ssh-agent
)

# highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# path
export PATH=/opt/local/bin:/usr/local/Cellar/mtr/0.92/sbin/:/usr/local/Cellar/mysql-client/5.7.23/bin/:~/bin/:/usr/local/sbin:$PATH

fi

# history share
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.

# KVM
#export LIBVIRT_DEFAULT_URI=qemu:///system

# path
export PATH=~/bin/:$PATH
export EDITOR=vim

# aliases
alias s='ssh'
alias lla='ls -lah'

