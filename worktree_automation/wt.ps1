# Worktree Manager - Git Worktree Automation (PowerShell)
# Author: Quaredx
# Description: Gerencia worktrees do Git de forma interativa (Windows)

# Arquivo de configuração
$script:CONFIG_FILE = Join-Path $env:USERPROFILE ".wt_config"

# Idioma padrão
$script:LANGUAGE = "en"

# Função para carregar textos do idioma
function Load-Language {
    switch ($script:LANGUAGE) {
        { $_ -in "pt", "pt-BR", "pt_BR" } {
            # Português
            $script:TXT_TITLE = "🌳 Git Worktree Manager"
            $script:TXT_MENU_CREATE = "Criar novo worktree"
            $script:TXT_MENU_REMOVE = "Remover worktree existente"
            $script:TXT_MENU_LIST = "Listar worktrees"
            $script:TXT_MENU_CONFIG_DIR = "Configurar diretório de trabalho"
            $script:TXT_MENU_CONFIG_AGENT = "Configurar agente IA"
            $script:TXT_MENU_CHANGE_LANG = "Alterar idioma"
            $script:TXT_MENU_EXIT = "Sair"
            $script:TXT_CURRENT_DIR = "📂 Diretório atual"
            $script:TXT_CURRENT_AGENT = "🤖 Agente"
            $script:TXT_CHOOSE_OPTION = "Escolha uma opção"
            $script:TXT_INVALID_OPTION = "Opção inválida"
            $script:TXT_EXITING = "Saindo..."
            $script:TXT_CONFIG_SAVED = "Configuração salva em"
            $script:TXT_LANGUAGE_NAME = "Português (Brasil)"
            $script:TXT_CONFIG_DIR_TITLE = "⚙️  Configurar Diretório de Trabalho"
            $script:TXT_CONFIG_DIR_ENTER = "Digite o caminho do diretório onde seus projetos Git estão localizados:"
            $script:TXT_CONFIG_DIR_PROMPT = "Diretório"
            $script:TXT_CONFIG_DIR_EMPTY = "Diretório não pode ser vazio"
            $script:TXT_CONFIG_DIR_NOT_EXIST = "Diretório '{0}' não existe"
            $script:TXT_CONFIG_DIR_SUCCESS = "Diretório configurado com sucesso!"
            $script:TXT_CONFIG_DIR_PROJECTS_FOUND = "Projetos Git encontrados: {0}"
            $script:TXT_PRESS_ENTER = "Pressione Enter para continuar..."
            $script:TXT_CONFIG_AGENT_TITLE = "🤖 Configurar Agente IA"
            $script:TXT_CONFIG_AGENT_SELECT = "Selecione o agente IA que você utiliza:"
            $script:TXT_CONFIG_AGENT_NONE = "Nenhum (não abrir agente automaticamente)"
            $script:TXT_CONFIG_AGENT_OTHER = "Outro (customizado)"
            $script:TXT_CONFIG_AGENT_CHOOSE = "Escolha (1-7):"
            $script:TXT_CONFIG_AGENT_NAME = "Nome do agente:"
            $script:TXT_CONFIG_AGENT_CMD = "Comando para abrir:"
            $script:TXT_CONFIG_AGENT_MODE = "Como deseja usar o agente?"
            $script:TXT_CONFIG_AGENT_MODE_1 = "Sempre usar {0} (configuração fixa)"
            $script:TXT_CONFIG_AGENT_MODE_2 = "Perguntar qual agente usar a cada worktree criado"
            $script:TXT_CONFIG_AGENT_MODE_CHOOSE = "Escolha (1-2):"
            $script:TXT_CONFIG_AGENT_SUCCESS = "Agente configurado com sucesso!"
            $script:TXT_CONFIG_LANG_TITLE = "🌐 Configurar Idioma"
            $script:TXT_CONFIG_LANG_SELECT = "Selecione o idioma / Select language / Seleccionar idioma:"
            $script:TXT_CONFIG_LANG_SUCCESS = "Idioma alterado para: {0}"
            $script:TXT_PROJECT_AVAILABLE = "📁 Projetos disponíveis:"
            $script:TXT_PROJECT_CHOOSE = "Escolha o número do projeto (ou 'q' para sair):"
            $script:TXT_PROJECT_EMPTY = "Escolha não pode ser vazia"
            $script:TXT_PROJECT_INVALID_NUM = "Digite um número válido"
            $script:TXT_PROJECT_INVALID_RANGE = "Opção inválida. Escolha entre 1 e {0}"
            $script:TXT_PROJECT_NAME = "Projeto: {0}"
            $script:TXT_PROJECT_DIR = "Diretório: {0}"
            $script:TXT_PROJECT_NOT_GIT = "Não é um repositório Git válido"
            $script:TXT_BRANCH_ON = "Na branch {0} ✓"
            $script:TXT_BRANCH_NOT_MAIN = "Você está na branch '{0}' (não é main/master)"
            $script:TXT_BRANCH_CHANGE = "Deseja trocar para branch principal? (s/n):"
            $script:TXT_BRANCH_CONTINUING = "Continuando na branch: {0}"
            $script:TXT_WORKTREE_LIST = "📋 Worktrees existentes:"
            $script:TXT_WORKTREE_CREATE_TITLE = "✨ Criar Novo Worktree"
            $script:TXT_WORKTREE_TYPE = "Tipo de branch:"
            $script:TXT_WORKTREE_TYPE_CHOOSE = "Escolha (1-5):"
            $script:TXT_WORKTREE_NAME_PROMPT = "Nome do {0}:"
            $script:TXT_WORKTREE_NAME_EMPTY = "Nome não pode ser vazio"
            $script:TXT_WORKTREE_BRANCH = "Branch: {0}"
            $script:TXT_WORKTREE_DIR_INFO = "Diretório: {0}"
            $script:TXT_WORKTREE_CONFIRM = "Confirmar criação? (s/n):"
            $script:TXT_WORKTREE_CANCELLED = "Operação cancelada"
            $script:TXT_WORKTREE_CREATING = "Criando worktree..."
            $script:TXT_WORKTREE_SUCCESS = "Worktree criado com sucesso!"
            $script:TXT_WORKTREE_CURRENT_DIR = "Diretório atual: {0}"
            $script:TXT_WORKTREE_AGENT_ASK = "Qual agente deseja abrir?"
            $script:TXT_WORKTREE_AGENT_NONE = "Nenhum agente será aberto automaticamente"
            $script:TXT_WORKTREE_FAILED = "Falha ao criar worktree. Verifique se a branch já existe."
            $script:TXT_AGENT_ASK_EVERY = "Perguntar a cada worktree"
            $script:TXT_AGENT_FIXED = "{0} (fixo)"
        }
        { $_ -in "es", "es-ES", "es_ES" } {
            # Español
            $script:TXT_TITLE = "🌳 Git Worktree Manager"
            $script:TXT_MENU_CREATE = "Crear nuevo worktree"
            $script:TXT_MENU_REMOVE = "Eliminar worktree existente"
            $script:TXT_MENU_LIST = "Listar worktrees"
            $script:TXT_MENU_CONFIG_DIR = "Configurar directorio de trabajo"
            $script:TXT_MENU_CONFIG_AGENT = "Configurar agente IA"
            $script:TXT_MENU_CHANGE_LANG = "Cambiar idioma"
            $script:TXT_MENU_EXIT = "Salir"
            $script:TXT_CURRENT_DIR = "📂 Directorio actual"
            $script:TXT_CURRENT_AGENT = "🤖 Agente"
            $script:TXT_CHOOSE_OPTION = "Elige una opción"
            $script:TXT_INVALID_OPTION = "Opción inválida"
            $script:TXT_EXITING = "Saliendo..."
            $script:TXT_CONFIG_SAVED = "Configuración guardada en"
            $script:TXT_LANGUAGE_NAME = "Español"
            $script:TXT_CONFIG_DIR_TITLE = "⚙️  Configurar Directorio de Trabajo"
            $script:TXT_CONFIG_DIR_ENTER = "Ingrese la ruta del directorio donde se encuentran sus proyectos Git:"
            $script:TXT_CONFIG_DIR_PROMPT = "Directorio"
            $script:TXT_CONFIG_DIR_EMPTY = "El directorio no puede estar vacío"
            $script:TXT_CONFIG_DIR_NOT_EXIST = "El directorio '{0}' no existe"
            $script:TXT_CONFIG_DIR_SUCCESS = "¡Directorio configurado con éxito!"
            $script:TXT_CONFIG_DIR_PROJECTS_FOUND = "Proyectos Git encontrados: {0}"
            $script:TXT_PRESS_ENTER = "Presione Enter para continuar..."
            $script:TXT_CONFIG_AGENT_TITLE = "🤖 Configurar Agente IA"
            $script:TXT_CONFIG_AGENT_SELECT = "Seleccione el agente IA que utiliza:"
            $script:TXT_CONFIG_AGENT_NONE = "Ninguno (no abrir agente automáticamente)"
            $script:TXT_CONFIG_AGENT_OTHER = "Otro (personalizado)"
            $script:TXT_CONFIG_AGENT_CHOOSE = "Elija (1-7):"
            $script:TXT_CONFIG_AGENT_NAME = "Nombre del agente:"
            $script:TXT_CONFIG_AGENT_CMD = "Comando para abrir:"
            $script:TXT_CONFIG_AGENT_MODE = "¿Cómo desea usar el agente?"
            $script:TXT_CONFIG_AGENT_MODE_1 = "Siempre usar {0} (configuración fija)"
            $script:TXT_CONFIG_AGENT_MODE_2 = "Preguntar qué agente usar en cada worktree creado"
            $script:TXT_CONFIG_AGENT_MODE_CHOOSE = "Elija (1-2):"
            $script:TXT_CONFIG_AGENT_SUCCESS = "¡Agente configurado con éxito!"
            $script:TXT_CONFIG_LANG_TITLE = "🌐 Configurar Idioma"
            $script:TXT_CONFIG_LANG_SELECT = "Selecione o idioma / Select language / Seleccionar idioma:"
            $script:TXT_CONFIG_LANG_SUCCESS = "Idioma cambiado a: {0}"
            $script:TXT_PROJECT_AVAILABLE = "📁 Proyectos disponibles:"
            $script:TXT_PROJECT_CHOOSE = "Elija el número del proyecto (o 'q' para salir):"
            $script:TXT_PROJECT_EMPTY = "La elección no puede estar vacía"
            $script:TXT_PROJECT_INVALID_NUM = "Ingrese un número válido"
            $script:TXT_PROJECT_INVALID_RANGE = "Opción inválida. Elija entre 1 y {0}"
            $script:TXT_PROJECT_NAME = "Proyecto: {0}"
            $script:TXT_PROJECT_DIR = "Directorio: {0}"
            $script:TXT_PROJECT_NOT_GIT = "No es un repositorio Git válido"
            $script:TXT_BRANCH_ON = "En la rama {0} ✓"
            $script:TXT_BRANCH_NOT_MAIN = "Está en la rama '{0}' (no es main/master)"
            $script:TXT_BRANCH_CHANGE = "¿Desea cambiar a la rama principal? (s/n):"
            $script:TXT_BRANCH_CONTINUING = "Continuando en la rama: {0}"
            $script:TXT_WORKTREE_LIST = "📋 Worktrees existentes:"
            $script:TXT_WORKTREE_CREATE_TITLE = "✨ Crear Nuevo Worktree"
            $script:TXT_WORKTREE_TYPE = "Tipo de rama:"
            $script:TXT_WORKTREE_TYPE_CHOOSE = "Elija (1-5):"
            $script:TXT_WORKTREE_NAME_PROMPT = "Nombre del {0}:"
            $script:TXT_WORKTREE_NAME_EMPTY = "El nombre no puede estar vacío"
            $script:TXT_WORKTREE_BRANCH = "Rama: {0}"
            $script:TXT_WORKTREE_DIR_INFO = "Directorio: {0}"
            $script:TXT_WORKTREE_CONFIRM = "¿Confirmar creación? (s/n):"
            $script:TXT_WORKTREE_CANCELLED = "Operación cancelada"
            $script:TXT_WORKTREE_CREATING = "Creando worktree..."
            $script:TXT_WORKTREE_SUCCESS = "¡Worktree creado con éxito!"
            $script:TXT_WORKTREE_CURRENT_DIR = "Directorio actual: {0}"
            $script:TXT_WORKTREE_AGENT_ASK = "¿Qué agente desea abrir?"
            $script:TXT_WORKTREE_AGENT_NONE = "No se abrirá ningún agente automáticamente"
            $script:TXT_WORKTREE_FAILED = "Error al crear worktree. Verifique si la rama ya existe."
            $script:TXT_AGENT_ASK_EVERY = "Preguntar en cada worktree"
            $script:TXT_AGENT_FIXED = "{0} (fijo)"
        }
        default {
            # English
            $script:LANGUAGE = "en"
            $script:TXT_TITLE = "🌳 Git Worktree Manager"
            $script:TXT_MENU_CREATE = "Create new worktree"
            $script:TXT_MENU_REMOVE = "Remove existing worktree"
            $script:TXT_MENU_LIST = "List worktrees"
            $script:TXT_MENU_CONFIG_DIR = "Configure working directory"
            $script:TXT_MENU_CONFIG_AGENT = "Configure AI agent"
            $script:TXT_MENU_CHANGE_LANG = "Change language"
            $script:TXT_MENU_EXIT = "Exit"
            $script:TXT_CURRENT_DIR = "📂 Current directory"
            $script:TXT_CURRENT_AGENT = "🤖 Agent"
            $script:TXT_CHOOSE_OPTION = "Choose an option"
            $script:TXT_INVALID_OPTION = "Invalid option"
            $script:TXT_EXITING = "Exiting..."
            $script:TXT_CONFIG_SAVED = "Configuration saved in"
            $script:TXT_LANGUAGE_NAME = "English"
            $script:TXT_CONFIG_DIR_TITLE = "⚙️  Configure Working Directory"
            $script:TXT_CONFIG_DIR_ENTER = "Enter the path to the directory where your Git projects are located:"
            $script:TXT_CONFIG_DIR_PROMPT = "Directory"
            $script:TXT_CONFIG_DIR_EMPTY = "Directory cannot be empty"
            $script:TXT_CONFIG_DIR_NOT_EXIST = "Directory '{0}' does not exist"
            $script:TXT_CONFIG_DIR_SUCCESS = "Directory configured successfully!"
            $script:TXT_CONFIG_DIR_PROJECTS_FOUND = "Git projects found: {0}"
            $script:TXT_PRESS_ENTER = "Press Enter to continue..."
            $script:TXT_CONFIG_AGENT_TITLE = "🤖 Configure AI Agent"
            $script:TXT_CONFIG_AGENT_SELECT = "Select the AI agent you use:"
            $script:TXT_CONFIG_AGENT_NONE = "None (don't open agent automatically)"
            $script:TXT_CONFIG_AGENT_OTHER = "Other (custom)"
            $script:TXT_CONFIG_AGENT_CHOOSE = "Choose (1-7):"
            $script:TXT_CONFIG_AGENT_NAME = "Agent name:"
            $script:TXT_CONFIG_AGENT_CMD = "Command to open:"
            $script:TXT_CONFIG_AGENT_MODE = "How do you want to use the agent?"
            $script:TXT_CONFIG_AGENT_MODE_1 = "Always use {0} (fixed configuration)"
            $script:TXT_CONFIG_AGENT_MODE_2 = "Ask which agent to use for each worktree created"
            $script:TXT_CONFIG_AGENT_MODE_CHOOSE = "Choose (1-2):"
            $script:TXT_CONFIG_AGENT_SUCCESS = "Agent configured successfully!"
            $script:TXT_CONFIG_LANG_TITLE = "🌐 Configure Language"
            $script:TXT_CONFIG_LANG_SELECT = "Selecione o idioma / Select language / Seleccionar idioma:"
            $script:TXT_CONFIG_LANG_SUCCESS = "Language changed to: {0}"
            $script:TXT_PROJECT_AVAILABLE = "📁 Available projects:"
            $script:TXT_PROJECT_CHOOSE = "Choose the project number (or 'q' to quit):"
            $script:TXT_PROJECT_EMPTY = "Choice cannot be empty"
            $script:TXT_PROJECT_INVALID_NUM = "Enter a valid number"
            $script:TXT_PROJECT_INVALID_RANGE = "Invalid option. Choose between 1 and {0}"
            $script:TXT_PROJECT_NAME = "Project: {0}"
            $script:TXT_PROJECT_DIR = "Directory: {0}"
            $script:TXT_PROJECT_NOT_GIT = "Not a valid Git repository"
            $script:TXT_BRANCH_ON = "On branch {0} ✓"
            $script:TXT_BRANCH_NOT_MAIN = "You are on branch '{0}' (not main/master)"
            $script:TXT_BRANCH_CHANGE = "Do you want to switch to main branch? (y/n):"
            $script:TXT_BRANCH_CONTINUING = "Continuing on branch: {0}"
            $script:TXT_WORKTREE_LIST = "📋 Existing worktrees:"
            $script:TXT_WORKTREE_CREATE_TITLE = "✨ Create New Worktree"
            $script:TXT_WORKTREE_TYPE = "Branch type:"
            $script:TXT_WORKTREE_TYPE_CHOOSE = "Choose (1-5):"
            $script:TXT_WORKTREE_NAME_PROMPT = "Name of {0}:"
            $script:TXT_WORKTREE_NAME_EMPTY = "Name cannot be empty"
            $script:TXT_WORKTREE_BRANCH = "Branch: {0}"
            $script:TXT_WORKTREE_DIR_INFO = "Directory: {0}"
            $script:TXT_WORKTREE_CONFIRM = "Confirm creation? (y/n):"
            $script:TXT_WORKTREE_CANCELLED = "Operation cancelled"
            $script:TXT_WORKTREE_CREATING = "Creating worktree..."
            $script:TXT_WORKTREE_SUCCESS = "Worktree created successfully!"
            $script:TXT_WORKTREE_CURRENT_DIR = "Current directory: {0}"
            $script:TXT_WORKTREE_AGENT_ASK = "Which agent do you want to open?"
            $script:TXT_WORKTREE_AGENT_NONE = "No agent will be opened automatically"
            $script:TXT_WORKTREE_FAILED = "Failed to create worktree. Check if branch already exists."
            $script:TXT_AGENT_ASK_EVERY = "Ask for each worktree"
            $script:TXT_AGENT_FIXED = "{0} (fixed)"
        }
    }
}

