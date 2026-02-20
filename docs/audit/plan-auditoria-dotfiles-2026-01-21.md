# Plan de auditoría y reorganización de `~/.dotfiles`

**Fecha:** 2026-01-21

## Objetivo
Organizar y diagnosticar a fondo el repo de `~/.dotfiles`, detectando:
- Estructura real (módulos, posibles "submódulos" / subproyectos).
- Carpetas ruidosas (logs, caches, `node_modules`, `vendor`, Ruby LSP, etc.) que no deberían vivir en el repo.
- Archivos "basura" o de backup (por ejemplo `VERSION.bak` o `version.back`) para listarlos y decidir qué eliminar.
- Reglas y automatizaciones para mantener el orden a futuro.

## Estado actual (snapshot rápido)

### 1. Estado git
Rama actual: `main`.

- Commits:
  - `main...origin/main [ahead 1]` → hay un commit local no pusheado.

- Archivos modificados (trackeados):
  - `bin/tree/big-folders`
  - `git/.gitconfig`
  - `shell/aliases.sh`
  - `shell/bash/.bashrc`
  - `shell/exports.sh`
  - `shell/functions.sh`
  - `shell/tools.sh`
  - `shell/zsh/.zshrc`

- Archivos/directorios sin trackear (no ignorados por `.gitignore`):
  - `.tool-versions`
  - `DOTFILES_INDEX.md`
  - `WARP.md`
  - `ai-toolings/`
  - `editors/nvim/`

### 2. Directorios más pesados (aprox. `du -h -d 2 .`)

- `project_docs/` → ~178M
  - Especialmente `project_docs/prompts/`.
- `caps-layout/` → ~36M
- `editors/nvim/` → ~42M
- `shell/zsh/` → ~22M
- `ai-toolings/` → ~21M
- `.git/` → ~94M
- `fonts/` → ~13M

Esto sugiere que hay varios **subproyectos/tooling** incrustados en `~/.dotfiles`:
- `editors/nvim/`
- `ai-toolings/`
- `caps-layout/`
- `project_docs/prompts/` como gran almacén de datos/prompts.

### 3. Archivos candidatos a basura / backup (primera pasada)

**Basura de sistema/editor (muy probablemente segura de borrar e ignorar):**
- `./.DS_Store`
- `./shell/.DS_Store`
- `./shell/functions/system-monitor/.DS_Store`
- `./shell/functions/system-monitor/exports/.DS_Store`
- `./editors/.DS_Store`
- `./editors/nvim/lua/angel/plugins/.DS_Store`
- `./terminal/.DS_Store`
- `./caps-layout/.DS_Store`
- `./langs/.DS_Store`
- `./project_docs/.DS_Store`
- `./os/.DS_Store`
- `./.git/.DS_Store`

**Backups / logs / artefactos de build:**
- `./VERSION.bak` → backup manual/antiguo del fichero `VERSION`.
- `./project_docs/prompts/scripts/logs/split.log`.
- Logs de compilación de gems Ruby para entorno de Neovim:
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/prism-1.6.0/mkmf.log`
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/psych-5.2.6/mkmf.log`
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/rbs-3.9.5/mkmf.log`
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/stringio-3.1.7/mkmf.log`
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/io-console-0.8.1/mkmf.log`
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/erb-5.1.3/mkmf.log`
  - `./editors/nvim/vendor/bundle/ruby/3.4.0/extensions/arm64-darwin-23/3.4.0/date-3.5.0/mkmf.log`

Estos son buenos candidatos para:
- Ser añadidos a `.gitignore`.
- Ser borrados en una futura pasada de limpieza (son regenerables).

---

## Plan de acción por fases

### Fase 1 – Reglas de escaneo e ignore

1. Definir patrones globales a ignorar durante el análisis y en git:
   - Directorios ruidosos típicos: `**/node_modules`, `**/vendor`, `**/.git`, `**/.cache`, `**/log`, `**/logs`, `**/tmp`, `**/.next`, `**/.turbo`, `**/dist`, `**/build`, `**/__pycache__`, `**/.ruby-lsp`, etc.
   - Archivos de sistema/IDE: `.DS_Store`, `**/.idea`, `**/.vscode`, caches de herramientas.
   - Backups y logs genéricos: `*.back`, `*.bak`, `*.old`, `*.orig`, `*~`, `*.tmp`, `*.log`.

2. Opciones para centralizar estas reglas:
   - Reforzar/ajustar `.gitignore` con estos patrones.
   - Opcional: crear un archivo específico de escaneo (`.dotfiles_scanignore`) que use los mismos patrones que `.gitignore` + algunos adicionales específicos de análisis.

### Fase 2 – Inventario estructural más profundo

1. Hacer un recorrido controlado del árbol (uno o varios de estos):
   - Árbol resumido: `find` o `tree` limitado en profundidad (ej. depth 2–3).
   - `du -h` a más profundidad en directorios sospechosos (`editors/nvim`, `ai-toolings`, `caps-layout`, `project_docs`).

2. Objetivo del inventario:
   - Entender dónde se mezclan:
     - Dotfiles puros (config & scripts pequeños).
     - Proyectos/entornos grandes (con dependencias, vendors, etc.).

### Fase 3 – Detección de subproyectos / submódulos potenciales

