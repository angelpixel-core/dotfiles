# Orden de carga de archivos de shell (Zsh y Bash)

**Contexto:** macOS, shell principal Zsh (con Bash aún presente para compatibilidad).

## Zsh – Orden de carga

Zsh carga archivos en este orden (simplificado):

1. **Siempre (todas las shells Zsh):**
   - `/etc/zshenv`
   - `~/.zshenv`

2. **Si es *login shell*:**
   - `/etc/zprofile`
   - `~/.zprofile`

3. **Si es *shell interactiva*:**
   - `/etc/zshrc`
   - `~/.zshrc`

4. **Al final de una *login shell*:**
   - `/etc/zlogin`
   - `~/.zlogin`

5. **Al salir (logout) de una *login shell*:**
   - `/etc/zlogout`
   - `~/.zlogout` (si existe)

### Uso recomendado de cada archivo Zsh

- `~/.zshenv`
  - Se ejecuta SIEMPRE (incluyendo scripts no interactivos).
  - Ideal para:
    - Variables de entorno globales mínimas (`LANG`, rutas base muy necesarias para scripts).
    - Cualquier configuración que deba aplicar incluso en scripts.
  - No poner aquí: alias, prompts, cosas interactivas o lentas.

- `~/.zprofile`
  - Sólo login shells.
  - Uso típico:
    - Ajustes de `PATH` propios de la sesión (por ejemplo, rutas a `~/.asdf/shims`, `~/.cargo/bin`, etc.).
    - Arranque de agentes de sesión (si se necesitan una sola vez al login).

- `~/.zshrc`
  - Sólo shells interactivas.
  - Uso típico:
    - Aliases, funciones interactivas.
    - Prompt, temas, Zim, completions.
    - Integraciones con herramientas interactivas (fzf, zoxide, etc.).

- `~/.zlogin`
  - Se ejecuta al final del proceso de login, después de `~/.zprofile`.
  - Uso típico (opcional):
    - Mensajes de bienvenida.
    - Acciones que deben ocurrir sólo una vez por login y después de cargar todo (poco frecuente).

- `~/.zlogout`
  - Se ejecuta al hacer logout de una login shell.
  - Uso típico (opcional):
    - Limpiar archivos temporales de la sesión.
    - Parar agentes lanzados al login, si no se gestionan solos.
    - Registrar tiempos de sesión o estadísticas.

## Bash – Orden de carga (resumen)

En macOS moderno (donde Zsh es el shell por defecto), Bash suele usarse menos, pero el orden típico es:

- **Login shell (bash):**
  1. `/etc/profile`
  2. `~/.bash_profile` (o `~/.bash_login` o `~/.profile`)

- **Shell interactiva no-login (bash):**
  - `~/.bashrc`

- **Al salir (logout) de una login shell bash:**
  - `~/.bash_logout` (si existe)

Uso recomendado:

- `~/.bash_profile`
  - Configuración de entorno y arranque de sesión cuando se usa Bash como login shell.

- `~/.bashrc`
  - Configuración interactiva (aliases, prompt, completions) cuando se usa Bash en terminales interactivas.

- `~/.bash_logout`
  - Limpieza al salir de una sesión Bash (similar a `~/.zlogout` para Zsh).

## Buenas prácticas generales

- Mantener **variables de entorno globales** en `~/.zshenv` (y en los equivalentes de Bash si hace falta).
- Mantener **configuración interactiva** (aliases, prompt, plugins) en `~/.zshrc` / `~/.bashrc`.
- Usar `~/.zprofile` / `~/.bash_profile` para ajustes de entorno de login (PATH, agentes).
- Usar `~/.zlogin` / `~/.bash_logout` / `~/.zlogout` sólo si realmente se necesitan pasos al inicio o fin de sesión.

Esta guía es referencia para estructurar los archivos en `shell/zsh` y `shell/bash` dentro del repositorio de dotfiles.