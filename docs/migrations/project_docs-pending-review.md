# Pending Review: project_docs retirement

Estado posterior a la extracción de `docs/_legacy/project_docs/` hacia `docs/`.

## Estado actual de artefactos

Los artefactos no documentales fueron movidos a `archive/project_docs/`:

- `archive/project_docs/prompts/scripts/split/rust/target/**`
- `archive/project_docs/prompts/scripts/logs/split.log`
- `archive/project_docs/metadata/project_docs.DS_Store`

## Motivo

No son fuente de verdad documental; son artefactos/logs históricos.
Se conservaron por política de no borrado sin aprobación explícita.

## Acción propuesta (siguiente fase)

1. Eliminar referencias restantes a `project_docs` en documentos históricos.
2. Aprobar retiro final de `docs/_legacy/project_docs/` cuando no se requiera compatibilidad de rutas.
