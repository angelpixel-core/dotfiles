# Dotfiles 🚀

> Entorno de desarrollo personal modular y automatizado

## 📋 Descripción

Sistema de gestión de configuraciones personales (dotfiles) diseñado para:
- **Instalación rápida**: Setup completo en < 5 minutos
- **Modular**: Instala solo lo que necesitas
- **Portable**: Compatible con macOS y Linux
- **Versionado**: Control total sobre cambios
- **Automatizado**: Scripts idempotentes y robustos

## 🚀 Instalación Rápida

```bash
# Clonar repositorio
git clone https://github.com/username/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Instalación completa
make install

# O instalación modular
make install-nvim
make install-tmux
```

## 📦 Módulos Disponibles

| Módulo | Descripción | Archivos |
|--------|-------------|----------|
| `editors` | Neovim, LSP, formatters | `~/.config/nvim/` |
| `terminal` | tmux, alacritty | `~/.tmux.conf`, `~/.config/alacritty/` |
| `shell` | zsh, bash, aliases | `~/.zshrc`, `~/.bashrc` |
| `workflow` | direnv, git | `~/.gitconfig`, `~/.direnvrc` |
| `wm` | yabai, skhd (macOS) | `~/.config/yabai/`, `~/.config/skhd/` |

## 🛠️ Herramientas CLI

```bash
# Añadir bin/ al PATH
export PATH="$HOME/.dotfiles/bin:$PATH"

# Herramientas disponibles
dift        # Diff mejorado con colores
serve       # Servidor HTTP local
backup      # Backup de configuraciones
dotfiles    # Meta-herramienta de gestión
```

## 📖 Uso Avanzado

### Instalación Selectiva

```bash
# Solo herramientas de terminal
make install-terminal install-shell

# Con opciones
./bootstrap/install.sh --dry-run --verbose
```

### Backup y Restauración

```bash
# Crear backup antes de cambios
make backup

# Restaurar si algo sale mal
make restore
```

### Actualización

```bash
# Actualizar desde git y reinstalar
make update
```

## 🧪 Testing

```bash
# Ejecutar todos los tests
make test

# Validar sintaxis
make lint

# Verificar dependencias
make check
```

## 📁 Estructura

```
dotfiles/
├── bin/          # Herramientas CLI ejecutables
├── config/       # Configuraciones por módulo
├── lib/          # Librerías bash compartidas
├── bootstrap/    # Scripts de instalación
├── tests/        # Tests unitarios e integración
└── docs/         # Documentación adicional
```

## ⚙️ Requisitos

### Mínimos
- Git
- Bash 4.0+
- make

### Recomendados
- [Homebrew](https://brew.sh) (macOS)
- curl o wget
- shellcheck (para linting)

## 🤝 Contribuir

Ver [CONTRIBUTING.md](docs/CONTRIBUTING.md) para guías de contribución.

## 📝 Licencia

MIT - Ver [LICENSE](LICENSE) para detalles.

## 🙏 Agradecimientos

Inspirado por la comunidad de dotfiles y proyectos como:
- [holman/dotfiles](https://github.com/holman/dotfiles)
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)
