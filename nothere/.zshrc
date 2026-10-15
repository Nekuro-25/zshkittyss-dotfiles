# =========================================================
# ZSH CONFIGURATION
# Arch Linux / Kitty / Hyprland
# =========================================================


# ---------------------------------------------------------
# ENVIRONMENT
# ---------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"

export PATH="$HOME/.local/bin:$PATH"


# ---------------------------------------------------------
# HISTORY
# ---------------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS     # jangan simpan perintah yang sama berurutan
setopt HIST_IGNORE_SPACE    # perintah berawalan spasi tidak disimpan
setopt SHARE_HISTORY        # history dibagi antar sesi terminal


# ---------------------------------------------------------
# SHELL OPTIONS & KEYBINDING
# ---------------------------------------------------------

unsetopt BEEP               # matikan terminal bell
setopt AUTO_CD              # ketik nama direktori saja untuk cd
setopt INTERACTIVE_COMMENTS # izinkan komentar di prompt interaktif

bindkey -e                  # keybinding gaya emacs


# ---------------------------------------------------------
# COMPLETION
# ---------------------------------------------------------

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # tidak peka huruf besar/kecil


# ---------------------------------------------------------
# ALIASES
# ---------------------------------------------------------

# Navigasi
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias pj="cd ~/projects"

# Perintah dasar (eza & bat)
alias ls="eza --icons --group-directories-first"
alias la="eza -A --icons --group-directories-first"
alias ll="eza -lah --icons --group-directories-first --git"
alias cat="bat"
alias cls="clear"

# Konfigurasi Zsh
alias zshc="$EDITOR ~/.zshrc"
alias zshr="source ~/.zshrc"

# Git
alias gs="git status -sb"
alias gd="git diff"
alias gl="git log --oneline -n 10"


# ---------------------------------------------------------
# FUNCTIONS
# ---------------------------------------------------------

# yazi: pindah direktori shell mengikuti direktori terakhir di yazi
function y() {
	local tmp cwd
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}


# ---------------------------------------------------------
# TOOLS & PLUGINS
# ---------------------------------------------------------

# Prompt (starship sudah mengatur prompt, jadi tidak perlu PROMPT manual)
eval "$(starship init zsh)"

# Navigasi cerdas
eval "$(zoxide init zsh)"

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7689c5"

# Syntax highlighting: HARUS paling akhir
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
