# 🌳 Git Worktree Manager

> **Language / Idioma / Idioma:** [🇺🇸 English](README.md) | [🇧🇷 Português](README.pt-BR.md) | [🇪🇸 Español](README.es.md)

Interactive script to manage Git worktrees easily and automatically.

## 📋 Table of Contents

- [About](#about)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Uninstallation](#uninstallation)
- [Troubleshooting](#troubleshooting)
- [Replicate on Other Computers](#replicate-on-other-computers)

## 🎯 About

**Git Worktree Manager** (`wt`) is a tool that automates the creation and management of Git worktrees, allowing you to work on multiple branches simultaneously without needing to stash or constantly switch branches.

### Features

✅ **Interactive Creation**: Creates worktrees with guided interface
✅ **Safe Removal**: Removes worktrees with confirmation
✅ **Listing**: View all active worktrees
✅ **Automatic Validation**: Ensures you're on the `main` branch before operating
✅ **Smart Naming**: Automatically sanitizes names
✅ **Flexible Configuration**: Configure working directory and AI agent
✅ **Multi-Agent Support**: Claude, Cursor, Gemini, Copilot, Windsurf and more
✅ **Multi-language**: English, Portuguese (BR), and Spanish support
✅ **Colored Interface**: Visual and intuitive output

## 📦 Prerequisites

### Operating System
- **macOS** (tested) - use `wt.sh`
- **Linux** (compatible) - use `wt.sh`
- **Windows** (PowerShell) - use `wt.ps1`

### Required Software

**For macOS/Linux:**
- Git 2.5+
- Bash 4.0+
- zsh or bash (shell)

**For Windows:**
- Git 2.5+ ([Git for Windows](https://git-scm.com/download/win))
- PowerShell 5.1+ (included in Windows 10/11)
- PowerShell 7+ (recommended, download from [GitHub](https://github.com/PowerShell/PowerShell))

### Initial Setup

On first execution, the script will ask you to configure the **working directory** where your Git projects are located.

**Recommended structure:**

```
~/projects/                         # Your projects directory
├── project1/                       # Git repository (main branch)
│   └── .git/
├── project2/                       # Git repository (main branch)
│   └── .git/
└── project3/                       # Git repository (main branch)
    └── .git/
```

**IMPORTANT:**
- The directory can be any folder containing your Git projects
- Each project must have a valid Git repository
- Worktrees will be created at the same level as projects
- Configuration is saved in `~/.wt_config` and can be changed at any time

**Example after creating worktrees:**
```
~/projects/
├── myapp/                          # Main project (main)
├── feat_myapp_user-auth/           # Worktree: feat/user-auth
├── fix_myapp_login/                # Worktree: fix/login
├── release_myapp_v1.2.0/           # Worktree: release/v1.2.0
└── refactor_myapp_database/        # Worktree: refactor/database
```

## 🚀 Installation

> **Note:** Choose the appropriate installation method for your operating system:
> - **macOS/Linux**: Follow instructions for `wt.sh` (Bash)
> - **Windows**: Follow instructions for `wt.ps1` (PowerShell)

### For macOS/Linux (Bash Script)

#### Automatic Installation (Recommended)

1. **Clone or navigate to the script directory:**
   ```bash
   cd /path/to/worktree_automation
   ```

2. **Run the installer:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **Activate the script (choose one option):**

   **Option A - Reload shell:**
   ```bash
   source ~/.zshrc    # For zsh
   # or
   source ~/.bashrc   # For bash
   ```

   **Option B - Open new terminal:**
   ```bash
   # Simply open a new terminal window/tab
   ```

4. **Configure the working directory:**

   On first execution of the `wt` command, you'll be asked to configure the directory where your Git projects are located.

   ```bash
   wt
   # Enter the full path (use Tab for autocomplete)
   # Example: ~/projects  or  ~/workspace/repos
   ```

#### What the Installer Does

The `install.sh` script automatically:

1. ✅ Creates `~/bin/` directory (if it doesn't exist)
2. ✅ Creates symbolic link: `~/bin/wt` → `wt.sh`
3. ✅ Adds `~/bin` to PATH
4. ✅ Creates `wt` alias in shell config
5. ✅ Configures `.zshrc`, `.bashrc` or `.bash_profile`
6. ✅ Validates the installation
7. ✅ Lists available Git projects

#### Manual Installation

If you prefer to install manually:

1. **Create ~/bin directory:**
   ```bash
   mkdir -p ~/bin
   ```

2. **Create symbolic link:**
   ```bash
   ln -s /path/to/worktree_automation/wt.sh ~/bin/wt
   chmod +x /path/to/worktree_automation/wt.sh
   ```

3. **Add to shell config (.zshrc or .bashrc):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   echo 'alias wt="$HOME/bin/wt"' >> ~/.zshrc
   ```

4. **Reload shell:**
   ```bash
   source ~/.zshrc
   ```

5. **Configure working directory:**
   ```bash
   wt
   # On first run, configure your projects directory
   ```

### For Windows (PowerShell Script)

#### Automatic Installation (Recommended)

1. **Clone or navigate to the script directory:**
   ```powershell
   cd C:\path\to\worktree_automation
   ```

2. **Run the installer in PowerShell:**
   ```powershell
   .\install.ps1
   ```

   > **Note:** If you get an execution policy error, run PowerShell as Administrator and execute:
   > ```powershell
   > Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   > ```

3. **Reload PowerShell Profile:**

   **Option A - Reload in current session:**
   ```powershell
   . $PROFILE
   ```

   **Option B - Open new PowerShell window**

4. **Configure the working directory:**

   On first execution of the `wt` command, you'll be asked to configure the directory where your Git projects are located.

   ```powershell
   wt
   # Enter the full path
   # Example: C:\Users\YourName\projects  or  D:\workspace\repos
   ```

#### What the Installer Does

The `install.ps1` script automatically:

1. ✅ Adds `wt` function to your PowerShell Profile
2. ✅ Validates Git installation
3. ✅ Creates PowerShell profile if it doesn't exist
4. ✅ Provides option to reload profile immediately

#### Manual Installation

If you prefer to install manually:

1. **Open your PowerShell Profile:**
   ```powershell
   notepad $PROFILE
   ```

   If the file doesn't exist, create it:
   ```powershell
   New-Item -Path $PROFILE -Type File -Force
   ```

2. **Add the following function to your profile:**
   ```powershell
   # Git Worktree Manager
   function wt {
       & "C:\path\to\worktree_automation\wt.ps1" $args
   }
   ```

   Replace `C:\path\to\worktree_automation\wt.ps1` with the actual path to the script.

3. **Reload PowerShell Profile:**
   ```powershell
   . $PROFILE
   ```

4. **Configure working directory:**
   ```powershell
   wt
   # On first run, configure your projects directory
   ```

## 💻 Usage

### Syntax

```bash
wt [project] [operation]
```

### Usage Modes

#### 1️⃣ Fully Interactive Mode (Recommended)

```bash
wt
```

The script will:
1. List all available Git projects (numeric menu)
2. Ask you to choose the project number
3. Validate the selected project
4. Show options menu (create/remove/list)

**Example:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Available projects:

  1) project-a
  2) myapp
  3) website

Choose the project number (or 'q' to quit): 2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ️  Project: myapp
ℹ️  Directory: ~/projects/myapp

✅ On branch main ✓

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1) Create new worktree
  2) Remove existing worktree
  3) List worktrees
  4) Configure working directory
  5) Configure AI agent
  6) Change language
  7) Exit

📂 Current directory: ~/projects
🤖 Agent: claude (fixed)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Choose an option: _
```

#### 2️⃣ Interactive Mode with Project

```bash
wt myapp
```

Specifies the project and shows the operations menu.

#### 3️⃣ Direct Mode

```bash
# Create worktree
wt myapp create

# Remove worktree
wt myapp remove

# List worktrees
wt myapp list
```

### Create Worktree

1. **Choose the type:**
   - `1` for `feat` (feature)
   - `2` for `fix` (bugfix)
   - `3` for `release`
   - `4` for `refactor`
   - `5` for `Other (custom)` - allows typing any prefix

2. **Enter the name:**
   - Example: `user authentication`
   - Will be converted to: `user-authentication`

3. **Confirm creation**

**Result (example with "myapp" project and "feat" type):**
- Branch created: `feat/user-authentication`
- Directory: `~/projects/feat_myapp_user-authentication`
- Automatic navigation to worktree
- AI agent opened automatically (if configured)

**Naming pattern:**
```
Directory: {type}_{project}_{feature-name}
Branch: {type}/{feature-name}
```

**Examples:**
| Project | Type | Feature | Branch | Directory |
|---------|------|---------|--------|-----------|
| myapp | feat | user-auth | `feat/user-auth` | `feat_myapp_user-auth/` |
| myapp | fix | login-bug | `fix/login-bug` | `fix_myapp_login-bug/` |
| myapp | release | v1.2.0 | `release/v1.2.0` | `release_myapp_v1.2.0/` |
| myapp | refactor | database | `refactor/database` | `refactor_myapp_database/` |
| myapp | chore | cleanup | `chore/cleanup` | `chore_myapp_cleanup/` |

### Remove Worktree

1. Lists all existing worktrees (except main)
2. Choose the worktree number to remove
3. Confirm removal

**Safety:**
- Asks for confirmation before removing
- Removes with `--force` to ensure complete cleanup

### List Worktrees

Displays all active worktrees with:
- Full path
- Associated branch
- Current commit

## 🗑️ Uninstallation

### Automatic Uninstallation

```bash
cd ~/workspace/projects/quaredx/scripts/worktree_automation
./uninstall.sh
```

### What the Uninstaller Does

1. ✅ Removes symbolic link `~/bin/wt`
2. ✅ Removes configurations from `.zshrc`
3. ✅ Removes configurations from `.bashrc` or `.bash_profile`
4. ✅ Creates backups before modifying configuration files
5. ✅ Optionally removes `~/bin/` if empty

**IMPORTANT:** Source code in `scripts/worktree_automation/` is **NOT** removed.

### Manual Uninstallation

```bash
# Remove symbolic link
rm ~/bin/wt

# Manually remove configurations from .zshrc or .bashrc
# (Look for "# Git Worktree Manager" and remove the 3 lines)

# Reload shell
source ~/.zshrc
```

## ⚙️ Working Directory Configuration

### First Configuration

On first execution of the `wt` command, you'll be asked to configure the base directory where your Git projects are located:

```bash
$ wt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ⚙️  Configure Working Directory
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Enter the path to the directory where your Git projects are located:
(Use Tab for path autocomplete)

Directory: ~/projects

✅ Configuration saved in ~/.wt_config
✅ Directory configured successfully!

ℹ️  Git projects found: 3
```

### Reconfigure Directory

To change the working directory at any time:

1. Run `wt` (without arguments)
2. Choose option `4) Configure working directory`
3. Enter the new path (use Tab for autocomplete)
4. Confirm the change

### Configuration File

Configuration is saved in `~/.wt_config`:

```bash
# View current configuration
cat ~/.wt_config

# Reset configuration (will ask for new directory on next run)
rm ~/.wt_config
```

## 🤖 AI Agent Configuration

### Supported Agents

The script supports automatic opening of various AI agents after creating a worktree:

- **Claude Code** (`claude`)
- **Cursor** (`cursor`)
- **Gemini** (`gemini`)
- **GitHub Copilot** (`code`)
- **Windsurf** (`windsurf`)
- **None** (don't open agent automatically)
- **Other** (custom - provide the command)

### First Configuration

On first execution (after configuring the working directory), you'll be asked to configure the AI agent:

```bash
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🤖 Configure AI Agent
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Select the AI agent you use:

  1) Claude Code
  2) Cursor
  3) Gemini
  4) GitHub Copilot (codex)
  5) Windsurf
  6) None (don't open agent automatically)
  7) Other (custom)

Choose (1-7): 1

How do you want to use the agent?

  1) Always use claude (fixed configuration)
  2) Ask which agent to use for each worktree created

Choose (1-2): 1

✅ Agent configured successfully!

ℹ️  Mode: Always use claude
```

### Usage Modes

#### Fixed Mode (Default)

The configured agent will be opened automatically whenever you create a worktree.

**Advantage:** Faster, no need to choose every time.

#### Dynamic Mode (Ask each time)

When creating a worktree, you'll be asked which agent to open.

**Advantage:** Flexibility to switch between agents as needed.

### Reconfigure Agent

To change the agent or mode at any time:

1. Run `wt` (without arguments)
2. Choose option `5) Configure AI agent`
3. Select the new agent
4. Choose the mode (fixed or ask)

### Usage Example

**Fixed Mode:**
```bash
$ wt myapp create
# ... worktree creation ...
ℹ️  Starting claude...
# Claude opens automatically ✅
```

**Dynamic Mode:**
```bash
$ wt myapp create
# ... worktree creation ...

Which agent do you want to open?

  1) Claude Code
  2) Cursor
  3) Gemini
  4) GitHub Copilot (code)
  5) Windsurf
  6) None
  7) Other

Choose (1-7): 2

ℹ️  Starting cursor...
# Cursor opens ✅
```

### Configuration File

Agent configuration is saved in `~/.wt_config`:

```bash
BASE_DIR="/Users/{user}/projects"
AGENT="claude:claude"
ASK_AGENT_EVERY_TIME="false"
LANGUAGE="en"
```

**Format:** `AGENT="name:command"`

## 🌐 Language Configuration

The script supports three languages:
- **English** (default)
- **Português (Brasil)**
- **Español**

### Change Language

1. Run `wt` (without arguments)
2. Choose option `6) Change language`
3. Select your preferred language
4. The interface will be updated immediately

Language preference is saved in `~/.wt_config` and persists across sessions.

## 🔧 Troubleshooting

### Command `wt` not found

**Cause:** PATH not updated or shell not reloaded

**Solution:**
```bash
# Reload shell
source ~/.zshrc  # or source ~/.bashrc

# Or open new terminal
```

### Project not found

**Cause:** Working directory not configured or project doesn't exist

**Solution:**
1. Configure/reconfigure working directory: `wt` → option 4
2. Check if project contains `.git/`
3. Run `wt` without arguments to see available projects

### Branch main not found

**Cause:** Repository uses `master` or another default branch

**Solution:**
Edit the `wt.sh` script around line ~80:
```bash
# From:
if [ "$CURRENT_BRANCH" != "main" ]; then

# To:
if [ "$CURRENT_BRANCH" != "master" ]; then
```

### AI agent doesn't open automatically

**Cause:** Agent not installed or not in PATH

**Solution:**
- Script works normally, just doesn't open the agent
- Navigate manually and open: `cd ../feature-name && claude`
- Or reconfigure agent: `wt` → option 5

### Worktree already exists

**Cause:** Trying to create worktree with existing name/branch

**Solution:**
1. List existing worktrees: `wt myapp list`
2. Remove old worktree: `wt myapp remove`
3. Or choose another name

### Permission denied when running scripts

**Cause:** Scripts without execution permission

**Solution:**
```bash
chmod +x ~/workspace/projects/quaredx/scripts/worktree_automation/*.sh
```

### Broken symbolic link

**Cause:** `wt.sh` file was moved or removed

**Solution:**
```bash
# Reinstall
cd ~/workspace/projects/quaredx/scripts/worktree_automation
./install.sh
```

## 🔄 Replicate on Other Computers

### Requirements on New Computer

1. **Directory structure:**
   ```bash
   mkdir -p ~/workspace/projects/quaredx/scripts
   ```

2. **Git installed:**
   ```bash
   git --version
   ```

3. **Shell config (zsh or bash):**
   ```bash
   echo $SHELL
   ```

### Step-by-Step Replication

#### Option 1: Via Git (Recommended)

```bash
# 1. Clone or sync the repository
cd ~/workspace/projects/quaredx
git clone <repo-url> scripts
# or
git pull  # if already cloned

# 2. Navigate to script folder
cd scripts/worktree_automation

# 3. Run the installer
chmod +x install.sh
./install.sh

# 4. Reload shell
source ~/.zshrc  # or source ~/.bashrc

# 5. Test
wt
```

#### Option 2: Manual Copy

```bash
# 1. Create structure
mkdir -p ~/workspace/projects/quaredx/scripts/worktree_automation

# 2. Copy files
# (Use scp, rsync, cloud sync, etc.)
scp user@old-machine:~/workspace/projects/quaredx/scripts/worktree_automation/* \
    ~/workspace/projects/quaredx/scripts/worktree_automation/

# 3. Run installer
cd ~/workspace/projects/quaredx/scripts/worktree_automation
chmod +x *.sh
./install.sh

# 4. Reload shell
source ~/.zshrc

# 5. Test
wt
```

### Replication Checklist

- [ ] Directory structure created: `~/workspace/projects/quaredx/`
- [ ] Scripts copied to: `~/workspace/projects/quaredx/scripts/worktree_automation/`
- [ ] Installer executed: `./install.sh`
- [ ] Shell reloaded: `source ~/.zshrc`
- [ ] Command tested: `wt`
- [ ] Git projects cloned in correct structure

### Continuous Synchronization

To keep the script updated on multiple computers:

1. **Version the script with Git:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts
   git init
   git add worktree_automation/
   git commit -m "Add worktree automation"
   git remote add origin <repo-url>
   git push -u origin main
   ```

2. **On other computers:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts
   git pull
   ```

3. **Reinstall if there are changes:**
   ```bash
   cd worktree_automation
   ./install.sh
   ```

## 📝 File Structure

```
worktree_automation/
├── README.md              # This file - Complete documentation (English)
├── README.pt-BR.md        # Documentation in Portuguese
├── README.es.md           # Documentation in Spanish
├── wt.sh                  # Main script - Source code
├── install.sh             # Automatic installer
└── uninstall.sh          # Automatic uninstaller
```

### File Descriptions

- **`wt.sh`**: Main source code of Worktree Manager
- **`install.sh`**: Automatic installation script (creates links, configures PATH, etc.)
- **`uninstall.sh`**: Clean uninstallation script (removes links and configurations)
- **`README.md`**: Complete documentation in English (this file)
- **`README.pt-BR.md`**: Complete documentation in Portuguese
- **`README.es.md`**: Complete documentation in Spanish

## 🎨 Interface

The script has a colored interface for easier visualization:

- 🔴 **Red**: Errors
- 🟢 **Green**: Success
- 🟡 **Yellow**: Warnings
- 🔵 **Blue**: Titles and menus
- 🔵 **Cyan**: Information

## 📄 License

This script was developed for internal use of the Quaredx project.

## 👤 Author

**Quaredx**

---

**Version:** 2.0.0
**Last update:** 2025-10-04

> **Language / Idioma / Idioma:** [🇺🇸 English](README.md) | [🇧🇷 Português](README.pt-BR.md) | [🇪🇸 Español](README.es.md)
