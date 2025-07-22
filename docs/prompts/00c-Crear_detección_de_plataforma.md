### Tarea 00c: Crear detección de plataforma

- **Prompt**: `/sc:implement lib/platform.sh --type library --with-tests --persona-backend`
- **Persona**: backend
- **Archivos creados**:
  - lib/platform.sh
  - tests/unit/lib/test_platform.sh
- **Resultado Esperado**:
  - **Descripción**: Detectar OS (macOS/Linux) y arquitectura
  - **Comando**: `source lib/platform.sh && detect_os`
- **Output**: `outputs/00c-platform-detection.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `feat: add platform detection [SC #00c]`