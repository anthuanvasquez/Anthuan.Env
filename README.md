# FAANG-style Dotfiles 🚀

Este repositorio contiene mi configuración personal, automatizada y modular. Está diseñado para una portabilidad extrema y una configuración declarativa en macOS, Linux y WSL.

## 🏗️ Estructura

- `home/`: Archivos que se linkean directamente al `$HOME`.
- `config/`: Lógica modular (shell, git, vscode).
- `packages/`: Listas de paquetes declarativos (Brewfile, etc).
- `os/`: Scripts específicos para ajustes del sistema operativo.
- `bin/`: Binarios y scripts personales añadidos al `$PATH`.
- `modules/`: Instalación y configuración modular para herramientas específicas (Node, Docker, etc).
- `scripts/`: Lógica interna para la gestión del repositorio (linking, backups).

## 🚀 Instalación Rápida

Para configurar una nueva máquina desde cero:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/anthuanvasquez/dotfiles/master/bootstrap)"
```

## 🛠️ Ejecución Local

Si ya has clonado el repositorio:

```bash
./install
```

## 🧩 Principios de Diseño

1. **Portabilidad**: Funciona en múltiples plataformas.
2. **Modularidad**: Separación clara entre entorno, aliases, funciones y herramientas.
3. **Automatización**: Un solo comando para recrear todo el entorno.
4. **Declarativo**: El repositorio es la fuente de verdad del estado de la máquina.

---
Mantenido por [Anthuan Vasquez](https://github.com/anthuanvasquez)
