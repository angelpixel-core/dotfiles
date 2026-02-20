# Índice de comandos del repositorio

Fuente principal: `Makefile`.

## Comandos operativos (verificados)

- `make help`: lista targets documentados.
- `make install`: instala dotfiles (usa `scripts/bootstrap/install.sh`).
- `make install-<module>`: instalación por módulo soportado.
- `make update`: pull + reinstalación.
- `make backup`: backup de configuración actual.
- `make restore`: restaura último backup.
- `make test`: smoke tests (`scripts/tests/run.sh`).
- `make lint`: `shellcheck` sobre scripts `.sh`.
- `make security-scan`: scan de secretos (`scripts/security/scan-secrets.sh`).
- `make check`: validación de dependencias bootstrap.
- `make version`: versión actual.
- `make version-info`: detalle de versión.
- `make version-bump TYPE=<patch|minor|major>`: bump semántico.
- `make version-check`: validación de integridad de versionado.
- `make version-lock`: genera lock de versión.
- `make migrate`: chequea migraciones pendientes.
- `make migrate-run TO=<version>`: ejecuta migración puntual.
- `make migrate-history`: historial de migraciones.
- `make colors`: prueba soporte de color en terminal.

## Targets con deuda técnica (pendientes)

- `make list`: hoy busca `$(DOTFILES_DIR)/config`, ruta no presente en el repo.
- `make status`: hoy llama `$(DOTFILES_DIR)/bin/dotfiles status`, binario no presente.
- `make clean`: operativo pero destructivo para symlinks rotos; requiere política explícita de uso.

## Comandos directos (sin Makefile)

- `scripts/bootstrap/install.sh --module <shell|common|macos|macos-intel|linux>`
- `scripts/bootstrap/check-deps.sh`
- `scripts/bootstrap/backup.sh <destino>`
- `scripts/bootstrap/restore.sh <origen>`
- `scripts/security/scan-secrets.sh`
- `scripts/tests/run.sh`

## Verificación recomendada

```bash
make help
make check
make test
make security-scan
```
