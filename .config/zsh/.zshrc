export TERM="xterm-256color"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
export HISTFILE="${XDG_CONFIG_HOME}/zsh/history"
export EDITOR="vim"
export PROGRAM_DIR="$HOME/Programs"

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion


PRIMARY="$(tput setaf 6)"
RESET="$(tput sgr0)"

export PS1="%{$PRIMARY%}%1~ $ %{$RESET%} "

# cowsay "Hello, Milad"

alias zshrc="$EDITOR ${ZDOTDIR}/.zshrc"
alias reload="source ${ZDOTDIR}/.zshrc"
alias pacman="lazy-pacman"
alias ll="ls -al"
function prepend_path() {
 if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
   PATH="$1:$PATH"
 fi
}
prepend_path "$HOME/.local/bin"