# Função para carregar configuração
function Load-Config {
    if (Test-Path $script:CONFIG_FILE) {
        $config = Get-Content $script:CONFIG_FILE | ConvertFrom-StringData
        $script:BASE_DIR = $config.BASE_DIR
        $script:AGENT = $config.AGENT
        $script:ASK_AGENT_EVERY_TIME = $config.ASK_AGENT_EVERY_TIME
        $script:LANGUAGE = if ($config.LANGUAGE) { $config.LANGUAGE } else { "en" }
        Load-Language
        return $true
    }
    else {
        Load-Language
        return $false
    }
}

# Função para salvar configuração
function Save-Config {
    param(
        [string]$Dir,
        [string]$AgentValue = $script:AGENT,
        [string]$AskEveryTime = $script:ASK_AGENT_EVERY_TIME,
        [string]$Lang = $script:LANGUAGE
    )

    @"
BASE_DIR=$Dir
AGENT=$AgentValue
ASK_AGENT_EVERY_TIME=$AskEveryTime
LANGUAGE=$Lang
"@ | Out-File -FilePath $script:CONFIG_FILE -Encoding UTF8

    Write-Success "$script:TXT_CONFIG_SAVED $script:CONFIG_FILE"
}

# Funções de output colorido
function Write-Error-Exit {
    param([string]$Message)
    Write-Host "❌ Erro: $Message" -ForegroundColor Red
    exit 1
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ️  $Message" -ForegroundColor Cyan
}

