# PENDING_REVIEW

Este directorio es transitorio. El contenido valioso ya fue extraído a `docs/`.

## Pendientes de decisión (no migrado)

- `prompts/scripts/split/rust/target/**` (artefactos build Rust)
- `prompts/scripts/logs/split.log` (log de ejecución)
- `.DS_Store` (metadata local de macOS)

## Motivo

No son fuente de verdad documental; son artefactos/logs históricos.
Se conservan por política de no borrado sin aprobación explícita.

## Acción propuesta (siguiente fase)

1. Aprobar borrado o mover a `archive/`.
2. Eliminar referencias restantes a `project_docs` en documentos históricos.
3. Borrar `docs/_legacy/project_docs/` cuando queden solo stubs y/o artefactos aprobados.
