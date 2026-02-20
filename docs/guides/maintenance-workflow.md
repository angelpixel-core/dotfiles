# Maintenance Workflow

Workflow operativo para mantener dotfiles estables, reproducibles y rápidos sin cambios riesgosos.

## Cadencia sugerida

- Diario (rápido): validar workspace y smoke.
- Semanal: revisar seguridad + pendientes críticos.
- Mensual: limpieza controlada y normalización documental.

## Ciclo diario (5-10 min)

1. `git status --short --branch`
2. `make test`
3. Si hay cambios locales: commit atómico por intención.

## Ciclo semanal (30-45 min)

1. Ejecutar escaneo de secretos:
   - `scripts/security/scan-secrets.sh`
2. Revisar prompts pendientes/re-evaluar:
   - `docs/audit/project-docs-prompts-reference-table.md`
3. Priorizar 1-3 items para la semana en `docs/audit/tasks-backlog-legacy.md`.

## Ciclo mensual (60-90 min)

1. Revisar estructura/documentación canónica:
   - `docs/README.md`
   - `docs/project-structure.md`
2. Ejecutar cleanup reversible:
   - mover material dudoso a `archive/` (no borrar sin aprobación).
3. Verificar links y referencias de docs.

## Reglas operativas

- PRs chicas y reversibles.
- Commits atómicos (`type(scope): summary`).
- Sin secretos hardcodeados.
- Sin acciones destructivas sobre historial compartido.

## Criterio de salida de cada iteración

1. `make test` en verde.
2. `git status --short --branch` limpio.
3. Documentación actualizada si cambió estructura/proceso.
