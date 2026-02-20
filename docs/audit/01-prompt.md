# BMAD:Analyst — Auditoría Exhaustiva + Plan de Normalización (Dotfiles Monorepo)

## Contexto
Estoy auditando mi repositorio "dotfiles": un monorepo que centraliza y versiona TODO mi setup de entorno de trabajo (shell, terminal, editores, atajos, WM, bins, lenguajes, docs, prompts, guías y tooling de automatización).
Este repo se ejecuta/afecta mi día a día cada vez que abro la terminal, por lo que cualquier cambio debe ser seguro, reversible y con migración clara.

Repositorio (carpetas típicas detectadas):
- shell/ (bash, zsh, init, aliases, exports, tools, functions)
- symlinks/ (conf*.yaml para linkear dotfiles)
- terminal/ (wezterm, tmux, alacritty)
- editors/ (nvim como submodule)
- tiling-windows-manager/ (yabai, skhd)
- langs/ (setup por runtime/tool)
- bin/ (scripts ejecutables)
- docs/ project_docs/ (guías, roadmap, tasks, planes, logs, prompts)
- ai-toolings/ y _bmad/ (tooling y framework BMAD)
- archivos root: Makefile, DOTFILES_INDEX.md, .tool-versions, .version.lock, etc.

Estado actual:
- Hubo múltiples intentos previos de normalizar; puede haber documentación contradictoria, módulos duplicados, scripts huérfanos, o convenciones rotas.
- Existen submodules (editors/nvim) y puede haber inconsistencias con módulos tipo .zim (submodule mapping roto).

## Preferencias / Restricciones (completar)
- Objetivo principal (ordenar prioridad): <<mantenibilidad / reproducibilidad / velocidad diaria>>
- Plataformas: <<macOS only / macOS + Linux>>
- Soporte Intel: <<sí/no>>
- Entry point actual de instalación: <<make install / script / manual>>
- Política de submodules: <<permitidos / evitar / caso por caso>>
- Política de vendor: <<permitido / evitar>>
- Idioma docs: <<ES / EN / mixto con reglas>>
- Política de deprecación: <<archive vs delete; criterio>>
- Definition of Done: <<documento / plan + PRs / plan + ejecución>>
- Seguridad: secretos deben quedar fuera del repo; detectar posibles leaks: <<sí/no>>

## Tu rol (BMAD:Analyst)
Actuás como auditor/arquitecto de monorepos de dotfiles. Tu salida debe ser:
1) Un diagnóstico preciso del estado actual.
2) Un plan de normalización por fases (con riesgos, esfuerzo, impacto).
3) Un diseño de estructura objetivo (target structure) con reglas.
4) Lista de acciones concretas (movimientos, renombres, consolidaciones) y estrategia de commits atómicos.
5) Un set de checks / tests / “smoke tests” para validar que no rompimos el setup.

NO ejecutes cambios destructivos sin proponer antes un plan reversible.

---

# Fase 0 — Inventario (leer TODO)
## Tarea
Recorrer el repo completo y construir un inventario exhaustivo.

## Entregables
### 0.1 Mapa del repo
- Árbol por módulos (nivel 2–3) + explicación de propósito por carpeta.
- Identificar “core runtime path”: qué se carga al abrir la terminal (p.ej. shell/init.sh → zshrc/bashrc → tools/aliases/exports → functions).
- Identificar “automation path”: targets del Makefile, scripts invocados, y dependencias.

### 0.2 Registro de artefactos
Para cada archivo o grupo relevante, registrar:
- Categoría: (core shell / terminal / editor / WM / lang setup / docs / prompts / automation / legacy / archive candidate)
- Estado: (activo / probable legacy / duplicado / huérfano)
- Referencias: dónde se importa/ejecuta/usa (grep de includes/sources/Makefile targets)
- Riesgo: (alto si afecta login shell, PATH, symlinks, o seguridad)

### 0.3 Dependencias y runtime
- Enumerar dependencias externas (brew/asdf/zim/yabai/skhd/wezterm/etc.).
- Detectar scripts referenciados pero faltantes.
- Detectar rutas hardcodeadas, supuestos de OS, o archivos inexistentes.

---

