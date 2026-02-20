.PHONY: help install update clean test lint check security-scan analyze sync

# Variables
SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
BACKUP_DIR := $(HOME)/.dotfiles.backup
TIMESTAMP := $(shell date +%Y%m%d_%H%M%S)

# Detectar si el terminal soporta colores
# Verificar si estamos en una terminal interactiva y si soporta colores
ifneq ($(findstring xterm,$(TERM)),)
    # Terminal soporta colores
    RESET := \033[0m
    BOLD := \033[1m
    GREEN := \033[32m
    YELLOW := \033[33m
    RED := \033[31m
    BLUE := \033[34m
    CYAN := \033[36m
else ifneq ($(findstring screen,$(TERM)),)
    # Terminal screen soporta colores
    RESET := \033[0m
    BOLD := \033[1m
    GREEN := \033[32m
    YELLOW := \033[33m
    RED := \033[31m
    BLUE := \033[34m
    CYAN := \033[36m
else ifneq ($(findstring tmux,$(TERM)),)
    # Terminal tmux soporta colores
    RESET := \033[0m
    BOLD := \033[1m
    GREEN := \033[32m
    YELLOW := \033[33m
    RED := \033[31m
    BLUE := \033[34m
    CYAN := \033[36m
else
    # Terminal no soporta colores o no está configurado
    RESET :=
    BOLD :=
    GREEN :=
    YELLOW :=
    RED :=
    BLUE :=
    CYAN :=
endif

# Función para verificar si el terminal soporta colores
define check_color_support
	@if [ -t 1 ] && command -v tput > /dev/null 2>&1 && [ $$(tput colors) -ge 8 ]; then \
		echo "Terminal supports colors"; \
	else \
		echo "Terminal does not support colors or colors disabled"; \
	fi
endef

# Default target
help: ## Muestra esta ayuda
	@printf "$(GREEN)Dotfiles Management System$(RESET)\n"
	@echo ""
	@GREEN="$(GREEN)" RESET="$(RESET)" grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %s%-15s%s %s\n", ENVIRON["GREEN"], $$1, ENVIRON["RESET"], $$2}'

install: check backup ## Instala dotfiles (completo)
	@printf "$(BOLD)Installing dotfiles...$(RESET)\n"
	@$(DOTFILES_DIR)/scripts/bootstrap/install.sh

install-%: check ## Instala módulo específico (ej: install-nvim)
	@printf "$(BOLD)Installing module: $*$(RESET)\n"
	@$(DOTFILES_DIR)/scripts/bootstrap/install.sh --module $*

update: ## Actualiza dotfiles desde git
	@printf "$(BOLD)Updating dotfiles...$(RESET)\n"
	@git pull --rebase
	@$(MAKE) install

clean: ## Limpia enlaces simbólicos rotos
	@printf "$(BOLD)Cleaning broken symlinks...$(RESET)\n"
	@find $(HOME) -maxdepth 3 -type l -exec test ! -e {} \; -delete 2>/dev/null || true

backup: ## Crea backup de configs actuales
	@printf "$(BOLD)Creating backup...$(RESET)\n"
	@mkdir -p $(BACKUP_DIR)/$(TIMESTAMP)
	@$(DOTFILES_DIR)/scripts/bootstrap/backup.sh $(BACKUP_DIR)/$(TIMESTAMP)

restore: ## Restaura último backup
	@printf "$(BOLD)Restoring from backup...$(RESET)\n"
	@LATEST=$$(ls -t $(BACKUP_DIR) | head -1); \
	if [ -n "$$LATEST" ]; then \
		$(DOTFILES_DIR)/scripts/bootstrap/restore.sh $(BACKUP_DIR)/$$LATEST; \
	else \
		printf "$(RED)No backups found$(RESET)\n"; \
		exit 1; \
	fi

test: ## Ejecuta tests
	@printf "$(BOLD)Running tests...$(RESET)\n"
	@$(DOTFILES_DIR)/scripts/tests/run.sh

analyze: ## Ejecuta análisis operativo (deps + smoke + security scan)
	@$(DOTFILES_DIR)/bin/analyze_dotfiles

sync: ## Sincroniza dotfiles (instala y valida; opcional --pull directo en bin/sync_dotfiles)
	@$(DOTFILES_DIR)/bin/sync_dotfiles

lint: ## Valida scripts con shellcheck
	@printf "$(BOLD)Linting scripts...$(RESET)\n"
	@find . -type f -name "*.sh" -exec shellcheck {} +

security-scan: ## Escanea secretos con gitleaks/fallback
	@printf "$(BOLD)Running secret scan...$(RESET)\n"
	@$(DOTFILES_DIR)/scripts/security/scan-secrets.sh

check: ## Verifica dependencias
	@printf "$(BOLD)Checking dependencies...$(RESET)\n"
	@$(DOTFILES_DIR)/scripts/bootstrap/check-deps.sh

list: ## Lista módulos disponibles
	@printf "$(BOLD)Available modules:$(RESET)\n"
	@find $(DOTFILES_DIR)/config -maxdepth 1 -type d -name "[!.]*" | \
		xargs -I {} basename {} | sort | sed 's/^/  - /'

status: ## Muestra estado de instalación
	@printf "$(BOLD)Installation status:$(RESET)\n"
	@$(DOTFILES_DIR)/bin/dotfiles status

version: ## Muestra versión actual
	@$(DOTFILES_DIR)/lib/version.sh get

version-info: ## Muestra información detallada de versión
	@$(DOTFILES_DIR)/lib/version.sh info

version-bump: ## Incrementa versión (uso: make version-bump TYPE=patch)
	@$(DOTFILES_DIR)/lib/version.sh bump $(TYPE)

version-check: ## Verifica integridad de versiones
	@$(DOTFILES_DIR)/lib/version.sh verify

version-lock: ## Crea archivo de bloqueo de versiones
	@$(DOTFILES_DIR)/lib/version.sh lock

migrate: ## Ejecuta migraciones pendientes
	@$(DOTFILES_DIR)/lib/migration.sh check

migrate-run: ## Ejecuta migración a versión específica (uso: make migrate-run TO=1.1.0)
	@$(DOTFILES_DIR)/lib/migration.sh run $$($(DOTFILES_DIR)/lib/version.sh get) $(TO)

migrate-history: ## Muestra historial de migraciones
	@$(DOTFILES_DIR)/lib/migration.sh history

colors: ## Verifica soporte de colores del terminal
	$(check_color_support)

.DEFAULT_GOAL := help
