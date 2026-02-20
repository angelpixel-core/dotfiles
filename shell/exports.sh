#!/usr/bin/env zsh

export SHELL_PATH="${DOTFILES_ROOT}/shell"
export LANGS_PATH="${DOTFILES_ROOT}/langs"
export ASDF_DATA_DIR="$HOME/.asdf"

# User-level tools and runtimes
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
# Utilidades instaladas en ~/.local/bin (pipx y otras)
export LOCAL_BIN="$HOME/.local/bin"

export VAULTS_PATH="${HOME}/Vaults"
export HARVIS_PATH="${VAULTS_PATH}/Harvis"
export MEMORIA_DIGITAL_PATH="${HARVIS_PATH}/300-MEMORIA_DIGITAL"
export SITES_PATH="${MEMORIA_DIGITAL_PATH}/475-sites"
export ANGEL_SOLUTIONS_PATH="${SITES_PATH}/AngelSolutions"
export COMPANY_PATH="${ANGEL_SOLUTIONS_PATH}/company"

export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"

# For compilers to find util-linux you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/util-linux/lib"
export CPPFLAGS="-I/opt/homebrew/opt/util-linux/include"

# For pkgconf to find util-linux you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/util-linux/lib/pkgconfig"

# ------------------------------------------------------------------------------
# Theme config
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Languages
# ------------------------------------------------------------------------------

# Ruby
# export GEM_HOME="$HOME/.gem"
# export RBENV_PATH="$HOME/.rbenv"

# Rust
export CARGO_PATH="$HOME/.cargo"
# Cargar entorno de Rust si existe
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# StarkNet / Starkli
if [ -f "$HOME/.starkli/env" ]; then
  . "$HOME/.starkli/env"
fi

# ------------------------------------------------------------------------------
# CLI Apps config
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Path - The higher it is, the more priority it has
# ------------------------------------------------------------------------------
path=(
# ASDF
"$ASDF_DATA_DIR/shims"
"$ASDF_DATA_DIR/completions"

# --------------------------------------------- #
# User session binaries
# --------------------------------------------- #

# Own or 3rd-party binary and scripts allowed for session user.
"$HOME/bin"
"$BUN_INSTALL/bin"
"$PNPM_HOME"
"$LOCAL_BIN"

# Custom user Binary and Settings
# "$DOTFILES_ROOT/bin"
"$DOTFILES_ROOT/bin/tree"

# ---------------------------------------------------------------------------
# Languages Binary
# ---------------------------------------------------------------------------

"/opt/homebrew/share/zsh/site-functions" # Zsh: auto-completion

# PHP
"/opt/homebrew/opt/php@8.2/bin"
"/opt/homebrew/opt/php@8.2/sbin"

# Java
"$HOME/.asdf/installs/java/adoptopenjdk-11.0.21+9"

# Android
$ANDROID_SDK_ROOT/platform-tools
$ANDROID_SDK_ROOT/emulator
$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
# $ANDROID_SDK_ROOT/tools/bin


# Add Redis.app binaries to path
# "/Applications/Redis.app/Contents/Resources/Vendor/redis/bin"


# "/opt/homebrew/opt/libpq/bin"

#-----------------------------------------------------------------
# Additional tools and software
#-----------------------------------------------------------------
"/opt/homebrew/opt/curl/bin"
"/opt/homebrew/opt/postgresql@17/bin"
"/Users/angel.szymczak/.lmstudio/bin"
"/Users/angel.szymczak/.antigravity/antigravity/bin"

# Brew Home for arm64 (Apple Silicon M1 or higher)
"/opt/homebrew/opt"
"/opt/homebrew/bin"
"/opt/homebrew/sbin"

# If you need to have util-linux first in your PATH, run:
"/opt/homebrew/opt/util-linux/bin"
"/opt/homebrew/opt/util-linux/sbin"

# Brew Home for i386 (Intel)
# It is traditionally used on UNIX systems for local software that is
# installed outside of the system's standard package management.
"/usr/local/bin"

# Similar to /usr/local/bin but for binaries that run as root.
"/usr/local/sbin"

#-----------------------------------------------------------------
# OS binaries at the end
# To ensure that the base programs are available if custom or
# additional versions are not.
#-----------------------------------------------------------------

# Essential binaries required for user mode boot and system repair.
"/bin"

# Standard OS binaries.
"/usr/bin"

# Standard OS binaries that run as root.
# Operating system binaries that are generally run as superuser.
"/usr/sbin"

# Essential binaries that are required for system boot and repair, usually run as superuser.
"/sbin"
"$PATH"
)

