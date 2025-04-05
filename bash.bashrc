#
# ~/.bashrc
#

# If not running interactively, don't do anything # what i take it?
#[[ $- != *i* ]] && return

export EDITOR="n"
export TERMINAL='alacritty'

alias gst='git status'
alias gpl='git pull'
alias gps='git push'
alias gcm='git commit -m'
alias gco='git checkout'
alias gbr='git branch'
alias gad='git add'
alias gdf='git diff'
alias gmg='git merge'
alias glg='git log --oneline --graph --all --decorate'
source ~/.git-completion.bash

parse_git_branch() {
  git branch 2>/dev/null | grep '^*' | colrm 1 2
}


#export DOTNET_CLI_TELEMETRY_OPTOUT=1
#export PATH="$PATH:~/.dotnet/tool" idk why but this already in PATH
set TRUECOLOR
set HISTSIZE=90000

alias ls='ls --color=auto'
alias grep='grep --color=auto'


PS1='[\u@\h \W]\$ '
export PS1="\u@\h \w \[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
PS1='[\[\033[1;33m\]\d \t\[\033[00m\]] \u@\h:\w$(__git_ps1 " (%s)")\$ '

export PS1='[\[\033[1;33m\]\d \t\[\033[00m\]] \u@\h:$(parse_git_branch)\n\w$>'
export PS1='[\[\033[1;33m\]\d \t\[\033[00m\]] \u@\h\n\[\033[1;34m\]\w\[\033[00m\] \[\033[1;36m\][$(parse_git_branch)]\[\033[00m\]\n$> '



echo "Hi "$USER


un() {
	local file="$1"

	if [[ -z "$file" ]]; then
		echo "Usage: uncompress <file>"
		return 1
	fi

	if [[ ! -f "$file" ]]; then
		echo "Error: File '$file' not found."
		return 1
	fi

	case "$file" in
		*.tar.gz|*.tgz)  tar -xvzf "$file" ;;
		*.tar.xz)        tar -xvJf "$file" ;;
		*.tar.bz2)       tar -xvjf "$file" ;;
		*.tar)           tar -xvf "$file" ;;
		*.zip)           unzip "$file" ;;
		*.rar)           unrar x "$file" ;;
		*.7z)            7z x "$file" ;;
		*) 
			echo "Error: Unsupported file type."
			return 1
			;;
	esac
}


source /usr/share/bash-completion/completions/pass
source /usr/share/bash-completion/completions/git




shell="$(basename $SHELL)"
eval "$(fzf --$shell)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