function Write-Warning-Msg {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

# Função para configurar diretório base
function Setup-BaseDirectory {
    Clear-Host
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host "    $script:TXT_CONFIG_DIR_TITLE" -ForegroundColor Blue
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host ""

    Write-Host $script:TXT_CONFIG_DIR_ENTER -ForegroundColor Cyan
    Write-Host ""

    $newDir = Read-Host $script:TXT_CONFIG_DIR_PROMPT

    if ([string]::IsNullOrWhiteSpace($newDir)) {
        Write-Warning-Msg $script:TXT_CONFIG_DIR_EMPTY
        Start-Sleep -Seconds 2
        return
    }

    # Expandir variáveis de ambiente
    $newDir = [System.Environment]::ExpandEnvironmentVariables($newDir)

    if (-not (Test-Path $newDir)) {
        Write-Error-Exit ($script:TXT_CONFIG_DIR_NOT_EXIST -f $newDir)
    }

    # Contar projetos Git
    $gitCount = (Get-ChildItem -Path $newDir -Directory | Where-Object { Test-Path (Join-Path $_.FullName ".git") }).Count

    Save-Config -Dir $newDir
    $script:BASE_DIR = $newDir

    Write-Host ""
    Write-Success $script:TXT_CONFIG_DIR_SUCCESS
    Write-Host ""
    Write-Info ($script:TXT_CONFIG_DIR_PROJECTS_FOUND -f $gitCount)
    Write-Host ""
    Read-Host $script:TXT_PRESS_ENTER
}

# Função para configurar agente IA
function Setup-AgentConfig {
    Clear-Host
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host "    $script:TXT_CONFIG_AGENT_TITLE" -ForegroundColor Blue
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host ""

    Write-Host $script:TXT_CONFIG_AGENT_SELECT -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  1) Claude Code"
    Write-Host "  2) Cursor"
    Write-Host "  3) Gemini"
    Write-Host "  4) GitHub Copilot (code)"
    Write-Host "  5) Windsurf"
    Write-Host "  6) $script:TXT_CONFIG_AGENT_NONE"
    Write-Host "  7) $script:TXT_CONFIG_AGENT_OTHER"
    Write-Host ""

    $choice = Read-Host $script:TXT_CONFIG_AGENT_CHOOSE

    switch ($choice) {
        "1" { $selectedAgent = "claude"; $agentCmd = "claude" }
        "2" { $selectedAgent = "cursor"; $agentCmd = "cursor" }
        "3" { $selectedAgent = "gemini"; $agentCmd = "gemini" }
        "4" { $selectedAgent = "copilot"; $agentCmd = "code" }
        "5" { $selectedAgent = "windsurf"; $agentCmd = "windsurf" }
        "6" { $selectedAgent = "none"; $agentCmd = "none" }
        "7" {
            $selectedAgent = Read-Host $script:TXT_CONFIG_AGENT_NAME
            $agentCmd = Read-Host $script:TXT_CONFIG_AGENT_CMD
        }
        default { Write-Error-Exit $script:TXT_INVALID_OPTION }
    }

    Write-Host ""
    Write-Host $script:TXT_CONFIG_AGENT_MODE -ForegroundColor Cyan
    Write-Host ""
    Write-Host ("  1) " + ($script:TXT_CONFIG_AGENT_MODE_1 -f $selectedAgent))
    Write-Host "  2) $script:TXT_CONFIG_AGENT_MODE_2"
    Write-Host ""

    $modeChoice = Read-Host $script:TXT_CONFIG_AGENT_MODE_CHOOSE

    $askEveryTime = if ($modeChoice -eq "2") { "true" } else { "false" }

    Save-Config -Dir $script:BASE_DIR -AgentValue "${selectedAgent}:${agentCmd}" -AskEveryTime $askEveryTime
    $script:AGENT = "${selectedAgent}:${agentCmd}"
    $script:ASK_AGENT_EVERY_TIME = $askEveryTime

    Write-Host ""
    Write-Success $script:TXT_CONFIG_AGENT_SUCCESS
    Write-Host ""
    Read-Host $script:TXT_PRESS_ENTER
}

