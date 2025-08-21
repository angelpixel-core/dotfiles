### Tarea 48: Configurar GPG con hardware

- **Prompt**: `/sc:implement config/security/gpg/ --type security --persona-security --safe-mode`
- **Persona**: security
- **Archivos creados**:
  - config/security/gpg/gpg.conf
  - config/security/gpg/hardware-setup.sh
- **Resultado Esperado**:
  - **Descripción**: GPG configurado para usar hardware keys
  - **Comando**: `gpg --card-status`
- **Output**: `outputs/48-gpg-hardware.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `feat: configure GPG with hardware [SC #48]`