1. Buscar indicadores de proyectos dentro de `~/.dotfiles`:
   - Archivos como `package.json`, `pnpm-lock.yaml`, `yarn.lock`, `Gemfile`, `Gemfile.lock`, `Cargo.toml`, `go.mod`, etc.
   - Estructuras típicas de app (por ejemplo `src/`, `app/`, `bin/`, `config/` en subcarpetas como `ai-toolings` o `editors/nvim`).

2. Clasificar cada bloque en:
   - **Dotfiles puros**: config directa de herramientas, scripts auxiliares pequeños.
   - **Proyectos/tooling**: cosas grandes que quizá convenga:
     - Mover a otros repos (por ejemplo bajo `~/Vaults/...`).
     - Convertir en submódulos git si son reutilizables.

3. Decidir, para cada uno de los candidatos obvios:
   - `editors/nvim/`
   - `ai-toolings/`
   - `caps-layout/`

### Fase 4 – Detección sistemática de archivos basura / backups

1. Escanear periódicamente patrones de basura:
   - Backups: `*.back`, `*.bak`, `*.old`, `*.orig`, `*~`, `*.tmp`.
   - Artefactos de editores: `*.swp`, `*.swo`, `.#*`, `#*#`.
   - Logs persistentes: `*.log`, directorios `log/` o `logs/` que no deban ser versionados.
   - Casos concretos: `VERSION.bak`, futuros `version.back`, etc.

2. Para cada archivo encontrado:
   - Ver si existe la versión "real" asociada (ej: `VERSION` vs `VERSION.bak`).
   - Evaluar antigüedad y uso.

3. Clasificar resultados en dos grandes grupos:
   - **Muy probablemente basura y segura de borrar**.
   - **Revisar manualmente** (si están en zonas sensibles o tienen nombres ambiguos).

4. Mantener una lista actualizable (como este archivo) con:
   - Ruta.
   - Categoría.
   - Decisión tomada (mantener, archivar, borrar).

### Fase 5 – Propuesta de limpieza y reorganización

1. A partir del inventario + clasificación de subproyectos y basura:
   - Señalar directorios a vaciar o excluir de git.
   - Proponer sacar proyectos grandes fuera de `~/.dotfiles`.

2. Sugerir una estructura deseada, por ejemplo:

   - `shell/` → configuraciones y funciones pequeñas.
   - `editors/` → **sólo** configuraciones mínimas; proyectos Neovim complejos en otro repo.
   - `ai-toolings/` → mover a `~/Vaults/...` si es un proyecto en sí.
   - `caps-layout/` → decidir si es tooling portátil que merece repo propio.
   - `project_docs/` → mantener como knowledge base, pero evitando logs/artefactos.

3. Opcional: crear carpetas como:
   - `scripts/maintenance/` para scripts de escaneo y limpieza.
   - `archive/` para backups que se quieran conservar pero no mezclar con el código vivo.

### Fase 6 – Automatización (scripts + Make)

1. Crear un script (ej: `scripts/scan_dotfiles.sh`) que:
   - Aplique reglas de ignore (leyendo de `.gitignore` y/o `.dotfiles_scanignore`).
   - Liste:
     - Archivos de basura detectados.
     - Subproyectos sospechosos.

2. Añadir targets de Make, por ejemplo:
   - `make lint-structure` → corre el script de escaneo y muestra anomalías.
   - `make clean-extra` → opción futura para limpiar logs/caches/DS_Store.

3. Documentar brevemente en:
   - `project_docs/README.md` o `WARP.md`:
     - Cómo se corre el escaneo.
     - Qué patrones usa para decidir basura vs válido.

### Fase 7 – Reglas de diseño para el futuro

Definir criterios sencillos para usar como brújula:

1. **Ubicación de cosas:**
   - Sólo configuración y scripts pequeños viven en `~/.dotfiles`.
   - Apps, herramientas grandes o proyectos con dependencias (`node_modules`, `vendor`, etc.) viven en otros repos y, si hace falta, se referencian desde los dotfiles (PATH, alias, etc.).

2. **Qué nunca se commitea:**
   - Caches, logs, backups locales.
   - Archivos de sistema (`.DS_Store`) o IDE.

3. **Guardrails técnicos:**
   - Reforzar `.gitignore` para estas reglas.
   - Usar el script de escaneo antes de commits grandes para evitar que se cuelen artefactos.

---

## Sugerencia de flujo cuando retomes este plan

Cuando retomes este archivo en el futuro, un flujo razonable sería:

1. **Crear una rama de trabajo** para no tocar directamente `main`:
   - Nombre sugerido: `chore/dotfiles-auditoria-limpieza`.

2. **Revisar el snapshot de estado actual** (esta sección) y actualizarlo si hizo cambios grandes desde hoy.

3. **Empezar por la Fase 1 y 4** (rules de ignore + limpieza de basura obvia):
   - Ajustar `.gitignore`.
   - Borrar `.DS_Store`, `*.log` no necesarios, logs de `mkmf.log`, etc.

4. **Seguir con inventario y subproyectos** (Fases 2 y 3) antes de mover nada físico de lugar.

5. **Iterar sobre este archivo** como registro de decisiones:
   - Añadir pequeñas notas de qué se movió/borró y por qué.

De esta manera, este documento funciona como "ancla" del plan, con fecha, que podés ir versionando y consultando cuando vuelvas a trabajar sobre la organización de `~/.dotfiles`.