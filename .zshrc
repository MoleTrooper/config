# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
#
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Fix line wrapping on robbyrussell theme
# export PROMPT="%{${ret_status}%} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_first_and_last"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_LENGTH=20

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
	time
	background_jobs
	context
	dir
	dir_writable_joined
	vcs
	command_execution_time
	status
	newline
	custom_prompt_arrow
)
POWERLEVEL9K_CUSTOM_PROMPT_ARROW="echo ' '"
POWERLEVEL9K_CUSTOM_PROMPT_ARROW_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_PROMPT_ARROW_FOREGROUND="green"

POWERLEVEL9K_DISABLE_RPROMPT=true

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="green"
POWERLEVEL9K_EXECUTION_TIME_ICON=
# Status code displays just the number
POWERLEVEL9K_CARRIAGE_RETURN_ICON=

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="black"

POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="blue"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

# disable stash indicator because it messes with my fonts
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-remotebranch git-tagname)

# Update zsh with pacman instead
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
	z
	git
	pass
	archlinux
	extract
	dircycle
	colorize
	colored-man-pages
	web-search
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"


