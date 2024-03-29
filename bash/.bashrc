# About .bashrc
# https://wiki.archlinux.org/title/Bash#Configuration_files

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias lsa='ls -ahl --color=auto'
alias grep='grep --color=auto'

# Completion
if [[ -r /usr/share/bash-completion/bash_completion ]];
then
	. /usr/share/bash-completion/bash_completion
fi

# SSH (via gcr-ssh-agent)
if [[ $(systemctl is-active --user gcr-ssh-agent.socket) -eq 0 ]]
then
	export SSH_AUTH_SOCK=$"${XDG_RUNTIME_DIR}/gcr/ssh"
fi

# Neovim
if [[ -x /usr/sbin/nvim ]] || [[ -x /usr/bin/nvim ]]
then
	alias vim=nvim
	export GIT_EDITOR=nvim
fi

# Dotnet
if [[ -x /usr/sbin/dotnet ]]
then
	function _dotnet_bash_complete()
	{
	  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n' # On Windows you may need to use use IFS=$'\r\n'
	  local candidates
	  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)
	  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
	}
	complete -f -F _dotnet_bash_complete dotnet
fi

# Bindings
bind -x '"\C-\E":"vim ."'

# Prompt
## Git
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## Elapsed time
function timer_start() {
	timer=${timer:-$SECONDS}
}

function timer_stop() {
	PROMPT_ELAPSED=''

	local -i elapsed
	elapsed=$(($SECONDS - $timer))
	unset timer

	if [[ $elapsed -gt 0 ]]
	then
		local elapsed_str
		elapsed_str=$"${elapsed}s"

	        local -i days hours minutes seconds
	        days=$(($elapsed / 86400))
	        if [[ $days -gt 0 ]]
	        then
			elapsed_str=$(date -ud "@${elapsed}" +"${days}d%Hh%Mm%Ss")
		fi
		hours=$(($elapsed / 3600))
		if [[ $hours -gt 0 ]]
		then
			elapsed_str=$(date -ud "@${elapsed}" +"%Hh%Mm%Ss")
		fi
		minutes=$(($elapsed / 60))
		if [[ $minutes -gt 0 ]]
		then
			elapsed_str=$(date -ud "@${elapsed}" +"%Mm%Ss")
		fi

		PROMPT_ELAPSED=$" (${elapsed_str})"
	fi
	return
}

function prompt_command() {
	timer_stop
}

trap "timer_start" DEBUG

PROMPT_ELAPSED=''
PROMPT_COMMAND=prompt_command

PS1=$'\n\e[1;32m[\h] \e[1;37m\w\e[0;34m$(parse_git_branch)\e[0;33m${PROMPT_ELAPSED}\n\e[0;31m\u276f\e[0m '

if [[ -r ~/.local.bashrc ]]
then
	. ~/.local.bashrc
fi
