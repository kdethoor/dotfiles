# About .bashrc
# https://wiki.archlinux.org/title/Bash#Configuration_files

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Completion
if [[ -r /usr/share/bash-completion/bash_completion ]];
then
	. /usr/share/bash-completion/bash_completion
	echo hi
fi

# Prompt
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
PS1=$'\n\W${PROMPT_ELAPSED}\n\u276f '