# Função para configurar idioma
function Setup-LanguageConfig {
    Clear-Host
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host "    $script:TXT_CONFIG_LANG_TITLE" -ForegroundColor Blue
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host ""

    Write-Host $script:TXT_CONFIG_LANG_SELECT -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  1) English"
    Write-Host "  2) Português (Brasil)"
    Write-Host "  3) Español"
    Write-Host ""

    $choice = Read-Host "Choose / Escolha / Elija (1-3)"

    switch ($choice) {
        "1" { $newLang = "en"; $langName = "English" }
        "2" { $newLang = "pt-BR"; $langName = "Português (Brasil)" }
        "3" { $newLang = "es"; $langName = "Español" }
        default {
            Write-Warning-Msg $script:TXT_INVALID_OPTION
            Start-Sleep -Seconds 1
            return
        }
    }

    $script:LANGUAGE = $newLang
    Save-Config -Dir $script:BASE_DIR -AgentValue $script:AGENT -AskEveryTime $script:ASK_AGENT_EVERY_TIME -Lang $newLang
    Load-Language

    Write-Host ""
    Write-Success ($script:TXT_CONFIG_LANG_SUCCESS -f $langName)
    Write-Host ""
    Read-Host $script:TXT_PRESS_ENTER
}

# Função para obter nome do projeto
function Get-ProjectName {
    while ($true) {
        Clear-Host
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
        Write-Host "    $script:TXT_TITLE" -ForegroundColor Blue
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
        Write-Host ""

        $projects = Get-ChildItem -Path $script:BASE_DIR -Directory |
            Where-Object { Test-Path (Join-Path $_.FullName ".git") }

        if ($projects.Count -eq 0) {
            Write-Error-Exit "Nenhum projeto Git encontrado em $script:BASE_DIR"
        }

        Write-Host $script:TXT_PROJECT_AVAILABLE -ForegroundColor Cyan
        Write-Host ""

        $index = 1
        foreach ($proj in $projects) {
            Write-Host "  $index) $($proj.Name)"
            $index++
        }
        Write-Host ""

        $choice = Read-Host $script:TXT_PROJECT_CHOOSE

        if ($choice -in @("q", "sair", "exit")) {
            Write-Info $script:TXT_EXITING
            exit 0
        }

        if ([string]::IsNullOrWhiteSpace($choice)) {
            Write-Warning-Msg $script:TXT_PROJECT_EMPTY
            Start-Sleep -Seconds 1
            continue
        }

        if ($choice -notmatch '^\d+$') {
            Write-Warning-Msg $script:TXT_PROJECT_INVALID_NUM
            Start-Sleep -Seconds 1
            continue
        }

        $choiceNum = [int]$choice
        if ($choiceNum -lt 1 -or $choiceNum -gt $projects.Count) {
            Write-Warning-Msg ($script:TXT_PROJECT_INVALID_RANGE -f $projects.Count)
            Start-Sleep -Seconds 1
            continue
        }

        return $projects[$choiceNum - 1].Name
    }
}

