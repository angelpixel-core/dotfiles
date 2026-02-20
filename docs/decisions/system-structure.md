# Potencial Estructura del Proyecto Dotfiles

```
dotfiles/
├── README.md
├── Makefile
├── VERSION
├── .github/
│   └── workflows/
│       ├── test.yml
│       └── release.yml
├── bin/                 # CLI tools ejecutables
│   ├── dift
│   ├── serve
│   ├── backup
│   └── dotfiles         # Meta-herramienta
├── lib/                 # Librerías compartidas
│   ├── common.sh        # Funciones comunes
│   ├── logging.sh       # Sistema de logs
│   ├── validation.sh    # Validaciones
│   └── platform.sh      # Detección OS
├── config/              # Configuraciones
│   ├── editors/
│   │   ├── nvim/
│   │   └── install.sh
│   ├── terminal/
│   │   ├── tmux/
│   │   ├── alacritty/
│   │   └── install.sh
│   ├── shell/
│   │   ├── aliases.sh
│   │   ├── exports.sh
│   │   ├── functions.sh
│   │   └── install.sh
│   ├── workflow/
│   │   ├── direnv/
│   │   └── install.sh
│   └── wm/              # Window managers
│       ├── yabai/
│       ├── skhd/
│       └── install.sh
├── bootstrap/
│   ├── install.sh       # Script principal
│   ├── symlinks.sh      # Gestión de enlaces
│   └── dependencies.sh  # Instalación de deps
├── tests/
│   ├── unit/
│   └── integration/
└── docs/
    ├── ARCHITECTURE.md
    ├── CONTRIBUTING.md
    └── modules/
```

## Principios de Diseño

### 1. Modularidad
- Cada módulo es independiente
- Instalación selectiva
- Sin dependencias circulares

### 2. Idempotencia
- Scripts ejecutables múltiples veces
- Estado consistente garantizado
- Rollback automático en errores

### 3. Portabilidad
- Compatible macOS/Linux
- Detección automática de plataforma
- Fallbacks para comandos específicos

### 4. Testabilidad
- Tests unitarios para libs
- Tests de integración para instaladores
- CI/CD automatizado
