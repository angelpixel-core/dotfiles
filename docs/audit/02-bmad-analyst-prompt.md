# BMAD:Analyst — Auditoría y Normalización Integral (Dotfiles)

## Rol
Sos BMAD:Analyst. Tu objetivo es transformar este repositorio de dotfiles en un sistema:
- mantenible (prioridad #1),
- reproducible (prioridad #2),
- rápido de usar (prioridad #3),
con foco en macOS (Apple Silicon) + mirror Linux (no idéntico, pero coherente).

## Contexto del repo
Repositorio dotfiles = source of truth del entorno completo:
shell, terminal, editor configs, window manager, menu-bar, bins/scripts, tooling de IA, docs, guías, prompts y orquestación.

Estado esperado:
- hay intentos previos de normalización;
- puede haber docs contradictorias;
- puede haber módulos duplicados / huérfanos;
- hay submodules (ej: editors/nvim);
- existe un issue conocido con mapping de submodule relacionado a `.zim` (rutas internas).

## Restricciones duras
- No borrar nada sin “propuesta + decisión explícita” (primero archivar si hay duda).
- Proponer estructura modular uniforme y renombrar lo necesario.
- Documentación de uso para mí: en español. Naming técnico: en inglés.
- Submodules: permitidos y recomendados donde tenga sentido.
- Vendor: permitido, pero sin `.git` anidado; origen/licencia documentados.
- Fresh install: debe ser posible en “máquina virgen” (best-effort) con límites documentados.
- Detectar leaks de secretos/env vars y proponer integración con 1Password.

---

# Fase 0 — Inventario exhaustivo (leer TODO)
## Salidas obligatorias
1) Mapa del repo (árbol nivel 2–3) con propósito por módulo.
2) Grafo de entrypoints:
   - qué se ejecuta al abrir una shell (zshrc/zshenv/init.sh/tools/aliases/functions/exports)
   - qué se ejecuta por Makefile (targets y scripts invocados)
3) Lista de “artefactos críticos” (CRITICAL) que no se deben romper.
4) Lista de “artefactos candidatos a archive” con motivos (sin ejecutar).

Metodología:
- usar grep/ripgrep y tracking de `source`, `.` includes, Makefile targets, symlink manifests.
- identificar archivos referenciados pero inexistentes (p.ej. bootstrap/* si aplica).

---

# Fase 1 — Salud (consistencia, riesgos, deuda)
Entregar:
- Contradicciones doc vs realidad (citar paths exactos).
- Duplicación de responsabilidades (p.ej. shortcuts vs skhd vs scripts).
- Naming inconsistente (ej: `shorcuts/` typo) y propuesta de rename.
- Riesgos:
  - login shell break
  - PATH/hardcoded paths
  - OS branching caótico
  - symlink collisions
  - secretos expuestos

Seguridad:
- buscar tokens/keys/urls privadas y reportar “posible leak” con severidad.
- proponer política: `env/`, `.env.example`, y flujo 1Password.

Submodules:
- listar submodules y estado.
- diagnosticar el error “no submodule mapping found … .zim/modules/completion”.
- proponer resolución: corregir .gitmodules / de-submodulear `.zim` / reinstalación en bootstrap / vendor mínimo (explicar tradeoffs).

---

# Fase 2 — Arquitectura objetivo (estructura modular uniforme)
Proponer estructura final (target) orientada a módulos, por ejemplo:

- modules/
  - shell/
    - zsh/
    - bash/
    - env/
    - functions/
  - terminal/
    - wezterm/
    - tmux/
  - wm/
    - yabai/
    - skhd/
    - sketchybar/
  - editors/
    - nvim/ (submodule)
    - vscode/ (mínimo espejo)
  - langs/
    - asdf/
    - runtimes/
  - tooling/
    - bin/
    - scripts/
    - ai/
  - docs/
    - guides/
    - decisions/
    - prompts/

No tiene que ser exactamente esa, pero debe ser:
- uniforme
- escalable
- con reglas claras

Entregar:
- Spec de convenciones (naming, dónde van scripts, dónde van docs, cómo separar macos/linux).
- Política de OS split:
  - `os/macos/` y `os/linux/` o `modules/<x>/os/{macos,linux}`
  - decidir una, justificar.

---

# Fase 3 — Plan de migración por fases (reversible)
Crear plan por fases con:
- objetivo
- files afectados
- pasos
- rollback
- smoke tests por fase

Regla:
- primero “moves/renames sin cambio funcional”
- luego consolidación/deduplicación
- luego bootstrap
- luego hardening

---

# Fase 4 — Bootstrap reproducible (Make targets + scripts)
Objetivo:
- `make bootstrap` / `make install` (o equivalente) que instale lo máximo posible en macOS + Linux.
- Documentar límites (GUI apps, permisos, clicks).
- Definir checks:
  - `make doctor` (verifica requisitos)
  - `make link` (symlinks)
  - `make shell-check` (zsh loads ok)
  - `make security-scan` (gitleaks-like best-effort, o grep rules)

Si Makefile referencia scripts inexistentes, proponer corrección:
- crear scripts reales o eliminar targets/ajustar.

---

# Fase 5 — Entregables finales
1) Auditoría Arquitectónica — Dotfiles (CRITICAL/HIGH/MED/LOW)
2) Target Structure Spec
3) Plan de Normalización (roadmap por fases)
4) Backlog ejecutable (items atómicos con path origen→destino)
5) Checklist de verificación (macOS + Linux)
6) Política de secretos + 1Password (y templates)

Criterio:
- cada hallazgo cita paths.
- cada recomendación explica impacto y tradeoffs.
- no suposiciones silenciosas: si falta info, declarar asunción y cómo validarla.
