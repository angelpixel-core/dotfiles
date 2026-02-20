# Analisis profundo por carpeta

Base analizada: `git ls-files` (archivos versionados).

## Estado global

| estado | cantidad |
|---|---:|
| resuelto | 432 |
| pendiente | 12 |
| hay-que-re-evaluar | 1052 |
| deprecar | 660 |

## Matriz por carpeta

| # | carpeta | archivos | intencion principal | resuelto | pendiente | hay-que-re-evaluar | deprecar | estado dominante | action item principal |
|---:|---|---:|---|---:|---:|---:|---:|---|---|
| 1 | `_bmad` | 649 | Framework BMAD y conocimiento interno | 0 | 0 | 649 | 0 | hay-que-re-evaluar | Re-evaluar alcance en repo principal; posible separacion/submodule/documentacion de ownership. |
| 2 | `archive` | 574 | Retencion historica fuera del canon activo | 0 | 0 | 0 | 574 | deprecar | Definir SLA de retencion y criterio de purga para artefactos archivados. |
| 3 | `ai-toolings` | 392 | Tooling AI externo/vendido integrado | 1 | 1 | 390 | 0 | hay-que-re-evaluar | Re-evaluar alcance en repo principal; posible separacion/submodule/documentacion de ownership. |
| 4 | `docs` | 107 | Documentacion canonica, auditorias y migraciones | 96 | 11 | 0 | 0 | resuelto | Mantener docs canonicos sincronizados con cambios reales de configuracion. |
| 5 | `docs/_legacy` | 86 | Legado transitorio para compatibilidad de rutas | 0 | 0 | 0 | 86 | deprecar | Completar retiro final de legacy stubs cuando no existan consumidores de ruta. |
| 6 | `.cursor` | 77 | Soporte del repositorio | 77 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 7 | `.opencode` | 77 | Soporte del repositorio | 77 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 8 | `.codex` | 76 | Soporte del repositorio | 76 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 9 | `shell` | 26 | Configuracion de shell, entorno y tooling interactivo | 14 | 0 | 12 | 0 | resuelto | Sostener smoke tests de carga y politica de secretos (env + 1Password). |
| 10 | `menu-bar` | 18 | Barra de menu (sketchybar) | 18 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 11 | `langs` | 12 | Bootstraps/config por lenguaje | 12 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 12 | `fonts` | 7 | Soporte del repositorio | 7 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 13 | `scripts` | 7 | Automatizacion operativa y smoke tests | 7 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 14 | `terminal` | 6 | Configuracion de terminal y multiplexor | 6 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 15 | `os` | 5 | Ajustes especificos de sistema operativo | 5 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 16 | `caps-layout` | 4 | Firmware/layout teclado | 3 | 0 | 1 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 17 | `symlinks` | 4 | Definicion de enlaces simbolicos por plataforma | 4 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 18 | `editors` | 3 | Configuracion de editores (Neovim/VSCode) | 3 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 19 | `lib` | 3 | Librerias shell compartidas | 3 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 20 | `.versions` | 2 | Soporte del repositorio | 2 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 21 | `bin` | 2 | Utilidades ejecutables | 2 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 22 | `env` | 2 | Plantillas de entorno y secretos | 2 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 23 | `migrations` | 2 | Migraciones de version de dotfiles | 2 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 24 | `.github` | 1 | Automatizaciones CI/CD y seguridad | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 25 | `.gitignore` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 26 | `.gitmodules` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 27 | `.pre-commit-config.yaml` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 28 | `.tool-versions` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 29 | `.version.lock` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 30 | `DOTFILES_INDEX.md` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 31 | `Makefile` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 32 | `README.md` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 33 | `VERSION` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 34 | `VERSION.bak` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 35 | `WARP.md` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 36 | `git` | 1 | Soporte del repositorio | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 37 | `shortcuts` | 1 | Atajos de teclado (skhd) | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |
| 38 | `tiling-windows-manager` | 1 | Window manager (yabai) | 1 | 0 | 0 | 0 | resuelto | Mantenimiento rutinario con control de cambios y pruebas smoke. |

## Entregable de referencia por archivo

- Tabla completa: `docs/audit/repo-reference-table.csv`
- Campos: `orden`, `path`, `dominio`, `intencion`, `estado`, `action_items`, `referencia_contenido`

## Criterios usados para estado

- `resuelto`: archivo operativo/canonico con rol claro y sin accion inmediata.
- `pendiente`: requiere seguimiento para cerrar planes, reportes o backlog.
- `hay-que-re-evaluar`: alcance/ownership/estrategia aun discutible (vendor, generated, framework auxiliar).
- `deprecar`: legacy o archivo archivado fuera del flujo canonico.

## Hallazgos criticos detectados durante el scan

1. `ai-toolings/open-code/oh-my-opencode/src/auth/antigravity/constants.ts` incluye `ANTIGRAVITY_CLIENT_SECRET` hardcodeado.
2. `archive/project_docs/**` mantiene 574 artefactos historicos (principalmente build outputs de Rust) que no aportan al runtime.
3. `docs/_legacy/project_docs/**` quedo en modo stubs-only; sigue pendiente aprobacion para retiro final completo.

## Action items prioritarios

1. Seguridad: revisar `ai-toolings/open-code/oh-my-opencode/src/auth/antigravity/constants.ts` y migrar secretos a entorno/secret manager o confirmar que son credenciales publicas de proveedor.
2. Mantenibilidad: definir politica de retencion para `archive/project_docs/**` (SLA + criterio de purge).
3. Normalizacion documental: ejecutar fase final para eliminar `docs/_legacy/project_docs/` cuando no existan consumidores de ruta.
