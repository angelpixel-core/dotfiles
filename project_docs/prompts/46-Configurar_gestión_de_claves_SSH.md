## Fase 15: Seguridad y Criptografía

### Tarea 46: Configurar gestión de claves SSH

- **Prompt**: `/sc:implement config/security/ssh/config --type security --persona-security --validate`
- **Persona**: security
- **Archivos creados**:
  - config/security/ssh/config
  - config/security/ssh/install.sh
- **Resultado Esperado**:
  - **Descripción**: SSH con soporte para hardware keys
  - **Comando**: `ssh-add -L`
- **Output**: `outputs/46-ssh-config.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `feat: add SSH key management [SC #46]`