## Share ssh-agent between multiple ssh sessions on same host
We can set socket path on first line with export, I don't use /tmp but ~/.tmp
Inside .zshr or .bashrc add code:
```
# export socket variable
export SSH_AUTH_SOCK=~/.tmp/ssh-agent.sock
[ ! -d ~/.tmp ] && mkdir ~/.tmp # create dir if not exist ~/.tmp

# check is ssh-agent running and socket is valid
check-ssh-agent() {
    [ -S "$SSH_AUTH_SOCK" ] && { ssh-add -l >& /dev/null || [ $? -ne 2 ]; }
}

# if socket or agent is not valid/running create ssh-agent with our socket
check-ssh-agent || eval "$(ssh-agent -s -a ${SSH_AUTH_SOCK})"
```
