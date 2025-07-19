.PHONY: help install update clean test lint check

# Variables
SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
BACKUP_DIR := $(HOME)/.dotfiles.backup
TIMESTAMP := $(shell date +%Y%m%d_%H%M%S)

# Colores
RESET := \033[0m
BOLD := \033[1m
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m

# Default target
help: ## Muestra esta ayuda
	@echo "$(BOLD)Dotfiles Management System$(RESET)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2}'

install: check backup ## Instala dotfiles (completo)
	@echo "$(BOLD)Installing dotfiles...$(RESET)"
	@$(DOTFILES_DIR)/bootstrap/install.sh

install-%: check ## Instala módulo específico (ej: install-nvim)
	@echo "$(BOLD)Installing module: $*$(RESET)"
	@$(DOTFILES_DIR)/bootstrap/install.sh --module $*

update: ## Actualiza dotfiles desde git
	@echo "$(BOLD)Updating dotfiles...$(RESET)"
	@git pull --rebase
	@$(MAKE) install

clean: ## Limpia enlaces simbólicos rotos
	@echo "$(BOLD)Cleaning broken symlinks...$(RESET)"
	@find $(HOME) -maxdepth 3 -type l -exec test ! -e {} \; -delete 2>/dev/null || true

backup: ## Crea backup de configs actuales
	@echo "$(BOLD)Creating backup...$(RESET)"
	@mkdir -p $(BACKUP_DIR)/$(TIMESTAMP)
	@$(DOTFILES_DIR)/bootstrap/backup.sh $(BACKUP_DIR)/$(TIMESTAMP)

restore: ## Restaura último backup
	@echo "$(BOLD)Restoring from backup...$(RESET)"
	@LATEST=$$(ls -t $(BACKUP_DIR) | head -1); \
	if [ -n "$$LATEST" ]; then \
		$(DOTFILES_DIR)/bootstrap/restore.sh $(BACKUP_DIR)/$$LATEST; \
	else \
		echo "$(RED)No backups found$(RESET)"; \
		exit 1; \
	fi

test: ## Ejecuta tests
	@echo "$(BOLD)Running tests...$(RESET)"
	@$(DOTFILES_DIR)/tests/run.sh

lint: ## Valida scripts con shellcheck
	@echo "$(BOLD)Linting scripts...$(RESET)"
	@find . -type f -name "*.sh" -exec shellcheck {} +

check: ## Verifica dependencias
	@echo "$(BOLD)Checking dependencies...$(RESET)"
	@$(DOTFILES_DIR)/bootstrap/check-deps.sh

list: ## Lista módulos disponibles
	@echo "$(BOLD)Available modules:$(RESET)"
	@find $(DOTFILES_DIR)/config -maxdepth 1 -type d -name "[!.]*" | \
		xargs -I {} basename {} | sort | sed 's/^/  - /'

status: ## Muestra estado de instalación
	@echo "$(BOLD)Installation status:$(RESET)"
	@$(DOTFILES_DIR)/bin/dotfiles status

version: ## Muestra versión
	@cat $(DOTFILES_DIR)/VERSION

.DEFAULT_GOAL := help
