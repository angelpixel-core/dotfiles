### Tarea 00d: Setup CI/CD con GitHub Actions

- **Prompt**: `/sc:implement .github/workflows/test.yml --type ci --persona-devops --c7`
- **Persona**: devops
- **Archivos creados**:
  - .github/workflows/test.yml
  - .github/workflows/release.yml
- **Resultado Esperado**:
  - **Descripción**: Tests automáticos en cada PR y releases automatizados
  - **Comando**: `git push` (triggers CI)
- **Output**: `outputs/00d-cicd-setup.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `ci: add GitHub Actions workflows [SC #00d]`