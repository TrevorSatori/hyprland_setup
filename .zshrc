# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
fi


# basic Settings
setopt autocd extendedglob
unsetopt beep
bindkey -e
alias ls='ls --color=auto'

# The following lines were added by compinstall
zstyle :compinstall filename '/home/satori/.zshrc'

# Command Completetion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Prompt  
#PROMPT='%n@%m %~ %# '
PROMPT='[%F{blue}%n@%m%f%    %B%F{red}%~%f%b% ]$ '

eval "$(starship init zsh)"

# Custom
fastfetch
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# vi mode
bindkey -v
export KEYTIMEOUT=1
# Enable word navigation with Ctrl + Arrow keys
bindkey '^[[1;5D' backward-word  # Ctrl + Left Arrow
bindkey '^[[1;5C' forward-word   # Ctrl + Right Arrow

path+=('/home/satori/.cargo/bin')
path+=('/home/satori/.local/bin')
path+=('/home/satori/bin')
path+=("$HOME/.npm-global/bin")
path+=("$HOME/go/bin")

export EDITOR=nvim
export SUDO_EDITOR=nvim
alias vim="nvim"

