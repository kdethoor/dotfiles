# About .bashrc
# https://wiki.archlinux.org/title/Bash#Configuration_files

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'


# Prompt
PROMPT_ELAPSED=0

prompt_command() {
  local -i start elapsed
  read _ start _ < <(HISTTIMEFORMAT='%s ' history | tail -n 1)
  (( elapsed = $(date +%s) - start ))
  PROMPT_ELAPSED=''
  if [[ $elapsed -gt 0 ]]
  then
	  PROMPT_ELAPSED=$" (${elapsed}s)"
  fi
}

PROMPT_COMMAND=prompt_command
PS1=$'\n\W${PROMPT_ELAPSED}\n\u276f '