# Função para exibir menu
function Show-Menu {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host "    $script:TXT_TITLE" -ForegroundColor Blue
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host ""
    Write-Host "  1) $script:TXT_MENU_CREATE"
    Write-Host "  2) $script:TXT_MENU_REMOVE"
    Write-Host "  3) $script:TXT_MENU_LIST"
    Write-Host "  4) $script:TXT_MENU_CONFIG_DIR"
    Write-Host "  5) $script:TXT_MENU_CONFIG_AGENT"
    Write-Host "  6) $script:TXT_MENU_CHANGE_LANG"
    Write-Host "  7) $script:TXT_MENU_EXIT"
    Write-Host ""
    Write-Host "$script:TXT_CURRENT_DIR`: $script:BASE_DIR" -ForegroundColor Cyan

    if ($script:AGENT) {
        $agentName = $script:AGENT.Split(':')[0]
        if ($script:ASK_AGENT_EVERY_TIME -eq "true") {
            Write-Host "$script:TXT_CURRENT_AGENT`: $script:TXT_AGENT_ASK_EVERY" -ForegroundColor Cyan
        }
        else {
            Write-Host ("$script:TXT_CURRENT_AGENT`: " + ($script:TXT_AGENT_FIXED -f $agentName)) -ForegroundColor Cyan
        }
    }

    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
}

