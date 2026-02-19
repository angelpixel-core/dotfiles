# Dotfiles Deep Scan Audit (macOS-first, Linux-mirror)

## 1) CRITICAL: Fix reversible del submodule roto `.zim/modules/completion`

### Diagnóstico
- Síntoma original: `git submodule status` fallaba con `no submodule mapping found in .gitmodules for path 'shell/zsh/.zim/modules/completion'`.
- Causa: los gitlinks de módulos Zim estaban indexados pero faltaban entradas en `.gitmodules`.

### Fix aplicado (reversible)
- Se agregaron mappings en `.gitmodules` para:
  - `shell/zsh/.zim/modules/completion`
  - `shell/zsh/.zim/modules/environment`
  - `shell/zsh/.zim/modules/input`
  - `shell/zsh/.zim/modules/spaceship`
  - `shell/zsh/.zim/modules/zsh-autosuggestions`
  - `shell/zsh/.zim/modules/zsh-syntax-highlighting`
- Evidencia: `.gitmodules:13`, `.gitmodules:16`, `.gitmodules:19`, `.gitmodules:22`, `.gitmodules:25`, `.gitmodules:28`.

### Comandos exactos (reproducibles)
```bash
git config -f .gitmodules submodule."shell/zsh/.zim/modules/completion".path shell/zsh/.zim/modules/completion
git config -f .gitmodules submodule."shell/zsh/.zim/modules/completion".url https://github.com/zimfw/completion.git
git config -f .gitmodules submodule."shell/zsh/.zim/modules/environment".path shell/zsh/.zim/modules/environment
git config -f .gitmodules submodule."shell/zsh/.zim/modules/environment".url https://github.com/zimfw/environment.git
git config -f .gitmodules submodule."shell/zsh/.zim/modules/input".path shell/zsh/.zim/modules/input
git config -f .gitmodules submodule."shell/zsh/.zim/modules/input".url https://github.com/zimfw/input.git
git config -f .gitmodules submodule."shell/zsh/.zim/modules/spaceship".path shell/zsh/.zim/modules/spaceship
git config -f .gitmodules submodule."shell/zsh/.zim/modules/spaceship".url https://github.com/spaceship-prompt/spaceship-prompt.git
git config -f .gitmodules submodule."shell/zsh/.zim/modules/zsh-autosuggestions".path shell/zsh/.zim/modules/zsh-autosuggestions
git config -f .gitmodules submodule."shell/zsh/.zim/modules/zsh-autosuggestions".url https://github.com/zsh-users/zsh-autosuggestions.git
git config -f .gitmodules submodule."shell/zsh/.zim/modules/zsh-syntax-highlighting".path shell/zsh/.zim/modules/zsh-syntax-highlighting
git config -f .gitmodules submodule."shell/zsh/.zim/modules/zsh-syntax-highlighting".url https://github.com/zsh-users/zsh-syntax-highlighting.git
git submodule sync --recursive
git submodule status
```

### Rollback reversible
```bash
mkdir -p archive/rollback-$(date +%Y%m%d_%H%M%S)
cp .gitmodules archive/rollback-$(date +%Y%m%d_%H%M%S)/.gitmodules.after-zim-fix
git restore .gitmodules
git submodule sync --recursive
git submodule status
```

## 2) CRITICAL: Makefile referencia `bootstrap/*` inexistente

### Diagnóstico
- Referencias rotas (antes): `bootstrap/install.sh`, `bootstrap/backup.sh`, `bootstrap/restore.sh`, `bootstrap/check-deps.sh`, `tests/run.sh`.
- Impacto: `make install|backup|restore|check|test` rotos por rutas inexistentes.

### Fix aplicado
- Ajuste de targets en `Makefile` a rutas reales:
  - `scripts/bootstrap/install.sh` (`Makefile:67`, `Makefile:71`)
  - `scripts/bootstrap/backup.sh` (`Makefile:85`)
  - `scripts/bootstrap/restore.sh` (`Makefile:91`)
  - `scripts/tests/run.sh` (`Makefile:99`)
  - `scripts/bootstrap/check-deps.sh` (`Makefile:107`)
