# Tabla de referencia prompt-by-prompt (project-docs)

Matriz canónica para revisar cada archivo de `docs/prompts/project-docs/` con intención, estado y siguientes acciones.

## Resumen

| estado | cantidad |
|---|---:|
| resuelto | 37 |
| pendiente | 27 |
| re-evaluar | 3 |
| deprecar | 1 |

## Tabla

| # | archivo | intención | estado | action items |
|---|---|---|---|---|
| 00a | `00a-Crear_estructura_base_con_versionado.md` | Crear estructura base con versionado | resuelto | Mantener semver + lockfile y validar en CI. |
| 00b | `00b-Implementar_sistema_de_logging.md` | Implementar sistema de logging | resuelto | Estandarizar formato de logs en todos los scripts. |
| 00c | `00c-Crear_detección_de_plataforma.md` | Crear detección de plataforma | resuelto | Agregar tests unitarios para detección de plataforma. |
| 00d | `00d-Setup_CI_CD_con_GitHub_Actions.md` | Setup CI CD con GitHub Actions | resuelto | Expandir CI a lint/test multiplataforma. |
| 01 | `01-Análisis_profundo_del_estado_actual.md` | Análisis profundo del estado actual | resuelto | Actualizar auditoría al estado post-cleanup. |
| 02 | `02-Evaluación_de_calidad_del_código.md` | Evaluación de calidad del código | resuelto | Agregar métricas de calidad automáticas. |
| 03 | `03-Detección_de_problemas_de_seguridad.md` | Detección de problemas de seguridad | resuelto | Agregar baseline de gitleaks para ruido controlado. |
| 04 | `04-Análisis_de_estructura_y_organización.md` | Análisis de estructura y organización | resuelto | Mantener inventario al mover carpetas. |
| 05 | `05-Diseño_de_nueva_arquitectura_modular.md` | Diseño de nueva arquitectura modular | resuelto | Formalizar ADRs nuevos en 'docs/decisions/'. |
| 06 | `06-Crear_workflow_de_implementación.md` | Crear workflow de implementación | resuelto | Cerrar checklist final de migración. |
| 07 | `07-Estimar_esfuerzo_de_migración.md` | Estimar esfuerzo de migración | resuelto | Actualizar estimaciones con estado real actual. |
| 08 | `08-Crear_estructura_base_de_directorios.md` | Crear estructura base de directorios | resuelto | Evitar nuevas carpetas fuera de canon sin ADR. |
| 09 | `09-Implementar_sistema_de_bootstrap.md` | Implementar sistema de bootstrap | resuelto | Agregar casos de error y rollback testados. |
| 10 | `10-Crear_instalador_modular.md` | Crear instalador modular | resuelto | Completar 'make list/status' (hoy referencian rutas/comandos faltantes). |
| 11 | `11-Refactorizar_configuración_de_Zsh.md` | Refactorizar configuración de Zsh | pendiente | Ejecutar refactor pendiente del plan de shell. |
| 12 | `12-Organizar_exports__aliases_y_funciones.md` | Organizar exports / aliases y funciones | resuelto | Reducir lógica residual de entorno en '.zshrc'/'.bashrc'. |
| 13 | `13-Implementar_sistema_de_auto_carga_modular.md` | Implementar sistema de auto carga modular | resuelto | Unificar entrypoint en documentación con ejemplos de carga. |
| 14 | `14-Implementar_gestor_ASDF_mejorado.md` | Implementar gestor ASDF mejorado | re-evaluar | Definir estrategia ASDF (instalación, updates y healthcheck). |
| 15 | `15-Crear_scripts_de_setup_por_lenguaje.md` | Crear scripts de setup por lenguaje | resuelto | Agregar README por lenguaje con comando bootstrap concreto. |
| 16 | `16-Configurar_servidores_MCP.md` | Configurar servidores MCP | resuelto | Versionar plantilla activa de configuración MCP. |
| 17 | `17-Crear_comandos_SuperClaude_personalizados.md` | Crear comandos SuperClaude personalizados | pendiente | Definir si SuperClaude sigue en scope o se depreca. |
| 18 | `18-Migrar_scripts_existentes.md` | Migrar scripts existentes | resuelto | Documentar scripts migrados vs legacy explícitamente. |
| 19 | `19-Implementar_funciones_reutilizables.md` | Implementar funciones reutilizables | resuelto | Expandir reutilización para evitar duplicación shell. |
| 20 | `20-Generar_README_principal.md` | Generar README principal | resuelto | Sincronizar README raíz con índice canónico cuando cambie estructura. |
| 21 | `21-Documentar_arquitectura.md` | Documentar arquitectura | resuelto | Agregar ADR para decisiones recientes de cleanup. |
| 22 | `22-Crear_guías_de_setup.md` | Crear guías de setup | resuelto | Completar guías faltantes por módulo (WM/terminal/editors). |
| 23 | `23-Implementar_tests_de_instalación.md` | Implementar tests de instalación | resuelto | Agregar pruebas más allá de smoke (unit/integration). |
| 24 | `24-Validar_compatibilidad_multi_plataforma.md` | Validar compatibilidad multi plataforma | pendiente | Agregar matrix CI macOS/Linux o validación reproducible equivalente. |
| 25 | `25-Prueba_completa_del_sistema.md` | Prueba completa del sistema | pendiente | Diseñar prueba end-to-end completa de instalación real. |
| 26 | `26-Optimizar_performance_de_carga.md` | Optimizar performance de carga | pendiente | Medir tiempo de carga shell y aplicar optimizaciones guiadas por métricas. |
| 27 | `27-Eliminar_código_muerto_y_duplicado.md` | Eliminar código muerto y duplicado | pendiente | Ejecutar pasada de deduplicación de código/config no solo docs. |
| 28 | `28-Comprimir_y_optimizar_configuraciones.md` | Comprimir y optimizar configuraciones | pendiente | Definir criterio de optimización y compresión de configs. |
| 29 | `29-Preparar_para_versionado.md` | Preparar para versionado | resuelto | Mantener disciplina de bump + changelog técnico. |
| 30 | `30-Crear_estructura_de_branches.md` | Crear estructura de branches | pendiente | Documentar estrategia de ramas para trabajo por fases. |
| 31 | `31-Documentar_cambios.md` | Documentar cambios | resuelto | Consolidar formato único de change report. |
| 32 | `32-Crear_comando_analyze_dotfiles.md` | Crear comando analyze dotfiles | pendiente | Implementar 'bin/analyze_dotfiles' o deprecar prompt. |
| 33 | `33-Crear_comando_sync_dotfiles.md` | Crear comando sync dotfiles | pendiente | Implementar 'bin/sync_dotfiles' o deprecar prompt. |
| 34 | `34-Indexar_todos_los_comandos.md` | Indexar todos los comandos | resuelto | Mantener índice sincronizado con cada cambio de targets/comandos. |
| 35 | `35-Análisis_final_de_calidad.md` | Análisis final de calidad | resuelto | Programar refresh periódico del análisis final. |
| 36 | `36-Generar_reporte_de_migración.md` | Generar reporte de migración | resuelto | Unificar reporte final con fuente única. |
| 37 | `37-Crear_workflow_de_mantenimiento.md` | Crear workflow de mantenimiento | pendiente | Definir workflow recurrente de mantenimiento operativo. |
| 38 | `38-Migrar_configuración_QMK.md` | Migrar configuración QMK | resuelto | Documentar proceso de build/flash paso a paso. |
| 39 | `39-Organizar_fuentes_personalizadas.md` | Organizar fuentes personalizadas | resuelto | Agregar inventario + criterio de instalación de fuentes. |
| 40 | `40-Refactorizar_SketchyBar.md` | Refactorizar SketchyBar | resuelto | Documentar módulos de sketchybar y healthcheck. |
| 41 | `41-Migrar_configuración_Yabai.md` | Migrar configuración Yabai | resuelto | Agregar guía de arranque/servicio de yabai. |
| 42 | `42-Consolidar_shortcuts_SKHD.md` | Consolidar shortcuts SKHD | resuelto | Agregar catálogo de atajos y validación de conflictos. |
| 43 | `43-Migrar_configuración_Alacritty.md` | Migrar configuración Alacritty | resuelto | Documentar fallback terminal y perfiles por OS. |
| 44 | `44-Optimizar_configuración_tmux.md` | Optimizar configuración tmux | pendiente | Definir optimizaciones medibles (latencia/plugins). |
| 45 | `45-Integrar_workflows.md` | Integrar workflows | pendiente | Integrar workflows faltantes en pipeline único. |
| 46 | `46-Configurar_gestión_de_claves_SSH.md` | Configurar gestión de claves SSH | pendiente | Formalizar gestión SSH keys en guía dedicada. |
| 47 | `47-Integrar_hardware_keys.md` | Integrar hardware keys | re-evaluar | Decidir scope real de hardware keys en este repo. |
| 48 | `48-Configurar_GPG_con_hardware.md` | Configurar GPG con hardware | re-evaluar | Si aplica, documentar + automatizar setup GPG hardware. |
| 49 | `49-Gestión_segura_de_secretos.md` | Gestión segura de secretos | resuelto | Mantener política: cero secretos hardcodeados. |
| 50 | `50-Sistema_de_vaults_con_symlinks.md` | Sistema de vaults con symlinks | resuelto | Agregar validación de links rotos al smoke test. |
| 51 | `51-Integración_con_servicios_cloud.md` | Integración con servicios cloud | pendiente | Especificar integraciones cloud activas (AWS/GCP/etc) y mínimos. |
| 52 | `52-Integración_con_Obsidian.md` | Integración con Obsidian | pendiente | Formalizar integración Obsidian (paths, sync, privacidad). |
| 53 | `53-Integración_con_Notion.md` | Integración con Notion | pendiente | Definir si Notion entra en scope o deprecar. |
| 54 | `54-Configuración_Ethereum.md` | Configuración Ethereum | pendiente | Separar setup Ethereum real de referencias genéricas. |
| 55 | `55-Configuración_Bitcoin.md` | Configuración Bitcoin | pendiente | Definir alcance Bitcoin o deprecar. |
| 56 | `56-Integración_Trezor_Suite.md` | Integración Trezor Suite | deprecar | Mantener fuera de scope; no reintroducir Trezor sin decisión explícita. |
| 57 | `57-Scripts_de_seguridad_crypto.md` | Scripts de seguridad crypto | pendiente | Definir scripts crypto concretos o deprecar. |
| 58 | `58-Configuración_Git_con_GPG.md` | Configuración Git con GPG | pendiente | Completar configuración GPG firmada y documentación operativa. |
| 59 | `59-Git_hooks_personalizados.md` | Git hooks personalizados | pendiente | Diseñar hooks versionados y portables. |
| 60 | `60-Templates_y_workflows_Git.md` | Templates y workflows Git | pendiente | Definir templates/workflows Git canónicos del repo. |
| 61 | `61-Implementar_tests_unitarios.md` | Implementar tests unitarios | pendiente | Agregar batería de tests unitarios reales. |
| 62 | `62-Crear_documentación_de_módulos.md` | Crear documentación de módulos | pendiente | Completar documentación por módulo técnico. |
| 63 | `63-Setup_de_releases_automáticos.md` | Setup de releases automáticos | pendiente | Definir pipeline de releases para dotfiles (si aplica). |
| 64 | `64-Validación_final_completa.md` | Validación final completa | pendiente | Definir checklist de validación final de punta a punta. |

## Fuente

- Base técnica: `docs/audit/project-docs-prompts-coverage.csv`
- Versión machine-readable: `docs/audit/project-docs-prompts-reference-table.csv`
- Resumen machine-readable: `docs/audit/project-docs-prompts-reference-summary.json`
