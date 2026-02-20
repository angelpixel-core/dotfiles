### Tarea 27: Eliminar código muerto y duplicado

- **Prompt**: `/sc:cleanup . --dead-code --imports --safe --persona-refactorer`
- **Persona**: refactorer
- **Archivos creados**:
  - cleanup-report.md
- **Resultado Esperado**:
  - **Descripción**: Código limpio sin duplicación ni archivos muertos
  - **Comando**: `find . -name "*.old" -delete`
- **Output**: `outputs/27-cleanup-code.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `refactor: remove dead code [SC #27]`