- Estructura mínima creada:
  - `scripts/bootstrap/lib.sh`
  - `scripts/bootstrap/install.sh`
  - `scripts/bootstrap/check-deps.sh`
  - `scripts/bootstrap/backup.sh`
  - `scripts/bootstrap/restore.sh`
  - `scripts/tests/run.sh`

### Smoke de verificación ejecutado
- `make test` -> OK (sintaxis scripts, paths Makefile, submodule mapping).

### Rollback reversible
```bash
stamp=$(date +%Y%m%d_%H%M%S)
mkdir -p archive/rollback-$stamp
mv scripts/bootstrap archive/rollback-$stamp/
mv scripts/tests archive/rollback-$stamp/
git restore Makefile
```

## 3) Leaks/Secrets: hallazgos + política env + 1Password

### Hallazgos por severidad

#### CRITICAL
- Secreto hardcodeado detectado en auditoría (ya removido en remediación):
  - `shell/exports.sh` (antes contenía `export MXBAI_API_KEY=...`)
  - Acción aplicada: carga desde `env/.env.local` y/o URI de 1Password (`op read`)

#### HIGH
- Build artifacts trackeados con paths locales y metadata de host/toolchain:
  - `project_docs/prompts/scripts/split/rust/target/**` (573 archivos trackeados)
  - Ejemplo: `project_docs/prompts/scripts/split/rust/target/.rustc_info.json:1`
- Paths absolutos de usuario en configuración activa (portabilidad + metadata leak):
  - `shell/exports.sh:111`
  - `shell/exports.sh:112`
  - `shell/zsh/.zshrc:49`
  - `shell/zsh/.zshrc:92`
  - `shell/zsh/.zshrc:98`

#### MED
- Enlaces de 1Password con identificadores de item/vault en comentarios (no secreto directo, sí metadata sensible):
  - `shell/exports.sh:204`
  - `shell/exports.sh:208`
  - `shell/exports.sh:211`
- Paths absolutos en docs y configs no runtime críticos:
  - `DOTFILES_INDEX.md:16`
  - `caps-layout/qmk/qmk.ini:2`

#### LOW
- Placeholders de API key en documentación:
  - `project_docs/guides/01-MCP-Setup-with-Claude-Code.md:16`

### Estrategia propuesta (env + 1Password)
1. Rotar inmediatamente el token expuesto (`MXBAI_API_KEY`) y revocar el valor actual.
2. Eliminar secretos de `shell/exports.sh`; dejar solo carga por entorno.
3. Introducir `scripts/bootstrap/load-secrets.sh` usando `op`:
   - `op run --env-file .env.local -- <command>` para sesiones puntuales.
   - O `export MXBAI_API_KEY="$(op read op://Vault/Item/field)"` en wrapper local no trackeado.
4. Versionar solo `.env.example`; ignorar `.env.local`, `.env`, `.secrets/`.
5. Agregar escaneo de secretos en CI/pre-commit (`gitleaks` o equivalente).
6. Mover artifacts generados fuera de paths trackeados (`archive/` o `tmp/`) y agregar reglas `.gitignore`.

## 4) Entrypoints reales (con líneas)

### Cadena de inicialización ZSH
1. `shell/zsh/.zshenv:2` define `DOTFILES_ROOT`.
2. `shell/zsh/.zshenv:3` define `ZIM_HOME`.
3. `shell/zsh/.zshrc:20` carga Zim (`$ZIM_HOME/init.zsh`).
4. `shell/zsh/.zshrc:28` carga `shell/init.sh`.
5. `shell/init.sh:2` carga `shell/exports.sh`.
6. `shell/init.sh:6` carga `shell/aliases.sh`.
7. `shell/init.sh:8` carga `shell/tools.sh`.
8. `shell/init.sh:11` carga `shell/functions.sh`.

