# Migracion `project_docs/` -> `docs/_legacy/project_docs/`

## Objetivo

Consolidar `docs/` como ubicacion canonica de documentacion y preservar historial sin borrar contenido.

## Mapeo origen -> destino

- `project_docs/` -> `docs/_legacy/project_docs/`
- `project_docs/guides/` -> `docs/_legacy/project_docs/guides/`
- `project_docs/prompts/` -> `docs/_legacy/project_docs/prompts/`
- `project_docs/outputs/` -> `docs/_legacy/project_docs/outputs/`

Regla general aplicada:

- `project_docs/<path>` -> `docs/_legacy/project_docs/<path>`

## Rationale

- `docs/` pasa a ser unico punto de entrada para documentacion operativa.
- `docs/_legacy/` mantiene material historico sin perdida de trazabilidad.
- Se habilita deduplicacion gradual por fases sin cambios destructivos.

## Rollback

Si hay que volver al layout anterior:

```bash
git revert <commit-move>
git revert <commit-cleanup>
```

Alternativa manual (si aplica sobre worktree local):

```bash
git mv docs/_legacy/project_docs project_docs
```

## Verificacion

```bash
test -d docs/_legacy/project_docs && echo "legacy ok"
test ! -d project_docs && echo "old path removed"
```
