# Reporte de extracción `project_docs` -> `docs` (canon)

## Objetivo

Extraer contenido valioso desde `docs/_legacy/project_docs/` hacia `docs/`, consolidar duplicados y dejar legacy sólo como puente temporal (stubs + pendientes de decisión).

## Qué se movió a canon

### Guías / decisiones / planes

- `docs/guides/mcp-setup-with-claude-code.md`
- `docs/guides/shell-load-order-zsh-bash.md`
- `docs/guides/plan-shell-redistribucion-2026-01-27.md`
- `docs/guides/roadmap.md`
- `docs/decisions/system-structure.md`
- `docs/decisions/versioning-system.md`
- `docs/audit/plan-auditoria-dotfiles-2026-01-21.md`
- `docs/audit/tasks-backlog-legacy.md`

### Prompt pack y tooling

- `docs/prompts/project-docs/*.md` (pack principal migrado)
- `docs/prompts/tools/split/Makefile`
- `docs/prompts/tools/split/00-All.md`
- `docs/prompts/tools/split/bash/run.sh`
- `docs/prompts/tools/split/ruby/run.rb`
- `docs/prompts/tools/split/rust/Cargo.toml`
- `docs/prompts/tools/split/rust/Cargo.lock`
- `docs/prompts/tools/split/rust/run.rs`

## Qué se consolidó

- `docs/` queda como canon documental.
- En legacy se dejaron stubs mínimos por path histórico para preservar navegación y trazabilidad.

## Qué quedó pendiente en legacy y por qué

Detalle canónico en `docs/migrations/project_docs-pending-review.md`.
En legacy queda un stub en `docs/_legacy/project_docs/PENDING_REVIEW.md`.

Pendientes históricos movidos a archive:

- Artefactos Rust: `archive/project_docs/prompts/scripts/split/rust/target/**`
- Log: `archive/project_docs/prompts/scripts/logs/split.log`
- Metadata local: `archive/project_docs/metadata/project_docs.DS_Store`

## Inventario

- Inventario completo: `docs/migrations/project_docs-inventory.md`
- Resumen por acción: `docs/migrations/project_docs-inventory-summary.md`

## Checklist para eliminar legacy (fase siguiente)

1. Confirmar que no quedan referencias funcionales a `project_docs` fuera de docs históricos/migraciones.
2. Definir retención final de `archive/project_docs/` (conservar o purgar por política).
3. Eliminar stubs legacy cuando no se necesite compatibilidad de rutas.
4. Eliminar `docs/_legacy/project_docs/`.

## Rollback

Para revertir esta fase:

```bash
git revert 58ca5f6
git revert d875a5f
git revert 8f88377
git revert 3a1d279
git revert 601236b
```
