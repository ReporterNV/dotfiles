#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export EDITOR=nvim
export HISTSIZE=5000
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ls='ls --color=auto'
alias mv='mv -i -v'


#PS1='\u@\h [\W]\$> '
export PS1="=[\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;34m\]\h]\[\e[00m\]=(\[\e[01;31m\]\w\[\e[00m\])=(\t)=\n=>"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