### Symlinks declarativos
- Base links en `symlinks/conf.yaml:12`..`symlinks/conf.yaml:19`.
- Instalación ahora pasa por `scripts/bootstrap/install.sh:37`..`scripts/bootstrap/install.sh:50`.
- Parser/aplicador YAML en `scripts/bootstrap/lib.sh:36`..`scripts/bootstrap/lib.sh:79`.

### Makefile operativo
- `install`: `Makefile:65`..`Makefile:67`
- `install-%`: `Makefile:69`..`Makefile:71`
- `backup`: `Makefile:82`..`Makefile:85`
- `restore`: `Makefile:87`..`Makefile:91`
- `test`: `Makefile:97`..`Makefile:99`
- `check`: `Makefile:105`..`Makefile:107`

## 5) Roadmap por fases + backlog ejecutable + smoke tests

### Target structure modular uniforme (propuesta)
- `shell/` -> runtime shell (exports, aliases, tools, functions, zsh/bash)
- `scripts/bootstrap/` -> instalación, backup/restore, checks
- `scripts/tests/` -> smoke tests de integridad
- `platform/` (opcional futuro) -> `os/`, `terminal/`, `menu-bar/`, `tiling-windows-manager/`, `shortcuts/`
- Rename controlado: `shorcuts/` -> `shortcuts/`

### Fases (reversibles)

#### Fase 0 - Contención (inmediata)
- Rotar secreto expuesto.
- Congelar nuevos secrets en repo con scanner.

#### Fase 1 - Bootstrap baseline (hecho en esta iteración)
- Fix submodule mappings `.zim`.
- Crear `scripts/bootstrap/*` + ajustar Makefile.

#### Fase 2 - Normalización de estructura
- Rename `shorcuts/` -> `shortcuts/`.
- Actualizar referencias en docs (`DOTFILES_INDEX.md`, `WARP.md`, prompts).

#### Fase 3 - Secrets hygiene
- Externalizar variables sensibles a 1Password + env local no trackeado.
- Eliminar metadata sensible en comentarios de exports.

#### Fase 4 - Artifact hygiene
- Mover `project_docs/prompts/scripts/split/rust/target/**` a `archive/`.
- `.gitignore` para evitar retracking.

#### Fase 5 - Linux mirror
- Validar parity de instalación en Linux (`conf.linux.yaml`, smoke scripts).

### Backlog atómico (origen -> destino)
1. `.gitmodules` (sin mappings Zim) -> `.gitmodules` con 6 mappings explícitos.
2. `Makefile` rutas `bootstrap/*` -> `scripts/bootstrap/*`.
3. `Makefile` `tests/run.sh` -> `scripts/tests/run.sh`.
4. `shell/exports.sh` secreto hardcodeado -> `shell/exports.sh` sin secreto + loader 1Password.
5. `project_docs/prompts/scripts/split/rust/target/**` trackeado -> `archive/rust-target-snapshots/**` + `.gitignore`.
6. `shorcuts/` -> `shortcuts/` + refs de docs sincronizadas.

### Smoke tests (macOS y Linux)

#### Base
```bash
make check
make test
git submodule status
bash -n scripts/bootstrap/*.sh scripts/tests/run.sh
```

#### macOS (Apple Silicon)
```bash
make install
zsh -lc 'echo $DOTFILES_ROOT && echo $ZIM_HOME'
```

#### Linux mirror
```bash
make install-linux || make install --module linux
bash -lc 'echo $DOTFILES_ROOT'
```

### Riesgos abiertos
- `Makefile:list` apunta a `$(DOTFILES_DIR)/config` (`Makefile:111`) pero el repo usa `symlinks/`.
- `bin/init.sh` vacío: define intención pero no implementación (`bin/init.sh:1`).