# Função para criar worktree
function Create-Worktree {
    param([string]$ProjectDir)

    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host "    $script:TXT_WORKTREE_CREATE_TITLE" -ForegroundColor Blue
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host ""

    Write-Host "$script:TXT_WORKTREE_TYPE" -ForegroundColor Cyan
    Write-Host "  1) feat (feature)"
    Write-Host "  2) fix (bugfix)"
    Write-Host "  3) release"
    Write-Host "  4) refactor"
    Write-Host "  5) Outro (customizado)"
    Write-Host ""

    $typeChoice = Read-Host $script:TXT_WORKTREE_TYPE_CHOOSE

    switch ($typeChoice) {
        "1" { $branchType = "feat"; $typeLabel = "feature" }
        "2" { $branchType = "fix"; $typeLabel = "fix" }
        "3" { $branchType = "release"; $typeLabel = "release" }
        "4" { $branchType = "refactor"; $typeLabel = "refactor" }
        "5" {
            $branchType = Read-Host "Digite o prefixo customizado"
            $branchType = $branchType.ToLower() -replace '[^a-z]', ''
            $typeLabel = $branchType
        }
        default { Write-Error-Exit $script:TXT_INVALID_OPTION }
    }

    Write-Host ""
    $featureName = Read-Host ($script:TXT_WORKTREE_NAME_PROMPT -f $typeLabel)

    if ([string]::IsNullOrWhiteSpace($featureName)) {
        Write-Error-Exit $script:TXT_WORKTREE_NAME_EMPTY
    }

    # Sanitizar nome
    $featureName = $featureName.ToLower() -replace '\s+', '-' -replace '[^a-z0-9-]', ''

    $projectName = Split-Path -Leaf $ProjectDir
    $branchName = "$branchType/$featureName"
    $worktreeDir = Join-Path (Split-Path $ProjectDir) "${branchType}_${projectName}_${featureName}"

    Write-Host ""
    Write-Info ($script:TXT_WORKTREE_BRANCH -f $branchName)
    Write-Info ($script:TXT_WORKTREE_DIR_INFO -f $worktreeDir)
    Write-Host ""

    $confirm = Read-Host $script:TXT_WORKTREE_CONFIRM

    if ($confirm -notmatch '^[YySs]$') {
        Write-Warning-Msg $script:TXT_WORKTREE_CANCELLED
        exit 0
    }

    Write-Host ""
    Write-Info $script:TXT_WORKTREE_CREATING

    git worktree add -b $branchName $worktreeDir 2>$null

    if ($LASTEXITCODE -eq 0) {
        Write-Success $script:TXT_WORKTREE_SUCCESS
        Write-Host ""
        Write-Info ($script:TXT_WORKTREE_CURRENT_DIR -f $worktreeDir)

        Set-Location $worktreeDir

        # Abrir agente se configurado
        if ($script:ASK_AGENT_EVERY_TIME -eq "true") {
            Write-Host ""
            Write-Host $script:TXT_WORKTREE_AGENT_ASK -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  1) Claude Code"
            Write-Host "  2) Cursor"
            Write-Host "  3) Gemini"
            Write-Host "  4) GitHub Copilot (code)"
            Write-Host "  5) Windsurf"
            Write-Host "  6) Nenhum"
            Write-Host ""

            $agentChoice = Read-Host "Escolha (1-6)"

            $agentCmd = switch ($agentChoice) {
                "1" { "claude" }
                "2" { "cursor" }
                "3" { "gemini" }
                "4" { "code" }
                "5" { "windsurf" }
                default { "none" }
            }
        }
        else {
            $agentCmd = $script:AGENT.Split(':')[1]
        }

        if ($agentCmd -ne "none") {
            if (Get-Command $agentCmd -ErrorAction SilentlyContinue) {
                & $agentCmd
            }
            else {
                Write-Info $script:TXT_WORKTREE_AGENT_NONE
            }
        }
    }
    else {
        Write-Error-Exit $script:TXT_WORKTREE_FAILED
    }
}

