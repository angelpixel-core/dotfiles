# Fase 2 - Dedupe report

## Metodo

- Comparacion por hash SHA-256 entre archivos de `docs/` (canon) y `docs/_legacy/project_docs/`.
- Resultado: no se detectaron duplicados exactos de contenido.

## Acciones aplicadas

- Renombre de carpeta de auditoria:
  - `docs/auditory/` -> `docs/audit/`
- Consolidacion del entrypoint legacy:
  - `docs/_legacy/project_docs/README.md` pasa a stub canonico.
  - Contenido historico preservado en `docs/_legacy/project_docs/README.legacy.md`.

## Rollback

```bash
git revert <commit-fase2>
```
