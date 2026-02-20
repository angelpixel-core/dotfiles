SHELL := /bin/bash

SCRIPTS_DIR := "./scripts"

INPUT := "$(SCRIPTS_DIR)/split/00-All.md"
OUTDIR := "./"

LOGS_DIR := "$(SCRIPTS_DIR)/logs"

.PHONY: split/sh split/rb split/rs logs/scripts/clean

## 🐚 Ejecuta script en Bash
split/sh:
	@echo "🔧 Ejecutando Bash script..."
	@bash $(SCRIPTS_DIR)/split/bash/run.sh $(INPUT) $(OUTDIR) $(LOGS_DIR)/split.log

## 💎 Ejecuta script en Ruby
split/rb:
	@echo "🔧 Ejecutando Ruby script..."
	@ruby $(SCRIPTS_DIR)/split/ruby/run.rb $(INPUT) $(OUTDIR) $(LOGS_DIR)/split.log

## 🦀 Ejecuta script en Rust
split/rs: ensure-cargo
	@echo "🔧 Ejecutando Rust script..."
	@cargo run --manifest-path=$(SCRIPTS_DIR)/split/rust/Cargo.toml --release -- \
		$(INPUT) $(OUTDIR) $(LOGS_DIR)/split.log

.PHONY: ensure-cargo

ensure-cargo:
	@if [ ! -f $(SCRIPTS_DIR)/split/rust/Cargo.toml ]; then \
		echo "⚠️  Cargo.toml no encontrado...";
	else \
		echo "✅ Cargo.toml ya existe."; \
		cargo build --manifest-path=$(SCRIPTS_DIR)/split/rust/Cargo.toml; \
	fi

## 🧹 Limpia el log
logs/scripts/clean:
	@rm -f $(LOGS_DIR)/*.log
	@echo "🧼 Logs eliminado: $(LOGS_DIR)/*.log"
