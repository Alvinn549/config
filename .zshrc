echo "Hello $(print -P  %F{yellow}$(whoami)!%f)"
echo "Today is $(print -P %F{yellow}$(date '+%A, %d %B %Y | %T')%f) 🌞, Have a great day ahead! 😊"
echo ""

export PATH="$HOME/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(git aliases zsh-autosuggestions zsh-syntax-highlighting fzf laravel)

source $ZSH/oh-my-zsh.sh

alias reload="source ~/.zshrc"
alias c="clear"
alias grep="grep --color=auto"
alias mkdir="mkdir -p"

alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

if command -v eza >/dev/null 2>&1; then
    alias l="eza -lh  --icons=auto"                                         # long list
    alias ls="eza -1   --icons=auto"                                        # short list
    alias ll="eza -lhag --icons=auto --sort=name --group-directories-first" # long list all
    alias ld="eza -lhD --icons=auto"                                        # long list dirs
    alias lt="eza --icons=auto --tree"                                      # list folder as tree
    alias la="eza -lhag --icons=auto"                                       # long list all
else
    alias l="ls -lh"                              # long list
    alias ls="ls -1"                              # short list
    alias ll="ls -lhag --group-directories-first" # long list all
    alias ld="ls -lhD"                            # long list dirs
    alias lt="tree"                               # list folder as tree
fi

if command -v code >/dev/null 2>&1; then
    alias openconfig="code ~/.config"
fi

if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
    export EDITOR="nvim"

else
    alias vim="vim"
    export EDITOR="vim"
fi

if command -v yazi >/dev/null 2>&1; then
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

function ssh() {
    if [[ -n "$KITTY_WINDOW_ID" ]]; then
        command kitty +kitten ssh "$@"
    else
        command ssh "$@"
    fi
}