# Fase 1 — Salud del repositorio (consistencia + seguridad)
## 1.1 Consistencia estructural
- Detectar duplicación de conceptos (p.ej. shortcuts en más de un lugar, aliases repetidos, scripts duplicados).
- Detectar naming inconsistente (shorcuts vs shortcuts; docs dispersos).
- Detectar carpetas “catch-all” que deberían descomponerse.

## 1.2 Documentación y verdad
- Cruzar README/STRUCTURE/Roadmap/tasks/planes con realidad del repo:
  - qué docs están obsoletas
  - qué decisiones ya no aplican
  - contradicciones claras (citar archivos y secciones)
- Proponer cómo versionar “decisiones” (ADR o docs/decisions).

## 1.3 Seguridad
- Buscar posibles secretos (tokens/keys/urls privadas).
- Verificar .gitignore y políticas para no commitear credenciales.
- Proponer patrón seguro: ejemplo `secrets.example` + instrucciones.

## 1.4 Git hygiene / submodules
- Listar submodules actuales y su estado (correcto/roto).
- Si hay submodule mapping inconsistente (p.ej. .zim), proponer resolución:
  - arreglar .gitmodules o
  - eliminar submodule y vendor mínimo o
  - reemplazar por instalación en bootstrap

---

# Fase 2 — Target Architecture (estructura objetivo + reglas)
## Entregables
### 2.1 Principios
Definir principios claros (ejemplos):
- “Un único entrypoint por área”
- “Nada se ejecuta sin estar documentado”
- “Todo módulo tiene README mínimo”
- “OS-specific aislado en capas”
- “Symlinks declarativos y reversibles”

