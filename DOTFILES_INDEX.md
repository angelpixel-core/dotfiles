# 📚 DOTFILES INDEX

> Índice completo de tu repositorio de dotfiles con descripción detallada de cada módulo y configuración.

## 🏗️ Arquitectura General

Tu sistema de dotfiles está diseñado con los siguientes principios:
- **Modular**: Cada componente es independiente e instalable por separado
- **Portable**: Compatible con macOS (Intel y Apple Silicon) y Linux
- **Versionado**: Sistema de migraciones y control de versiones
- **Automatizado**: Scripts idempotentes con Makefile

## 📁 Estructura de Directorios

```
/Users/angel.szymczak/Vaults/Dotfiles/
├── 📦 Módulos Principales
│   ├── shell/          # Configuraciones de shell (zsh/bash)
│   ├── editors/        # Editores (Neovim, VSCode)
│   ├── terminal/       # Terminal (Alacritty, tmux)
│   ├── git/            # Configuración de Git
│   └── langs/          # Configuraciones de lenguajes
│
├── 🛠️ Sistema y Gestión
│   ├── bin/            # Herramientas CLI ejecutables
│   ├── lib/            # Librerías compartidas de scripts
│   ├── migrations/     # Scripts de migración de versiones
│   └── symlinks/       # Gestión de enlaces simbólicos
│
├── 🖥️ Entorno de Escritorio
│   ├── tiling-windows-manager/  # Yabai (gestor de ventanas)
│   ├── shortcuts/      # Skhd (atajos de teclado)
│   ├── menu-bar/       # Sketchybar (barra personalizada)
│   └── caps-layout/    # QMK (configuración de teclado)
│
├── 📄 Documentación
│   ├── docs/                       # Canon documental (ver docs/README.md)
│   └── docs/_legacy/project_docs/  # Documentación histórica migrada
│
└── 🔧 Infraestructura BMAD
    ├── .bmad-core/     # Configuración del método BMAD
    └── .bmad-infrastructure-devops/  # DevOps BMAD
```

## 📚 Documentación (Entry Point)

- **`docs/README.md`**: índice humano principal de documentación
- **`docs/_legacy/project_docs/`**: material histórico preservado

## 🐚 Shell Configuration

### Archivos Principales
- **`shell/init.sh`**: Punto de entrada principal que carga todas las configuraciones
- **`shell/exports.sh`**: Variables de entorno y PATH
- **`shell/aliases.sh`**: Alias de comandos
- **`shell/functions.sh`**: Funciones personalizadas
- **`shell/tools.sh`**: Configuración de herramientas CLI

### ZSH Configuration
- **`shell/zsh/.zshrc`**: Configuración principal de ZSH
- **`shell/zsh/.zim/`**: Framework Zim para ZSH
  - Incluye módulos de autocompletado, sintaxis highlighting
  - Tema Spaceship para prompt

### Bash Configuration
- **`shell/bash/.bashrc`**: Configuración de Bash
- **`shell/bash/.bash_profile`**: Perfil de Bash

### Variables de Entorno Importantes
```bash
DOTFILES_ROOT="$HOME/.dotfiles"
EDITOR=nvim
NOTES_PATH="${HOME}/Vaults_Backup/Harvis"
OLLAMA_HOST="127.0.0.1:11434"
AWS_REGION="us-east-1"
```

## ✏️ Editor Configuration (Neovim)

### Estructura de Neovim
```
editors/nvim/
├── init.lua                    # Entrada principal
├── .stylua.toml               # Configuración de formateo Lua
└── lua/angel/
    ├── core/                  # Configuración base
    │   ├── init.lua
    │   ├── keymaps.lua       # Mapeo de teclas
    │   └── options.lua       # Opciones generales
    ├── lazy.lua              # Gestor de plugins
    └── plugins/              # Configuración de plugins
        ├── alpha.lua         # Pantalla de inicio
        ├── telescope.lua     # Fuzzy finder
        ├── nvim-tree.lua     # Explorador de archivos
        ├── lualine.lua       # Barra de estado
        ├── copilot.lua       # GitHub Copilot
        ├── chatgpt.lua       # Integración ChatGPT
        └── [40+ más plugins...]
```

### Plugins Destacados
- **LSP**: Configuración completa de Language Server Protocol
- **Treesitter**: Sintaxis avanzada y highlighting
- **Telescope**: Búsqueda fuzzy potente
- **Git**: Fugitive, Gitsigns, Neogit, Lazygit
- **AI**: Copilot, ChatGPT, Gen.nvim
- **Debug**: DAP con UI completa
- **Markdown**: Preview, wiki links, rendering

## 💻 Terminal & Multiplexer

