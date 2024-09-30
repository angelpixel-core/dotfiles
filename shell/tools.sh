#!/bin/zsh

# ------------------------------------------------------------------------------
# ---- Languages Environment Version Manager -----------------------------------
# ------------------------------------------------------------------------------
[ -s ~/.asdf/asdf.sh ] && . ~/.asdf/asdf.sh
[ -s ~/.asdf/completions/asdf.sh ] && . ~/.asdf/completions/asdf.sh


# ------------------------------------------------------------------------------
# ---- TheFuck -----------------------------------------------------------------
# ------------------------------------------------------------------------------
eval $(thefuck --alias)
eval $(thefuck --alias fk)


# ------------------------------------------------------------------------------
# ---- Zoxide (better cd) ------------------------------------------------------
# ------------------------------------------------------------------------------
eval "$(zoxide init zsh)"
alias cd="z"


# ------------------------------------------------------------------------------
# ---- Eza (better ls) ---------------------------------------------------------
# ------------------------------------------------------------------------------
alias l="eza --color=always --long --all --git --no-filesize --icons=always --no-time --no-user --no-permissions -1"
alias l1="l --tree --level=1"
alias l2="l --tree --level=2"

alias la="l -la"
alias ld="l -D"
alias ll="ls"


# ------------------------------------------------------------------------------
# ---- Bat (beter cat) ---------------------------------------------------------
# ------------------------------------------------------------------------------

#  Check themes in your directory
#  don't forget to clone bat_theme config, check it out in README.md file
#  bat --list-themes | fzf --preview="bat --theme={} --color=always <PATH_TO_YOUR_SAMPLE_VIEW>"

export BAT_THEME="tokyonight_night"


# ------------------------------------------------------------------------------
# ---- FZF ---------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- Setup FZF theme
# https://vitormv.github.io/fzf-themes/
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd :(https://github.com/sharkdp/fd) for listing  path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# git clone https://github.com/junegunn/fzf-git.sh.git
source ~/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


# ------------------------------------------------------------------------------
# ---- Tiling Windows Manager: Yabai -------------------------------------------
# ---- https://www.youtube.com/watch?v=k94qImbFKWE -----------------------------
# ------------------------------------------------------------------------------
yabai --start-service


# ------------------------------------------------------------------------------
# ---- Shortcuts Management: SKHD ----------------------------------------------
# ---- https://www.youtube.com/watch?v=k94qImbFKWE -----------------------------
# ------------------------------------------------------------------------------
skhd --start-service


# ------------------------------------------------------------------------------
# ---- Custom Menu Bar: Sketchybar ---------------------------------------------
# ---- https://youtu.be/8W06wMNZmo8 --------------------------------------------
# ------------------------------------------------------------------------------

# Setup
# brew tap felixkratz/formulae
# brew install sketchybar
# brew install font-sf-pro
# brew install --cask sf-symbols
# curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# ------------------------------------------------------------------------------
# QMK - Custom Caps Keyboard
# ------------------------------------------------------------------------------
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"

# ------------------------------------------------------------------------------
# Bottom - Cross-platform graphical process/system monitor
# brew install bottom
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Espeak - CLI to Voice
# brew install espeak
# ------------------------------------------------------------------------------


# ------------
# RBenv
# ------------
if which rbenv > /dev/null;
then
  eval "$(rbenv init -)";
fi

function notes() {
  nvim $HOME/Notes
}

alias nota="notes"


# ------------
# DirEnv
# ------------
# eval "$(direnv hook zsh)"

# -----------------------------------------------------------------------------
# Ollama Server Support for LLM Models interpreter
# -----------------------------------------------------------------------------
start_ollama_server() {
  if [ ! $(pgrep -x "ollama") > /dev/null ]; then
    echo "🟢 Ollama server is not running. Starting..."
    ollama start &
    sleep 5
  else
    echo "🔵 Ollama server is already running."
  fi

  local_llm=$(ollama list | grep ${LLM_MODEL} | awk '{print $1}')
  # NAME                    ID              SIZE      MODIFIED
  # qwen2.5-coder:latest    87098ba7390d    4.7 GB    About an hour ago
  # gemma:instruct          a72c7f4d0a15    5.0 GB    3 hours ago
  # gemma:latest            a72c7f4d0a15    5.0 GB    4 hours ago

  echo "⚙️ LLM for <$(whoami)> are: [${LLM_MODEL}]"
  if [ "$local_llm" = "$LLM_MODEL" ]; then
    echo "🧠 LLM <${local_llm}> is running."
  else
    echo "🟠 Downloading <${LLM_MODEL}> model..."
  fi
}
start_ollama_server

# -----------------------------------------------------------------------------
# File Navigation
# brew install ranger
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Testing internet bandwidth using speedtest.net
# brew install speedtest-cli
# -----------------------------------------------------------------------------
