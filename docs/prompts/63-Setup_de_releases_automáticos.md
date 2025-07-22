### Tarea 63: Setup de releases automáticos

- **Prompt**: `/sc:implement .github/workflows/release.yml --type ci --persona-devops`
- **Persona**: devops
- **Archivos creados**:
  - .github/workflows/release.yml
  - scripts/release.sh
- **Resultado Esperado**:
  - **Descripción**: Releases automáticos con tags
  - **Comando**: `git tag v1.0.0 && git push --tags`
- **Output**: `outputs/63-auto-releases.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `ci: add automatic releases [SC #63]`