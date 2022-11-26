set -o vi

alias pd='pushd $@ > /dev/null 2>&1'
alias pu='popd > /dev/null 2>&1'
alias dr='dirs -v'

# pp commad is used to jump to a directory from dir stack index
# just a convenience instead of cd ~<index>
# works same as cd command except if a number is passed then dire stack is used for switching dir

function pp() {
	if [[ $# -eq 0 ]]; then
		cd
	else
		if [[ $1 == [1-9]*([0-9]) ]]; then
			eval "cd ~"$1""
		else
			cd "$1"
		fi
	fi
}

alias cl='dirs -c'
alias ll='ls -alrth'
