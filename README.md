# Dotfiles — Personal Infrastructure Monorepo

Este repositorio es el *source of truth* de mi entorno de desarrollo.

Contiene configuración modular y versionada de:

- Shell (ZSH-first)
- Terminal (WezTerm, tmux)
- Window Manager (yabai, skhd, Sketchybar)
- Editores (Neovim como submodule + VSCode mirror mínimo)
- Tooling (asdf, runtimes, scripts)
- Bootstrap automatizado
- Documentación técnica y decisiones arquitectónicas

## Objetivos

1. **Mantenibilidad** (prioridad máxima)
2. **Reproducibilidad** (fresh install en máquina virgen)
3. **Extensibilidad segura**
4. **Higiene de secretos**

## Plataformas

- macOS (Apple Silicon) — primario
- Linux — soporte espejo compatible

## Seguridad

Este repositorio no contiene secretos hardcodeados.
Las variables sensibles se gestionan mediante:

- `env/.env.local` (ignorado por git)
- Integración opcional con 1Password (`op read` con placeholders `op://<Vault>/<Item>/<Field>`)

Guardrails:

- escaneo local: `scripts/security/scan-secrets.sh`
- pre-commit: `.pre-commit-config.yaml`
- CI: `.github/workflows/secret-scan.yml`

Ver `env/README.md` para más detalles.
