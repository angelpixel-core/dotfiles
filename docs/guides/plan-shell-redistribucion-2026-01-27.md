# Plan de redistribución de shell (Zsh/Bash)

**Fecha:** 2026-01-27

## Objetivo

Reorganizar la configuración de shell (Zsh y Bash) para:
- Ajustarse al orden de carga estándar de archivos (`.zshenv`, `.zprofile`, `.zshrc`, `.zlogin`, `.zlogout`, `.bash_profile`, `.bashrc`, `.bash_logout`).
- Centralizar el entorno global (PATH, variables, integraciones de herramientas) en `shell/exports.sh`.
- Separar claramente entorno, aliases, funciones y tooling interactivo.
- Eliminar integraciones obsoletas (p.ej. Trezor) y preparar el camino para futuras llaves.

## Referencia

Guía complementaria: `project_docs/guides/shell-load-order-zsh-bash.md`.

## Checklist de tareas (sin aplicar aún)

### 1. `shell/zsh/.zshenv`

- [ ] Unificar el nombre de variable de raíz de dotfiles:
  - Decidir entre `DOTFILES_PATH` y `DOTFILES_ROOT` como nombre canónico y usarlo de forma consistente en todo el repo.
- [ ] Eliminar duplicado de PATH a `.local/bin`:
  - Quitar una de las líneas que hacen `export PATH="$PATH:/Users/angel.szymczak/.local/bin"`.
- [ ] Mover sourcing de entornos específicos a `exports.sh`:
  - Mover:
    - `. "/Users/angel.szymczak/.starkli/env"`
    - `. "$HOME/.cargo/env"`
  - Dejar `.zshenv` sólo con definiciones mínimas (DOTFILES y Zim).

### 2. `shell/zsh/.zshrc`

- [ ] Dejar de redefinir `DOTFILES_ROOT` aquí; usar lo que venga de `.zshenv`.
- [ ] Mover secciones de PATH / entorno a `shell/exports.sh`:
  - PATH de bun (`BUN_INSTALL` + PATH).
  - PATH de pipx (`~/.local/bin`).
  - `PNPM_HOME` + manipulación de PATH.
  - PATH de LM Studio.
  - PATH de Antigravity.
  - `AWS_PROFILE` y `AZ_ACCOUNT` (si se consideran parte del entorno global y no sólo de esta shell).
- [ ] Mover el alias `starkup` a `shell/aliases.sh`.
- [ ] Reorganizar completions y `compinit`:
  - Funciones `_scarb`, `_snforge`, `_sncast` y sus `compdef`.
  - Bloque de Docker completions y `compinit` extra.
  - Objetivo: tener un único bloque de `compinit` y, opcionalmente, un fichero dedicado (`shell/zsh/completions.zsh`).

### 3. `shell/zsh/.zlogin`

- [ ] Mantenerlo casi vacío por ahora (comentario actual).
- [ ] Documentar en `shell/README.md` el uso esperado de `.zlogin` (acciones “one-shot” al final del login si algún día se necesitan).

### 4. `shell/bash/.bashrc`

- [ ] Mantener:
  - Definición de `DOTFILES_ROOT`.
  - `source "$DOTFILES_ROOT/shell/init.sh"`.
  - Bloque de completions Bash propios.
- [ ] Eliminar la lógica basada en `path[*]` (propia de Zsh) para construir `EXPORTED_PATH`.
- [ ] Mover a `shell/exports.sh`:
  - `. "/Users/angel.szymczak/.starkli/env"`.
  - `. "$HOME/.cargo/env"`.
  - PATH de LM Studio.
- [ ] Decidir el destino del alias `h2` (Hydrogen):
  - Mantenerlo como alias específico de Bash, o
  - Moverlo a `shell/aliases.sh` si se quiere disponible también en Zsh.

### 5. `shell/aliases.sh`

- [ ] Eliminar la función `sign-with-trezor` (Trezor deprecado).
- [ ] Buscar y documentar la deprecación de Trezor en `shell/README.md` (sección “Security keys”).
- [ ] Revisar integración con iTerm (`.iterm2_shell_integration.bash` y función `title`):
  - Decidir si se queda aquí o se mueve a un archivo específico de terminal.

### 6. `shell/exports.sh`

- [ ] Centralizar aquí todo el entorno global:
  - Mover desde `.zshenv` y `.zshrc` / `.bashrc`:
    - `.starkli/env` y `.cargo/env`.
    - Configuración de bun (`BUN_INSTALL` + PATH).
    - Configuración de pnpm (`PNPM_HOME` + PATH).
    - PATH de LM Studio.
    - PATH de Antigravity.
    - Añadir PATH a `~/.local/bin` si sigue siendo necesario.
- [ ] Revisar y simplificar el array `path=(...)`:
  - Asegurar orden lógico:
    - ASDF y completions.
    - `~/bin` y binarios de dotfiles.
    - Binaries de lenguajes (PHP, Java, Android, etc.).
    - Homebrew (`/opt/homebrew/...`).
    - `/usr/local/bin` y `/usr/local/sbin`.
    - Binaries de sistema (`/bin`, `/usr/bin`, `/usr/sbin`, `/sbin`).
  - Eliminar rutas obsoletas o duplicadas.
  - Revisar el uso de `"$PATH"` dentro del array para evitar duplicaciones.
- [ ] Revisar variables sensibles (API keys) y planear su migración a gestor de secretos.

### 7. `shell/functions.sh`

- [ ] Mantener funciones `login_git` y `login_1p`, pero:
  - Opcional: parametrizar `login_git` para no hardcodear `ID_KEY_DIR`.
- [ ] Documentar en `shell/README.md` que aquí viven funciones de sesión/autenticación.

### 8. `shell/tools.sh`

- [ ] Confirmar que `tools.sh` sólo se carga en shells interactivas.
- [ ] Revisar servicios:
  - `yabai --start-service`.
  - `skhd --start-service`.
  - Decidir si deben ejecutarse en cada shell o sólo en el login / vía `launchd`.
- [ ] Revisar `neofetch` al final del archivo:
  - Decidir si mantenerlo, condicionarlo por variable o convertirlo en comando manual.
- [ ] Revisar `start_ollama_server`:
  - Definir si se usará como helper manual o parte del arranque automático.
- [ ] Asegurar que `tools.sh` se centra en tooling interactivo y no en definición de entorno global (que debe ir en `exports.sh`).

---

Este plan se ejecutará después de hacer un commit de snapshot del estado actual; las tareas de este checklist se aplicarán en pasos pequeños y revisables, priorizando primero la centralización del entorno en `exports.sh` y la limpieza de integraciones obsoletas (como Trezor).