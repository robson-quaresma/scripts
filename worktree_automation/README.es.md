# 🌳 Git Worktree Manager

> **Language / Idioma / Idioma:** [🇺🇸 English](README.md) | [🇧🇷 Português](README.pt-BR.md) | [🇪🇸 Español](README.es.md)

Script interactivo para gestionar Git worktrees de forma simple y automatizada.

## 📋 Índice

- [Acerca de](#acerca-de)
- [Prerequisitos](#prerequisitos)
- [Estructura de Directorios](#estructura-de-directorios)
- [Instalación](#instalación)
- [Uso](#uso)
- [Desinstalación](#desinstalación)
- [Resolución de Problemas](#resolución-de-problemas)
- [Replicar en Otras Computadoras](#replicar-en-otras-computadoras)

## 🎯 Acerca de

**Git Worktree Manager** (`wt`) es una herramienta que automatiza la creación y gestión de Git worktrees, permitiendo trabajar en múltiples ramas simultáneamente sin necesidad de hacer stash o cambiar de rama constantemente.

### Funcionalidades

✅ **Creación Interactiva**: Crea worktrees con interfaz guiada
✅ **Eliminación Segura**: Elimina worktrees con confirmación
✅ **Listado**: Visualiza todos los worktrees activos
✅ **Validación Automática**: Garantiza que estás en la rama `main` antes de operar
✅ **Nomenclatura Inteligente**: Sanitiza nombres automáticamente
✅ **Configuración Flexible**: Configura directorio de trabajo y agente IA
✅ **Soporte Multi-Agente**: Claude, Cursor, Gemini, Copilot, Windsurf y más
✅ **Multi-idioma**: Soporte para Inglés, Portugués (BR) y Español
✅ **Interfaz Colorida**: Salida visual e intuitiva

## 📦 Prerequisitos

### Sistema Operativo
- macOS (probado)
- Linux (compatible)

### Software Necesario
- Git 2.5+
- Bash 4.0+
- zsh o bash (shell)

### Configuración Inicial

En la primera ejecución, el script solicitará que configure el **directorio de trabajo** donde se encuentran sus proyectos Git.

**Estructura recomendada:**

```
~/projects/                         # Su directorio de proyectos
├── proyecto1/                      # Repositorio Git (rama main)
│   └── .git/
├── proyecto2/                      # Repositorio Git (rama main)
│   └── .git/
└── proyecto3/                      # Repositorio Git (rama main)
    └── .git/
```

**IMPORTANTE:**
- El directorio puede ser cualquier carpeta que contenga sus proyectos Git
- Cada proyecto debe tener un repositorio Git válido
- Los worktrees se crearán al mismo nivel que los proyectos
- La configuración se guarda en `~/.wt_config` y puede cambiarse en cualquier momento

**Ejemplo después de crear worktrees:**
```
~/projects/
├── myapp/                          # Proyecto principal (main)
├── feat_myapp_user-auth/           # Worktree: feat/user-auth
├── fix_myapp_login/                # Worktree: fix/login
├── release_myapp_v1.2.0/           # Worktree: release/v1.2.0
└── refactor_myapp_database/        # Worktree: refactor/database
```

## 🚀 Instalación

### Instalación Automática (Recomendado)

1. **Clone o navegue hasta el directorio del script:**
   ```bash
   cd /path/to/worktree_automation
   ```

2. **Ejecute el instalador:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **Active el script (elija una opción):**

   **Opción A - Recargar shell:**
   ```bash
   source ~/.zshrc    # Para zsh
   # o
   source ~/.bashrc   # Para bash
   ```

   **Opción B - Abrir nuevo terminal:**
   ```bash
   # Simplemente abra una nueva ventana/pestaña del terminal
   ```

4. **Configure el directorio de trabajo:**

   En la primera ejecución del comando `wt`, se le pedirá configurar el directorio donde se encuentran sus proyectos Git.

   ```bash
   wt
   # Ingrese la ruta completa (use Tab para autocompletar)
   # Ejemplo: ~/projects  o  ~/workspace/repos
   ```

### Lo que Hace el Instalador

El script `install.sh` realiza automáticamente:

1. ✅ Crea el directorio `~/bin/` (si no existe)
2. ✅ Crea enlace simbólico: `~/bin/wt` → `wt.sh`
3. ✅ Agrega `~/bin` al PATH
4. ✅ Crea alias `wt` en la configuración del shell
5. ✅ Configura `.zshrc`, `.bashrc` o `.bash_profile`
6. ✅ Valida la instalación
7. ✅ Lista proyectos Git disponibles

### Instalación Manual

Si prefiere instalar manualmente:

1. **Crear directorio ~/bin:**
   ```bash
   mkdir -p ~/bin
   ```

2. **Crear enlace simbólico:**
   ```bash
   ln -s /path/to/worktree_automation/wt.sh ~/bin/wt
   chmod +x /path/to/worktree_automation/wt.sh
   ```

3. **Agregar a la configuración del shell (.zshrc o .bashrc):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   echo 'alias wt="$HOME/bin/wt"' >> ~/.zshrc
   ```

4. **Recargar shell:**
   ```bash
   source ~/.zshrc
   ```

5. **Configure el directorio de trabajo:**
   ```bash
   wt
   # En la primera ejecución, configure su directorio de proyectos
   ```

## 💻 Uso

### Sintaxis

```bash
wt [proyecto] [operación]
```

### Modos de Uso

#### 1️⃣ Modo Totalmente Interactivo (Recomendado)

```bash
wt
```

El script:
1. Listará todos los proyectos Git disponibles (menú numérico)
2. Solicitará que elija el número del proyecto
3. Validará el proyecto seleccionado
4. Mostrará menú de opciones (crear/eliminar/listar)

**Ejemplo:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Proyectos disponibles:

  1) project-a
  2) myapp
  3) website

Elija el número del proyecto (o 'q' para salir): 2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ️  Proyecto: myapp
ℹ️  Directorio: ~/projects/myapp

✅ En la rama main ✓

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1) Crear nuevo worktree
  2) Eliminar worktree existente
  3) Listar worktrees
  4) Configurar directorio de trabajo
  5) Configurar agente IA
  6) Cambiar idioma
  7) Salir

📂 Directorio actual: ~/projects
🤖 Agente: claude (fijo)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Elige una opción: _
```

#### 2️⃣ Modo Interactivo con Proyecto

```bash
wt myapp
```

Especifica el proyecto y muestra el menú de operaciones.

#### 3️⃣ Modo Directo

```bash
# Crear worktree
wt myapp crear

# Eliminar worktree
wt myapp remover

# Listar worktrees
wt myapp listar
```

### Crear Worktree

1. **Elija el tipo:**
   - `1` para `feat` (feature)
   - `2` para `fix` (bugfix)
   - `3` para `release`
   - `4` para `refactor`
   - `5` para `Otro (personalizado)` - permite ingresar cualquier prefijo

2. **Ingrese el nombre:**
   - Ejemplo: `user authentication`
   - Será convertido a: `user-authentication`

3. **Confirme la creación**

**Resultado (ejemplo con proyecto "myapp" y tipo "feat"):**
- Rama creada: `feat/user-authentication`
- Directorio: `~/projects/feat_myapp_user-authentication`
- Navegación automática al worktree
- Agente IA abierto automáticamente (si está configurado)

**Patrón de nomenclatura:**
```
Directorio: {tipo}_{proyecto}_{feature-name}
Rama: {tipo}/{feature-name}
```

**Ejemplos:**
| Proyecto | Tipo | Feature | Rama | Directorio |
|---------|------|---------|--------|-----------|
| myapp | feat | user-auth | `feat/user-auth` | `feat_myapp_user-auth/` |
| myapp | fix | login-bug | `fix/login-bug` | `fix_myapp_login-bug/` |
| myapp | release | v1.2.0 | `release/v1.2.0` | `release_myapp_v1.2.0/` |
| myapp | refactor | database | `refactor/database` | `refactor_myapp_database/` |
| myapp | chore | cleanup | `chore/cleanup` | `chore_myapp_cleanup/` |

### Eliminar Worktree

1. Lista todos los worktrees existentes (excepto main)
2. Elija el número del worktree a eliminar
3. Confirme la eliminación

**Seguridad:**
- Solicita confirmación antes de eliminar
- Elimina con `--force` para garantizar limpieza completa

### Listar Worktrees

Muestra todos los worktrees activos con:
- Ruta completa
- Rama asociada
- Commit actual

## 🗑️ Desinstalación

### Desinstalación Automática

```bash
cd ~/workspace/projects/quaredx/scripts/worktree_automation
./uninstall.sh
```

### Lo que Hace el Desinstalador

1. ✅ Elimina enlace simbólico `~/bin/wt`
2. ✅ Elimina configuraciones de `.zshrc`
3. ✅ Elimina configuraciones de `.bashrc` o `.bash_profile`
4. ✅ Crea respaldos antes de modificar archivos de configuración
5. ✅ Opcionalmente elimina `~/bin/` si está vacío

**IMPORTANTE:** El código fuente en `scripts/worktree_automation/` **NO** se elimina.

### Desinstalación Manual

```bash
# Eliminar enlace simbólico
rm ~/bin/wt

# Eliminar configuraciones manualmente de .zshrc o .bashrc
# (Busque "# Git Worktree Manager" y elimine las 3 líneas)

# Recargar shell
source ~/.zshrc
```

## ⚙️ Configuración del Directorio de Trabajo

### Primera Configuración

En la primera ejecución del comando `wt`, se le pedirá configurar el directorio base donde se encuentran sus proyectos Git:

```bash
$ wt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ⚙️  Configurar Directorio de Trabajo
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Ingrese la ruta del directorio donde se encuentran sus proyectos Git:
(Use Tab para autocompletar rutas)

Directorio: ~/projects

✅ Configuración guardada en ~/.wt_config
✅ ¡Directorio configurado con éxito!

ℹ️  Proyectos Git encontrados: 3
```

### Reconfigurar Directorio

Para cambiar el directorio de trabajo en cualquier momento:

1. Ejecute `wt` (sin argumentos)
2. Elija opción `4) Configurar directorio de trabajo`
3. Ingrese la nueva ruta (use Tab para autocompletar)
4. Confirme el cambio

### Archivo de Configuración

La configuración se guarda en `~/.wt_config`:

```bash
# Ver configuración actual
cat ~/.wt_config

# Resetear configuración (se solicitará nuevo directorio en la próxima ejecución)
rm ~/.wt_config
```

## 🤖 Configuración del Agente IA

### Agentes Soportados

El script soporta apertura automática de diversos agentes IA después de crear un worktree:

- **Claude Code** (`claude`)
- **Cursor** (`cursor`)
- **Gemini** (`gemini`)
- **GitHub Copilot** (`code`)
- **Windsurf** (`windsurf`)
- **Ninguno** (no abrir agente automáticamente)
- **Otro** (personalizado - proporcione el comando)

### Primera Configuración

En la primera ejecución (después de configurar el directorio de trabajo), se le pedirá configurar el agente IA:

```bash
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🤖 Configurar Agente IA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Seleccione el agente IA que utiliza:

  1) Claude Code
  2) Cursor
  3) Gemini
  4) GitHub Copilot (codex)
  5) Windsurf
  6) Ninguno (no abrir agente automáticamente)
  7) Otro (personalizado)

Elija (1-7): 1

¿Cómo desea usar el agente?

  1) Siempre usar claude (configuración fija)
  2) Preguntar qué agente usar en cada worktree creado

Elija (1-2): 1

✅ ¡Agente configurado con éxito!

ℹ️  Modo: Siempre usar claude
```

### Modos de Uso

#### Modo Fijo (Predeterminado)

El agente configurado se abrirá automáticamente siempre que cree un worktree.

**Ventaja:** Más rápido, no necesita elegir cada vez.

#### Modo Dinámico (Preguntar cada vez)

Al crear un worktree, se le preguntará qué agente abrir.

**Ventaja:** Flexibilidad para alternar entre agentes según la necesidad.

### Reconfigurar Agente

Para cambiar el agente o modo en cualquier momento:

1. Ejecute `wt` (sin argumentos)
2. Elija opción `5) Configurar agente IA`
3. Seleccione el nuevo agente
4. Elija el modo (fijo o preguntar)

### Ejemplo de Uso

**Modo Fijo:**
```bash
$ wt myapp crear
# ... creación del worktree ...
ℹ️  Iniciando claude...
# Claude se abre automáticamente ✅
```

**Modo Dinámico:**
```bash
$ wt myapp crear
# ... creación del worktree ...

¿Qué agente desea abrir?

  1) Claude Code
  2) Cursor
  3) Gemini
  4) GitHub Copilot (code)
  5) Windsurf
  6) Ninguno
  7) Otro

Elija (1-7): 2

ℹ️  Iniciando cursor...
# Cursor se abre ✅
```

### Archivo de Configuración

La configuración del agente se guarda en `~/.wt_config`:

```bash
BASE_DIR="/Users/{user}/projects"
AGENT="claude:claude"
ASK_AGENT_EVERY_TIME="false"
LANGUAGE="es"
```

**Formato:** `AGENT="nombre:comando"`

## 🌐 Configuración de Idioma

El script soporta tres idiomas:
- **English** (inglés)
- **Português (Brasil)** (portugués)
- **Español** (predeterminado)

### Cambiar Idioma

1. Ejecute `wt` (sin argumentos)
2. Elija opción `6) Cambiar idioma`
3. Seleccione su idioma preferido
4. La interfaz se actualizará inmediatamente

La preferencia de idioma se guarda en `~/.wt_config` y persiste entre sesiones.

## 🔧 Resolución de Problemas

### Comando `wt` no encontrado

**Causa:** PATH no actualizado o shell no recargado

**Solución:**
```bash
# Recargar shell
source ~/.zshrc  # o source ~/.bashrc

# O abrir nuevo terminal
```

### Proyecto no encontrado

**Causa:** Directorio de trabajo no configurado o proyecto no existe

**Solución:**
1. Configurar/reconfigurar el directorio de trabajo: `wt` → opción 4
2. Verificar si el proyecto contiene `.git/`
3. Ejecutar `wt` sin argumentos para ver proyectos disponibles

### Rama main no encontrada

**Causa:** Repositorio usa `master` u otra rama predeterminada

**Solución:**
Edite el script `wt.sh` línea ~80:
```bash
# De:
if [ "$CURRENT_BRANCH" != "main" ]; then

# Para:
if [ "$CURRENT_BRANCH" != "master" ]; then
```

### Agente IA no se abre automáticamente

**Causa:** Agente no instalado o no está en el PATH

**Solución:**
- El script funciona normalmente, solo no abre el agente
- Navegue manualmente y abra: `cd ../feature-name && claude`
- O reconfigure el agente: `wt` → opción 5

### Worktree ya existe

**Causa:** Intentando crear worktree con nombre/rama que ya existe

**Solución:**
1. Liste worktrees existentes: `wt myapp listar`
2. Elimine el worktree antiguo: `wt myapp remover`
3. O elija otro nombre

### Permiso denegado al ejecutar scripts

**Causa:** Scripts sin permiso de ejecución

**Solución:**
```bash
chmod +x ~/workspace/projects/quaredx/scripts/worktree_automation/*.sh
```

### Enlace simbólico roto

**Causa:** Archivo `wt.sh` fue movido o eliminado

**Solución:**
```bash
# Reinstalar
cd ~/workspace/projects/quaredx/scripts/worktree_automation
./install.sh
```

## 🔄 Replicar en Otras Computadoras

### Requisitos en Nueva Computadora

1. **Estructura de directorios:**
   ```bash
   mkdir -p ~/workspace/projects/quaredx/scripts
   ```

2. **Git instalado:**
   ```bash
   git --version
   ```

3. **Configuración del shell (zsh o bash):**
   ```bash
   echo $SHELL
   ```

### Pasos para Replicación

#### Opción 1: Vía Git (Recomendado)

```bash
# 1. Clone o sincronice el repositorio
cd ~/workspace/projects/quaredx
git clone <repo-url> scripts
# o
git pull  # si ya está clonado

# 2. Navegue a la carpeta del script
cd scripts/worktree_automation

# 3. Ejecute el instalador
chmod +x install.sh
./install.sh

# 4. Recargue el shell
source ~/.zshrc  # o source ~/.bashrc

# 5. Pruebe
wt
```

#### Opción 2: Copia Manual

```bash
# 1. Crear estructura
mkdir -p ~/workspace/projects/quaredx/scripts/worktree_automation

# 2. Copiar archivos
# (Use scp, rsync, cloud sync, etc.)
scp user@old-machine:~/workspace/projects/quaredx/scripts/worktree_automation/* \
    ~/workspace/projects/quaredx/scripts/worktree_automation/

# 3. Ejecutar instalador
cd ~/workspace/projects/quaredx/scripts/worktree_automation
chmod +x *.sh
./install.sh

# 4. Recargar shell
source ~/.zshrc

# 5. Pruebe
wt
```

### Lista de Verificación de Replicación

- [ ] Estructura de directorios creada: `~/workspace/projects/quaredx/`
- [ ] Scripts copiados a: `~/workspace/projects/quaredx/scripts/worktree_automation/`
- [ ] Instalador ejecutado: `./install.sh`
- [ ] Shell recargado: `source ~/.zshrc`
- [ ] Comando probado: `wt`
- [ ] Proyectos Git clonados en estructura correcta

### Sincronización Continua

Para mantener el script actualizado en múltiples computadoras:

1. **Versione el script con Git:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts
   git init
   git add worktree_automation/
   git commit -m "Add worktree automation"
   git remote add origin <repo-url>
   git push -u origin main
   ```

2. **En otras computadoras:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts
   git pull
   ```

3. **Reinstale si hay cambios:**
   ```bash
   cd worktree_automation
   ./install.sh
   ```

## 📝 Estructura de Archivos

```
worktree_automation/
├── README.md              # Documentación completa en Inglés
├── README.pt-BR.md        # Documentación completa en Portugués
├── README.es.md           # Este archivo - Documentación en Español
├── wt.sh                  # Script principal - Código fuente
├── install.sh             # Instalador automático
└── uninstall.sh          # Desinstalador automático
```

### Descripción de Archivos

- **`wt.sh`**: Código fuente principal del Worktree Manager
- **`install.sh`**: Script de instalación automática (crea enlaces, configura PATH, etc.)
- **`uninstall.sh`**: Script de desinstalación limpia (elimina enlaces y configuraciones)
- **`README.md`**: Documentación completa en Inglés
- **`README.pt-BR.md`**: Documentación completa en Portugués
- **`README.es.md`**: Documentación completa en Español (este archivo)

## 🎨 Interfaz

El script tiene una interfaz colorida para facilitar la visualización:

- 🔴 **Rojo**: Errores
- 🟢 **Verde**: Éxito
- 🟡 **Amarillo**: Advertencias
- 🔵 **Azul**: Títulos y menús
- 🔵 **Cyan**: Información

## 📄 Licencia

Este script fue desarrollado para uso interno del proyecto Quaredx.

## 👤 Autor

**Quaredx**

---

**Versión:** 2.0.0
**Última actualización:** 2025-10-04

> **Language / Idioma / Idioma:** [🇺🇸 English](README.md) | [🇧🇷 Português](README.pt-BR.md) | [🇪🇸 Español](README.es.md)