### 2.2 Estructura objetivo
Proponer una estructura target (dos opciones si hay tradeoffs):
- Opción A: mantener taxonomía actual pero normalizada
- Opción B: migrar a estructura por módulos (modules/*)

Para cada opción:
- Pros/cons
- Impacto en usuarios futuros (yo mismo en fresh setup)
- Qué se mueve dónde (mapeo alto nivel)

### 2.3 Convenciones
- Naming (carpetas, scripts, prefijos)
- Dónde vive docs (docs/ vs project_docs/)
- Dónde viven prompts (prompts/ o docs/prompts/)
- Cómo se organiza bin/ (namespacing, permisos, shebangs)
- Cómo separar “core” vs “extras”

---

# Fase 3 — Plan de Normalización por Fases (mínimo riesgo)
## Output requerido: Roadmap con fases
Para cada fase:
- Objetivo
- Archivos afectados
- Riesgo
- Pasos exactos
- Rollback
- Tests / verificación manual

### Fase sugerida (ejemplo, ajustá según hallazgos)
- Fase 1: “Observabilidad” (inventario + docs de entrypoints + fix de submodules)
- Fase 2: “Estructura” (mover/renombrar sin cambiar comportamiento)
- Fase 3: “Consolidación” (deduplicar, eliminar legacy, normalizar naming)
- Fase 4: “Bootstrap” (fresh install end-to-end)
- Fase 5: “Hardening” (lint, pre-commit, CI, checks de secrets)

---

# Fase 4 — Acciones concretas (lista ejecutable)
Generar una lista tipo backlog, con items atómicos y ejemplo de commits:

Formato por item:
- ID
- Acción (move/rename/consolidate/delete/archive)
- Path origen → destino
- Motivo
- Riesgo
- Verificación

Y proponer estrategia de commits:
- commits por módulo
- commits “no funcionales” primero (moves)
- luego consolidación
- luego bootstrap/tests

---

# Fase 5 — Entrega final
Entregar:
1) Documento “Auditoría Arquitectónica — Dotfiles” con:
   - Resumen ejecutivo (CRITICAL/HIGH/MED/LOW)
   - Hallazgos por área
   - Contradicciones doc vs realidad
   - Riesgos y quick wins
2) “Plan de Normalización” (roadmap por fases)
3) “Target Structure Spec” (reglas + layout)
4) “Backlog ejecutable” (acciones concretas)
5) Checklist de verificación (smoke tests):
   - abrir nueva shell → PATH OK
   - zshrc/bashrc no rompen
   - symlinks aplican bien
   - terminal configs cargan
   - WM configs no rompen
   - herramientas core detectables (asdf/brew/etc.)
   - no secrets commiteados

## Criterio de calidad
- Todo hallazgo debe citar paths concretos.
- Toda recomendación debe tener motivo + impacto.
- No suposiciones silenciosas: si falta info, marcar “asunción” y sugerir cómo validarla.

Comenzá por Fase 0 (inventario) y no avances a reestructurar hasta que el mapa del repo esté completo.

# Apéndice — Brief y Decisiones (2026)

## Prioridades (orden)
1) Mantenibilidad
2) Reproducibilidad
3) Velocidad diaria

## Alcance / Source of truth
- Este repositorio es el **source of truth** de mi entorno.
- Objetivo explícito: que agregar herramientas no “ensucie” el $HOME ni vuelva el setup frágil.
- Meta: setup **extensible** (seguiré incorporando tooling, incluso GUI como OBS), con límites documentados:
  - lo automatizable → automatizado
  - lo no automatizable → documentado (pasos, ubicaciones, decisiones)

## Plataformas
- **ZSH + macOS first**.
- Debe existir soporte **Linux** (Unix-like) con atención a diferencias reales (parametrización/toolset diferente).
- Hardware target: **Apple Silicon**.
- No priorizar backward-compat Intel/macOS legacy; solo conservar si el costo es bajo o si hay valor claro.

## Estado actual de instalación / bootstrap
- No hay entrypoint estable hoy.
- Se considera (a futuro) explorar Nix/flake, pero por ahora:
  - diseñar una vía de bootstrap pragmática (scripts + Make targets),
  - y documentar límites (apps GUI, doble click, permisos, etc.).
- Objetivo: **fresh machine bootstrap** en 30–60 min (lo máximo posible), con checklist.

## Tooling core (mínimo)
Obligatorias (base):
- brew (macOS) / alternativa Linux equivalente
- asdf
- git
- zsh + zim (u otro manager si se decide)
- yabai / skhd (tiling WM)
- wezterm
- tmux
- (investigar) Docker y/o alternativa (LXC u otra) como parte del ambiente reproducible

## Filosofía “Core”
Casi todo lo existente hoy se considera core o “core-candidate”.
- tmux se considera core por visión de “ambientes persistentes” y ergonomía por proyecto (panes, servicios, watchers, TDD).
- tiling WM y menu-bar (Sketchybar) son core por “orden del workspace”, aunque no sean terminal.
- shortcuts/skhd: potencial core, pero requiere maduración; revisar y reforzar.

## Política de eliminación / archivo
- No borrar directo:
  - toda eliminación debe pasar por **consulta previa** (decisión explícita).
- Si no se puede decidir en el momento:
  - mover a `archive/` (con README corto: por qué, qué reemplaza, cómo restaurar).
- Regla sugerida (documentada, no automatizada por ahora):
  - “si no lo uso hace ~90 días” → candidato a archive (validación manual).

## Estructura objetivo (decisión)
- NO mantener taxonomía actual por inercia.
- Migrar a una estructura **modular, uniforme, escalable**, con nombres correctos (renombrar lo que haga falta).
- Español para documentación/explicaciones; inglés para naming técnico (variables, componentes, scripts, etc.).

## Submódulos y vendor
- Sí: usar **git submodules** cuando el componente tenga su propio versionado/repositorio.
- Sí: permitir **vendor** cuando sea necesario (toolkits que se copian al home/bin), pero:
  - debe quedar **ordenado dentro del repo** y linkeado por symlinks o scripts,
  - sin metadata git anidada,
  - con licencia y origen documentados.

## Secretos / variables de entorno
- Problema actual: env vars diseminadas (repo, $HOME, .env, etc.).
- Objetivo: normalizar secretos y env vars con disciplina tipo “proyecto serio”:
  - definir estructura de `env/` (o equivalente),
  - templates `.env.example`,
  - guía de integración con **1Password** como backend de secretos.
- Requerido: detectar posibles leaks (keys/tokens/endpoints) y reportar riesgos para decisión.

## Definition of Done
Entrega final debe incluir:
1) Documento de auditoría + plan de refactor por fases.
2) Trabajo preferentemente en branch aparte para normalización.
3) Make targets funcionando (o redefinidos coherentes con repo real).
4) Fresh install verificado:
   - por uso real (mi máquina)
   - y por verificación en entorno “virgen” (contenedor Linux o VM mínima) si es viable.