# Função para listar worktrees
function List-Worktrees {
    Write-Host $script:TXT_WORKTREE_LIST -ForegroundColor Blue
    Write-Host ""
    git worktree list
    Write-Host ""
}

# Main
Load-Config | Out-Null

if (-not $script:BASE_DIR) {
    Setup-BaseDirectory
}

if (-not $script:AGENT) {
    Setup-AgentConfig
}

# Processar argumentos
$projectArg = $args[0]
$operation = $args[1]

if (-not $projectArg) {
    # Modo interativo
    $projectName = Get-ProjectName
    Clear-Host
}
else {
    $projectName = $projectArg
}

$projectDir = Join-Path $script:BASE_DIR $projectName

if (-not (Test-Path $projectDir)) {
    Write-Error-Exit "Projeto '$projectName' não encontrado em $script:BASE_DIR"
}

Set-Location $projectDir

Write-Info ($script:TXT_PROJECT_NAME -f $projectName)
Write-Info ($script:TXT_PROJECT_DIR -f $projectDir)
Write-Host ""

# Verificar se é repositório Git
if (-not (Test-Path ".git")) {
    Write-Error-Exit $script:TXT_PROJECT_NOT_GIT
}

# Verificar branch atual
$currentBranch = git branch --show-current

if ($currentBranch -in @("main", "master")) {
    Write-Success ($script:TXT_BRANCH_ON -f $currentBranch)
}
else {
    Write-Warning-Msg ($script:TXT_BRANCH_NOT_MAIN -f $currentBranch)
    Write-Host ""
    $changeBranch = Read-Host $script:TXT_BRANCH_CHANGE

    if ($changeBranch -match '^[YySs]$') {
        if (git show-ref --verify --quiet refs/heads/main) {
            git checkout main
        }
        elseif (git show-ref --verify --quiet refs/heads/master) {
            git checkout master
        }
        $currentBranch = git branch --show-current
    }

    Write-Info ($script:TXT_BRANCH_CONTINUING -f $currentBranch)
}
Write-Host ""

if (-not $operation) {
    # Mostrar menu
    while ($true) {
        Show-Menu
        $menuChoice = Read-Host "$script:TXT_CHOOSE_OPTION`:"
        Write-Host ""

        switch ($menuChoice) {
            "1" { Create-Worktree -ProjectDir $projectDir; break }
            "2" { Write-Host "Remove worktree - Em desenvolvimento"; break }
            "3" { List-Worktrees }
            "4" { Setup-BaseDirectory; Clear-Host }
            "5" { Setup-AgentConfig; Clear-Host }
            "6" { Setup-LanguageConfig; Clear-Host }
            "7" { Write-Info $script:TXT_EXITING; exit 0 }
            default { Write-Error-Exit $script:TXT_INVALID_OPTION }
        }
    }
}
else {
    # Modo direto
    switch ($operation) {
        { $_ -in @("criar", "create") } { Create-Worktree -ProjectDir $projectDir }
        { $_ -in @("listar", "list") } { List-Worktrees }
        default { Write-Error-Exit "Operação inválida" }
    }
}