### Alacritty (`terminal/alacritty/`)
- **`alacritty.toml`**: Configuración principal
  - Terminal GPU-acelerado
  - Tema personalizado
  - Fuentes y colores configurados

### Tmux (`terminal/tmux/`)
- **`tmux.conf`**: Configuración de tmux
  - Gestión de sesiones
  - Atajos personalizados
  - Integración con vim

## 🔧 Herramientas CLI (`bin/`)

Herramientas personalizadas disponibles:
- `dift`: Diff mejorado con colores
- `serve`: Servidor HTTP local
- `backup`: Sistema de backup de configuraciones
- `dotfiles`: Meta-herramienta de gestión
- `notetaker`: Sistema de toma de notas

## 🛠️ Herramientas de Desarrollo

### Gestores de Versiones de Lenguajes (`langs/`)
```
langs/
├── elixir/     # Configuración Elixir
├── go/         # Go environment
├── java/       # JVM setup
├── js/         # Node.js, npm, pnpm
├── julia/      # Julia language
├── lua/        # Lua/LuaJIT
├── php/        # PHP setup
├── python/     # Python/pyenv
├── ruby/       # Ruby/rbenv
├── rust/       # Rust/cargo
└── terraform/  # Infrastructure as Code
```

### Git Configuration (`git/.gitconfig`)
- Alias personalizados
- Configuración de usuario
- Herramientas de diff y merge
- Integración con GPG/SSH

## 🖥️ Window Management (macOS)

### Yabai (`tiling-windows-manager/yabai/`)
- Gestor de ventanas tipo tiling para macOS
- Layouts automáticos
- Espacios de trabajo virtuales

### Skhd (`shortcuts/skhd/`)
- Gestor de atajos de teclado
- Integración con Yabai
- Comandos personalizados

### Sketchybar (`menu-bar/sketchybar/`)
- Barra de menú personalizada
- Widgets y monitores de sistema
- Integración con espacios de trabajo

## 🔄 Sistema de Gestión

### Makefile Principal
```make
make help          # Muestra ayuda
make install       # Instalación completa
make install-nvim  # Instalar solo Neovim
make backup        # Crear backup
make restore       # Restaurar backup
make update        # Actualizar desde git
make test          # Ejecutar tests
make lint          # Validar scripts
```

### Migraciones (`migrations/`)
- **`0.0.0_to_0.1.0.sh`**: Setup inicial con soporte shell
- Sistema de versionado semántico
- Rollback automático en errores

### Librerías (`lib/`)
- **`common.sh`**: Funciones comunes
- **`version.sh`**: Gestión de versiones
- **`migration.sh`**: Sistema de migraciones

## 🔧 Configuraciones Especiales

### BMAD Method (`.bmad-core/`)
Método de desarrollo estructurado con:
- **Templates**: PRD, arquitectura, QA
- **Workflows**: Greenfield/Brownfield
- **Agent Teams**: Configuraciones de equipos

### Enlaces Simbólicos (`symlinks/`)
```yaml
conf.yaml         # Configuración base
conf.macos.yaml   # macOS específico
conf.linux.yaml   # Linux específico
```

## 🌟 Características Destacadas

### Integraciones de Herramientas CLI Modernas
- **fzf**: Fuzzy finder con preview
- **eza**: Reemplazo moderno de ls
- **bat**: Cat con syntax highlighting
- **fd**: Find mejorado
- **zoxide**: CD inteligente
- **thefuck**: Corrector de comandos

### Soporte para LLMs
- Configuración de Ollama server
- Integración con modelos locales
- Variables de entorno para OpenAI/Claude

### Sistema de Notas
- Funciones para notas diarias
- Sistema de inbox
- TODOs organizados por fecha

## 🚀 Quick Start

```bash
# Clonar repositorio
git clone <repo> ~/Vaults/Dotfiles
ln -s ~/Vaults/Dotfiles ~/.dotfiles

# Instalación completa
cd ~/.dotfiles
make install

# O instalación selectiva
make install-shell    # Solo shell
make install-nvim     # Solo Neovim
make install-terminal # Solo terminal
```

## 📊 Estado del Sistema

- **Versión**: Sistema con control de versiones
- **Plataformas**: macOS (Intel/M1+), Linux
- **Shell**: ZSH 5.9 como principal
- **Editor**: Neovim con 40+ plugins
- **Terminal**: Alacritty + tmux

## 🔐 Seguridad

### Manejo de Secretos
- Variables de entorno para API keys
- Integración con Trezor para SSH
- GPG para firmas de commits

## 📝 Notas de Mantenimiento

- Los archivos de configuración están versionados
- Sistema de backup antes de cambios
- Tests automatizados disponibles
- Linting con shellcheck

---

*Este índice fue generado el 2025-09-05 y refleja el estado actual de tu repositorio de dotfiles.*
