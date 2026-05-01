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
zinit snippet OMZP::dirhistory
# Completions
autoload -Uz compinit && compinit
zinit cdreplay -q
# History substring search
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light zsh-users/zsh-history-substring-search

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

# FUNCTIONS
# Compress PDF
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
# Copy file content
  copyfile() {
  if [ -z "$1" ]; then
    echo "usage: copyfile <file>"
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "error: file not found"
    return 1
  fi

  wl-copy < "$1"
}
# Copy buffer to clipboard using ctrl+B keybind
copybuffer(){
  print -rn -- "$BUFFER" | wl-copy
  zle reset-prompt
  zle kill-whole-line
}
zle -N copybuffer # Allow function to be used as keybind
# Paste clipboard using ctrl+V keybind
paste_clipboard() {
  BUFFER+=$(wl-paste)
  CURSOR=$#BUFFER
}
zle -N paste_clipboard

# Execute clear command
clear_command() {
  clear
  zle reset-prompt
}
zle -N clear_command

# Replicates sudo !!
fuck() {
  eval "sudo $(fc -ln -1)"
}

# KEYBINDINGS
bindkey -M viins '^Z' undo
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M viins '^V' paste_clipboard
bindkey -M viins '^H' backward-kill-word
# Specific function to overwrite zvm binds, loading after zvm 
zvm_after_init(){
  bindkey -M viins '^p' history-substring-search-up
  bindkey -M viins '^n' history-substring-search-down
  bindkey -M viins '^B' copybuffer
  bindkey -M viins '^ ' fzf-tab-complete  # Ctrl+Space
  bindkey -M viins '^/' clear_command     # Tenta Ctrl+/ literal
  bindkey -M viins '^_' clear_command     # Some emuators send "/" as "_"
}

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
# Git
alias gst="git status"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit"
alias gl="git log --oneline --graph --decorate"

# GLOBAL ALIASES
alias -g C='| wl-copy'
alias -g L='| less'
alias -g NE='2>/dev/null'

# SUFIX ALIASES
alias -s md="bat"
alias -s mov="xdg-open"
alias -s mp4="xdg-open"
alias -s mp3="xdg-open"
alias -s flac="xdg-open"
alias -s mp4="xdg-open"
alias -s png="xdg-open"
alias -s jpg="xdg-open"
alias -s pdf="xdg-open"

# SHELL INTEGRATIONS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