export path

export EDITOR=nvim

# -------------------
# Curl
# -------------------
# For compilers to find curl you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

# For pkg-config to find curl you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig"

# zsh completions have been installed to:
# /opt/homebrew/opt/curl/share/zsh/site-functions

# -----------------------------------------------------------------------------
# Ollama Server Support for LLM Models interpreter
# -----------------------------------------------------------------------------
export OLLAMA_SERVER="127.0.0.1"
export OLLAMA_PORT="11434"
export OLLAMA_HOST="${OLLAMA_SERVER}:${OLLAMA_PORT}"

# -----------------------------------------------------------------------------
# qwen2.5-coder
# -----------------------------------------------------------------------------
export LLM_MODEL_CODENAME="qwen"
export LLM_MODEL_VERSION="2.5"
export LLM_MODEL_RELEASE="coder"
# export LLM_MODEL_TAG="7b"
export LLM_MODEL_TAG="3b"
export LLM_MODEL="${LLM_MODEL_CODENAME}${LLM_MODEL_VERSION}-${LLM_MODEL_RELEASE}:${LLM_MODEL_TAG}"

# -----------------------------------------------------------------------------
# second_constantine/deepseek-coder-v2:16b
# -----------------------------------------------------------------------------
# export LLM_MODEL_CODENAME="second_constantine/deepseek-coder"
# export LLM_MODEL_VERSION="v2"
# export LLM_MODEL_RELEASE=""
# export LLM_MODEL_TAG="16b"
# export LLM_MODEL="${LLM_MODEL_CODENAME}${LLM_MODEL_VERSION}-${LLM_MODEL_RELEASE}:${LLM_MODEL_TAG}"

# -----------------------------------------------------------------------------
# Open Web UI | Support for multi LLM Models interpreters
# -----------------------------------------------------------------------------
export OPEN_WEBUI_PORT=7654

# Ollama Configs
export OLLAMA_BASE_URL="http://${OLLAMA_HOST}"

# LLM/API credentials should be loaded from env/.env.local or 1Password via OP_URI
# Example URI format only (do not commit real IDs): op://<Vault>/<Item>/<Field>

# Notes
export NOTES_PATH="${HOME}/Vaults/Harvis"
export NOTES_INBOX_PATH="${NOTES_PATH}/200 - INBOX"
export NOTES_DAILY_PATH="${NOTES_PATH}/000 - DIARIO"
export NOTES_DAILY_TODO_PATH="${NOTES_DAILY_PATH}/TODO"

# GPG Operations
export DISPLAY=:0
# export SSH_AUTH_SOCK=~/.ssh/trezor-agent.sock
export SSH_GITHUB_ID=git@github.com
export SSH_GITLAB_ID=git@gitlab.com
export SSH_BITBUCKET_ID=git@bitbucket.com

# AWS | Angel Solutions | DevStack-Pulumi 2
# INFO: check: $HOME/.aws/*

# -----------------------------------------------------------------------------
# Secrets loading (local env + optional 1Password URI resolution)
# -----------------------------------------------------------------------------
ENV_LOCAL_FILE="${DOTFILES_ROOT}/env/.env.local"
if [ -f "$ENV_LOCAL_FILE" ]; then
  set -a
  . "$ENV_LOCAL_FILE"
  set +a
fi

resolve_secret_from_op() {
  local target_var="$1"
  local uri_var="$2"
  local current_value uri value

  eval "current_value=\${$target_var:-}"
  [ -n "$current_value" ] && return 0

  eval "uri=\${$uri_var:-}"
  [ -z "$uri" ] && return 0

  if command -v op >/dev/null 2>&1; then
    value="$(op read "$uri" 2>/dev/null || true)"
    if [ -n "$value" ]; then
      eval "export $target_var=\"\$value\""
    fi
  fi
}

resolve_secret_from_op "MXBAI_API_KEY" "MXBAI_API_KEY_OP_URI"
resolve_secret_from_op "OPENAI_API_KEY" "OPENAI_API_KEY_OP_URI"
resolve_secret_from_op "ANTHROPIC_API_KEY" "ANTHROPIC_API_KEY_OP_URI"
resolve_secret_from_op "GITHUB_TOKEN" "GITHUB_TOKEN_OP_URI"
