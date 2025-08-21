## Fase 6: Integración AI/MCP

### Tarea 16: Configurar servidores MCP

- **Prompt**: `/sc:implement config/ai/mcp/config.json --type config --framework mcp --persona-backend --c7`
- **Persona**: backend
- **Archivos creados**:
  - config/ai/mcp/config.json
  - config/ai/install.sh
- **Resultado Esperado**:
  - **Descripción**: Configuración MCP con filesystem, github, postgres
  - **Comando**: `config/ai/install.sh`
- **Output**: `outputs/16-configure-mcp-servers.md`
- **Estado**: ⏳ Pendiente
- **Commit**: `feat: add MCP server configuration [SC #16]`