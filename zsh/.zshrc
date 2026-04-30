# PLUGIN MANAGER (ZINIT)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if needed
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode
# Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# KEYBINDINGS
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^H' backward-kill-word

# SHELL CONFIGURATION
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt NO_CHECK_JOBS
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# Zsh VI mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# ALIASES
alias ls='eza --icons=always'
alias la='eza --icons=always -a'
alias c='clear'
alias vim="nvim"
alias cat="bat"
alias please="fuck"
# Tmux
alias ta='tmux attach || tmux'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# FUNCTIONS
## Compress PDF
compresspdf() {
  if [ $# -lt 2 ]; then
    echo "usage: compresspdf input.pdf output.pdf [screen|ebook|printer]"
    return 1
  fi

  quality=${3:-ebook}

  gs -sdevice=pdfwrite \
     -dcompatibilitylevel=1.4 \
     -dpdfsettings=/$quality \
     -dnopause -dquiet -dbatch \
     -soutputfile="$2" "$1"
}
# Replicates sudo !!
fuck() {
  eval "sudo $(fc -ln -1)"
}

# SHELL INTEGRATIONS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
