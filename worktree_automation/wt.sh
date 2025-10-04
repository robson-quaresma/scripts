#!/bin/bash

# Worktree Manager - Git Worktree Automation
# Author: Quaredx
# Description: Gerencia worktrees do Git de forma interativa

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Arquivo de configuração
CONFIG_FILE="$HOME/.wt_config"

# Idioma padrão
LANGUAGE="${LANGUAGE:-en}"

# Função para carregar textos do idioma
load_language() {
    case "$LANGUAGE" in
        pt|pt-BR|pt_BR)
            # Português
            TXT_TITLE="🌳 Git Worktree Manager"
            TXT_MENU_CREATE="Criar novo worktree"
            TXT_MENU_REMOVE="Remover worktree existente"
            TXT_MENU_LIST="Listar worktrees"
            TXT_MENU_CONFIG_DIR="Configurar diretório de trabalho"
            TXT_MENU_CONFIG_AGENT="Configurar agente IA"
            TXT_MENU_CHANGE_LANG="Alterar idioma"
            TXT_MENU_EXIT="Sair"
            TXT_CURRENT_DIR="📂 Diretório atual"
            TXT_CURRENT_AGENT="🤖 Agente"
            TXT_CHOOSE_OPTION="Escolha uma opção"
            TXT_INVALID_OPTION="Opção inválida"
            TXT_EXITING="Saindo..."
            TXT_CONFIG_SAVED="Configuração salva em"
            TXT_SUCCESS="✅"
            TXT_ERROR="❌ Erro"
            TXT_WARNING="⚠️"
            TXT_INFO="ℹ️"
            TXT_LANGUAGE_NAME="Português (Brasil)"
            # Config Dir
            TXT_CONFIG_DIR_TITLE="⚙️  Configurar Diretório de Trabalho"
            TXT_CONFIG_DIR_CURRENT="Diretório atual"
            TXT_CONFIG_DIR_ENTER="Digite o caminho do diretório onde seus projetos Git estão localizados:"
            TXT_CONFIG_DIR_TAB="(Use Tab para autocomplete de caminhos)"
            TXT_CONFIG_DIR_PROMPT="Diretório"
            TXT_CONFIG_DIR_EMPTY="Diretório não pode ser vazio"
            TXT_CONFIG_DIR_NOT_EXIST="Diretório '%s' não existe"
            TXT_CONFIG_DIR_NO_GIT="Nenhum projeto Git encontrado em '%s'"
            TXT_CONFIG_DIR_CONFIRM="Deseja usar este diretório mesmo assim? (y/n):"
            TXT_CONFIG_DIR_CANCELLED="Configuração cancelada"
            TXT_CONFIG_DIR_SUCCESS="Diretório configurado com sucesso!"
            TXT_CONFIG_DIR_PROJECTS_FOUND="Projetos Git encontrados: %s"
            TXT_PRESS_ENTER="Pressione Enter para continuar..."
            # Config Agent
            TXT_CONFIG_AGENT_TITLE="🤖 Configurar Agente IA"
            TXT_CONFIG_AGENT_CURRENT="Agente atual: %s"
            TXT_CONFIG_AGENT_MODE_ASK="Modo: Perguntar a cada worktree"
            TXT_CONFIG_AGENT_MODE_FIXED="Modo: Sempre usar %s"
            TXT_CONFIG_AGENT_SELECT="Selecione o agente IA que você utiliza:"
            TXT_CONFIG_AGENT_NONE="Nenhum (não abrir agente automaticamente)"
            TXT_CONFIG_AGENT_OTHER="Outro (customizado)"
            TXT_CONFIG_AGENT_CHOOSE="Escolha (1-7):"
            TXT_CONFIG_AGENT_NAME="Nome do agente:"
            TXT_CONFIG_AGENT_CMD="Comando para abrir:"
            TXT_CONFIG_AGENT_EMPTY="Nome e comando não podem ser vazios"
            TXT_CONFIG_AGENT_MODE="Como deseja usar o agente?"
            TXT_CONFIG_AGENT_MODE_1="Sempre usar %s (configuração fixa)"
            TXT_CONFIG_AGENT_MODE_2="Perguntar qual agente usar a cada worktree criado"
            TXT_CONFIG_AGENT_MODE_CHOOSE="Escolha (1-2):"
            TXT_CONFIG_AGENT_SUCCESS="Agente configurado com sucesso!"
            TXT_CONFIG_AGENT_INFO_ASK="Modo: Você será perguntado qual agente usar a cada worktree"
            TXT_CONFIG_AGENT_INFO_FIXED="Modo: Sempre usar %s"
            # Config Language
            TXT_CONFIG_LANG_TITLE="🌐 Configurar Idioma"
            TXT_CONFIG_LANG_SELECT="Selecione o idioma / Select language / Seleccionar idioma:"
            TXT_CONFIG_LANG_SUCCESS="Idioma alterado para: %s"
            # Project Selection
            TXT_PROJECT_AVAILABLE="📁 Projetos disponíveis:"
            TXT_PROJECT_CHOOSE="Escolha o número do projeto (ou 'q' para sair):"
            TXT_PROJECT_EMPTY="Escolha não pode ser vazia"
            TXT_PROJECT_INVALID_NUM="Digite um número válido"
            TXT_PROJECT_INVALID_RANGE="Opção inválida. Escolha entre 1 e %s"
            TXT_PROJECT_NONE_FOUND="Nenhum projeto Git encontrado em %s"
            TXT_PROJECT_NOT_CAPTURED="Nome do projeto não foi capturado corretamente"
            TXT_PROJECT_NAME="Projeto: %s"
            TXT_PROJECT_DIR="Diretório: %s"
            TXT_PROJECT_NOT_FOUND="Diretório do projeto '%s' não encontrado em %s"
            TXT_PROJECT_NOT_GIT="Não é um repositório Git válido"
            # Branch
            TXT_BRANCH_ON="Na branch %s ✓"
            TXT_BRANCH_NOT_MAIN="Você está na branch '%s' (não é main/master)"
            TXT_BRANCH_CHANGE="Deseja trocar para branch principal? (y/n):"
            TXT_BRANCH_CHANGE_FAILED="Não foi possível trocar para %s"
            TXT_BRANCH_NO_MAIN="Nenhuma branch principal (main/master) encontrada"
            TXT_BRANCH_CONTINUING="Continuando na branch: %s"
            # Worktree List
            TXT_WORKTREE_LIST="📋 Worktrees existentes:"
            # Worktree Create
            TXT_WORKTREE_CREATE_TITLE="✨ Criar Novo Worktree"
            TXT_WORKTREE_TYPE="Tipo de branch:"
            TXT_WORKTREE_TYPE_1="feat (feature)"
            TXT_WORKTREE_TYPE_2="fix (bugfix)"
            TXT_WORKTREE_TYPE_3="release"
            TXT_WORKTREE_TYPE_4="refactor"
            TXT_WORKTREE_TYPE_5="Outro (customizado)"
            TXT_WORKTREE_TYPE_CHOOSE="Escolha (1-5):"
            TXT_WORKTREE_TYPE_CUSTOM="Digite o prefixo customizado:"
            TXT_WORKTREE_TYPE_EMPTY="Prefixo não pode ser vazio"
            TXT_WORKTREE_TYPE_INVALID="Prefixo inválido"
            TXT_WORKTREE_NAME_PROMPT="Nome do %s:"
            TXT_WORKTREE_NAME_EMPTY="Nome não pode ser vazio"
            TXT_WORKTREE_BRANCH="Branch: %s"
            TXT_WORKTREE_DIR_INFO="Diretório: %s"
            TXT_WORKTREE_CONFIRM="Confirmar criação? (y/n):"
            TXT_WORKTREE_CANCELLED="Operação cancelada"
            TXT_WORKTREE_CREATING="Criando worktree..."
            TXT_WORKTREE_SUCCESS="Worktree criado com sucesso!"
            TXT_WORKTREE_NAVIGATING="Navegando para %s..."
            TXT_WORKTREE_CURRENT_DIR="Diretório atual: %s"
            TXT_WORKTREE_AGENT_ASK="Qual agente deseja abrir?"
            TXT_WORKTREE_AGENT_INVALID="Opção inválida, pulando abertura do agente"
            TXT_WORKTREE_AGENT_CUSTOM="Comando do agente:"
            TXT_WORKTREE_AGENT_NONE="Nenhum agente será aberto automaticamente"
            TXT_WORKTREE_AGENT_STARTING="Iniciando %s..."
            TXT_WORKTREE_AGENT_NOT_FOUND="Comando '%s' não encontrado. Inicie manualmente se necessário."
            TXT_WORKTREE_FAILED="Falha ao criar worktree. Verifique se a branch já existe."
            # Worktree Remove
            TXT_WORKTREE_REMOVE_TITLE="🗑️  Remover Worktree"
            TXT_WORKTREE_REMOVE_NONE="Nenhum worktree adicional encontrado"
            TXT_WORKTREE_REMOVE_AVAILABLE="Worktrees disponíveis para remoção:"
            TXT_WORKTREE_REMOVE_CHOOSE="Escolha o número do worktree para remover (ou 0 para cancelar):"
            TXT_WORKTREE_REMOVE_CONFIRM="Você está prestes a remover: %s"
            TXT_WORKTREE_REMOVE_CONFIRM_Q="Confirmar remoção? (y/n):"
            TXT_WORKTREE_REMOVING="Removendo worktree..."
            TXT_WORKTREE_REMOVE_SUCCESS="Worktree removido com sucesso!"
            TXT_WORKTREE_REMOVE_FAILED="Falha ao remover worktree"
            # Operation
            TXT_OPERATION_INVALID="Operação inválida. Use: criar, remover ou listar"
            TXT_CONFIG_INITIAL_NEEDED="Configuração inicial necessária"
            TXT_AGENT_ASK_EVERY="Perguntar a cada worktree"
            TXT_AGENT_FIXED="%s (fixo)"
            ;;
        es|es-ES|es_ES)
            # Español
            TXT_TITLE="🌳 Git Worktree Manager"
            TXT_MENU_CREATE="Crear nuevo worktree"
            TXT_MENU_REMOVE="Eliminar worktree existente"
            TXT_MENU_LIST="Listar worktrees"
            TXT_MENU_CONFIG_DIR="Configurar directorio de trabajo"
            TXT_MENU_CONFIG_AGENT="Configurar agente IA"
            TXT_MENU_CHANGE_LANG="Cambiar idioma"
            TXT_MENU_EXIT="Salir"
            TXT_CURRENT_DIR="📂 Directorio actual"
            TXT_CURRENT_AGENT="🤖 Agente"
            TXT_CHOOSE_OPTION="Elige una opción"
            TXT_INVALID_OPTION="Opción inválida"
            TXT_EXITING="Saliendo..."
            TXT_CONFIG_SAVED="Configuración guardada en"
            TXT_SUCCESS="✅"
            TXT_ERROR="❌ Error"
            TXT_WARNING="⚠️"
            TXT_INFO="ℹ️"
            TXT_LANGUAGE_NAME="Español"
            # Config Dir
            TXT_CONFIG_DIR_TITLE="⚙️  Configurar Directorio de Trabajo"
            TXT_CONFIG_DIR_CURRENT="Directorio actual"
            TXT_CONFIG_DIR_ENTER="Ingrese la ruta del directorio donde se encuentran sus proyectos Git:"
            TXT_CONFIG_DIR_TAB="(Use Tab para autocompletar rutas)"
            TXT_CONFIG_DIR_PROMPT="Directorio"
            TXT_CONFIG_DIR_EMPTY="El directorio no puede estar vacío"
            TXT_CONFIG_DIR_NOT_EXIST="El directorio '%s' no existe"
            TXT_CONFIG_DIR_NO_GIT="No se encontraron proyectos Git en '%s'"
            TXT_CONFIG_DIR_CONFIRM="¿Desea usar este directorio de todos modos? (y/n):"
            TXT_CONFIG_DIR_CANCELLED="Configuración cancelada"
            TXT_CONFIG_DIR_SUCCESS="¡Directorio configurado con éxito!"
            TXT_CONFIG_DIR_PROJECTS_FOUND="Proyectos Git encontrados: %s"
            TXT_PRESS_ENTER="Presione Enter para continuar..."
            # Config Agent
            TXT_CONFIG_AGENT_TITLE="🤖 Configurar Agente IA"
            TXT_CONFIG_AGENT_CURRENT="Agente actual: %s"
            TXT_CONFIG_AGENT_MODE_ASK="Modo: Preguntar en cada worktree"
            TXT_CONFIG_AGENT_MODE_FIXED="Modo: Siempre usar %s"
            TXT_CONFIG_AGENT_SELECT="Seleccione el agente IA que utiliza:"
            TXT_CONFIG_AGENT_NONE="Ninguno (no abrir agente automáticamente)"
            TXT_CONFIG_AGENT_OTHER="Otro (personalizado)"
            TXT_CONFIG_AGENT_CHOOSE="Elija (1-7):"
            TXT_CONFIG_AGENT_NAME="Nombre del agente:"
            TXT_CONFIG_AGENT_CMD="Comando para abrir:"
            TXT_CONFIG_AGENT_EMPTY="El nombre y el comando no pueden estar vacíos"
            TXT_CONFIG_AGENT_MODE="¿Cómo desea usar el agente?"
            TXT_CONFIG_AGENT_MODE_1="Siempre usar %s (configuración fija)"
            TXT_CONFIG_AGENT_MODE_2="Preguntar qué agente usar en cada worktree creado"
            TXT_CONFIG_AGENT_MODE_CHOOSE="Elija (1-2):"
            TXT_CONFIG_AGENT_SUCCESS="¡Agente configurado con éxito!"
            TXT_CONFIG_AGENT_INFO_ASK="Modo: Se le preguntará qué agente usar en cada worktree"
            TXT_CONFIG_AGENT_INFO_FIXED="Modo: Siempre usar %s"
            # Config Language
            TXT_CONFIG_LANG_TITLE="🌐 Configurar Idioma"
            TXT_CONFIG_LANG_SELECT="Selecione o idioma / Select language / Seleccionar idioma:"
            TXT_CONFIG_LANG_SUCCESS="Idioma cambiado a: %s"
            # Project Selection
            TXT_PROJECT_AVAILABLE="📁 Proyectos disponibles:"
            TXT_PROJECT_CHOOSE="Elija el número del proyecto (o 'q' para salir):"
            TXT_PROJECT_EMPTY="La elección no puede estar vacía"
            TXT_PROJECT_INVALID_NUM="Ingrese un número válido"
            TXT_PROJECT_INVALID_RANGE="Opción inválida. Elija entre 1 y %s"
            TXT_PROJECT_NONE_FOUND="No se encontraron proyectos Git en %s"
            TXT_PROJECT_NOT_CAPTURED="El nombre del proyecto no se capturó correctamente"
            TXT_PROJECT_NAME="Proyecto: %s"
            TXT_PROJECT_DIR="Directorio: %s"
            TXT_PROJECT_NOT_FOUND="Directorio del proyecto '%s' no encontrado en %s"
            TXT_PROJECT_NOT_GIT="No es un repositorio Git válido"
            # Branch
            TXT_BRANCH_ON="En la rama %s ✓"
            TXT_BRANCH_NOT_MAIN="Está en la rama '%s' (no es main/master)"
            TXT_BRANCH_CHANGE="¿Desea cambiar a la rama principal? (y/n):"
            TXT_BRANCH_CHANGE_FAILED="No se pudo cambiar a %s"
            TXT_BRANCH_NO_MAIN="No se encontró ninguna rama principal (main/master)"
            TXT_BRANCH_CONTINUING="Continuando en la rama: %s"
            # Worktree List
            TXT_WORKTREE_LIST="📋 Worktrees existentes:"
            # Worktree Create
            TXT_WORKTREE_CREATE_TITLE="✨ Crear Nuevo Worktree"
            TXT_WORKTREE_TYPE="Tipo de rama:"
            TXT_WORKTREE_TYPE_1="feat (feature)"
            TXT_WORKTREE_TYPE_2="fix (bugfix)"
            TXT_WORKTREE_TYPE_3="release"
            TXT_WORKTREE_TYPE_4="refactor"
            TXT_WORKTREE_TYPE_5="Otro (personalizado)"
            TXT_WORKTREE_TYPE_CHOOSE="Elija (1-5):"
            TXT_WORKTREE_TYPE_CUSTOM="Ingrese el prefijo personalizado:"
            TXT_WORKTREE_TYPE_EMPTY="El prefijo no puede estar vacío"
            TXT_WORKTREE_TYPE_INVALID="Prefijo inválido"
            TXT_WORKTREE_NAME_PROMPT="Nombre del %s:"
            TXT_WORKTREE_NAME_EMPTY="El nombre no puede estar vacío"
            TXT_WORKTREE_BRANCH="Rama: %s"
            TXT_WORKTREE_DIR_INFO="Directorio: %s"
            TXT_WORKTREE_CONFIRM="¿Confirmar creación? (y/n):"
            TXT_WORKTREE_CANCELLED="Operación cancelada"
            TXT_WORKTREE_CREATING="Creando worktree..."
            TXT_WORKTREE_SUCCESS="¡Worktree creado con éxito!"
            TXT_WORKTREE_NAVIGATING="Navegando a %s..."
            TXT_WORKTREE_CURRENT_DIR="Directorio actual: %s"
            TXT_WORKTREE_AGENT_ASK="¿Qué agente desea abrir?"
            TXT_WORKTREE_AGENT_INVALID="Opción inválida, omitiendo apertura del agente"
            TXT_WORKTREE_AGENT_CUSTOM="Comando del agente:"
            TXT_WORKTREE_AGENT_NONE="No se abrirá ningún agente automáticamente"
            TXT_WORKTREE_AGENT_STARTING="Iniciando %s..."
            TXT_WORKTREE_AGENT_NOT_FOUND="Comando '%s' no encontrado. Inicie manualmente si es necesario."
            TXT_WORKTREE_FAILED="Error al crear worktree. Verifique si la rama ya existe."
            # Worktree Remove
            TXT_WORKTREE_REMOVE_TITLE="🗑️  Eliminar Worktree"
            TXT_WORKTREE_REMOVE_NONE="No se encontraron worktrees adicionales"
            TXT_WORKTREE_REMOVE_AVAILABLE="Worktrees disponibles para eliminación:"
            TXT_WORKTREE_REMOVE_CHOOSE="Elija el número del worktree para eliminar (o 0 para cancelar):"
            TXT_WORKTREE_REMOVE_CONFIRM="Está a punto de eliminar: %s"
            TXT_WORKTREE_REMOVE_CONFIRM_Q="¿Confirmar eliminación? (y/n):"
            TXT_WORKTREE_REMOVING="Eliminando worktree..."
            TXT_WORKTREE_REMOVE_SUCCESS="¡Worktree eliminado con éxito!"
            TXT_WORKTREE_REMOVE_FAILED="Error al eliminar worktree"
            # Operation
            TXT_OPERATION_INVALID="Operación inválida. Use: criar, remover o listar"
            TXT_CONFIG_INITIAL_NEEDED="Se requiere configuración inicial"
            TXT_AGENT_ASK_EVERY="Preguntar en cada worktree"
            TXT_AGENT_FIXED="%s (fijo)"
            ;;
        *)
            # English (default)
            LANGUAGE="en"
            TXT_TITLE="🌳 Git Worktree Manager"
            TXT_MENU_CREATE="Create new worktree"
            TXT_MENU_REMOVE="Remove existing worktree"
            TXT_MENU_LIST="List worktrees"
            TXT_MENU_CONFIG_DIR="Configure working directory"
            TXT_MENU_CONFIG_AGENT="Configure AI agent"
            TXT_MENU_CHANGE_LANG="Change language"
            TXT_MENU_EXIT="Exit"
            TXT_CURRENT_DIR="📂 Current directory"
            TXT_CURRENT_AGENT="🤖 Agent"
            TXT_CHOOSE_OPTION="Choose an option"
            TXT_INVALID_OPTION="Invalid option"
            TXT_EXITING="Exiting..."
            TXT_CONFIG_SAVED="Configuration saved in"
            TXT_SUCCESS="✅"
            TXT_ERROR="❌ Error"
            TXT_WARNING="⚠️"
            TXT_INFO="ℹ️"
            TXT_LANGUAGE_NAME="English"
            # Config Dir
            TXT_CONFIG_DIR_TITLE="⚙️  Configure Working Directory"
            TXT_CONFIG_DIR_CURRENT="Current directory"
            TXT_CONFIG_DIR_ENTER="Enter the path to the directory where your Git projects are located:"
            TXT_CONFIG_DIR_TAB="(Use Tab for path autocomplete)"
            TXT_CONFIG_DIR_PROMPT="Directory"
            TXT_CONFIG_DIR_EMPTY="Directory cannot be empty"
            TXT_CONFIG_DIR_NOT_EXIST="Directory '%s' does not exist"
            TXT_CONFIG_DIR_NO_GIT="No Git projects found in '%s'"
            TXT_CONFIG_DIR_CONFIRM="Do you want to use this directory anyway? (y/n):"
            TXT_CONFIG_DIR_CANCELLED="Configuration cancelled"
            TXT_CONFIG_DIR_SUCCESS="Directory configured successfully!"
            TXT_CONFIG_DIR_PROJECTS_FOUND="Git projects found: %s"
            TXT_PRESS_ENTER="Press Enter to continue..."
            # Config Agent
            TXT_CONFIG_AGENT_TITLE="🤖 Configure AI Agent"
            TXT_CONFIG_AGENT_CURRENT="Current agent: %s"
            TXT_CONFIG_AGENT_MODE_ASK="Mode: Ask for each worktree"
            TXT_CONFIG_AGENT_MODE_FIXED="Mode: Always use %s"
            TXT_CONFIG_AGENT_SELECT="Select the AI agent you use:"
            TXT_CONFIG_AGENT_NONE="None (don't open agent automatically)"
            TXT_CONFIG_AGENT_OTHER="Other (custom)"
            TXT_CONFIG_AGENT_CHOOSE="Choose (1-7):"
            TXT_CONFIG_AGENT_NAME="Agent name:"
            TXT_CONFIG_AGENT_CMD="Command to open:"
            TXT_CONFIG_AGENT_EMPTY="Name and command cannot be empty"
            TXT_CONFIG_AGENT_MODE="How do you want to use the agent?"
            TXT_CONFIG_AGENT_MODE_1="Always use %s (fixed configuration)"
            TXT_CONFIG_AGENT_MODE_2="Ask which agent to use for each worktree created"
            TXT_CONFIG_AGENT_MODE_CHOOSE="Choose (1-2):"
            TXT_CONFIG_AGENT_SUCCESS="Agent configured successfully!"
            TXT_CONFIG_AGENT_INFO_ASK="Mode: You will be asked which agent to use for each worktree"
            TXT_CONFIG_AGENT_INFO_FIXED="Mode: Always use %s"
            # Config Language
            TXT_CONFIG_LANG_TITLE="🌐 Configure Language"
            TXT_CONFIG_LANG_SELECT="Selecione o idioma / Select language / Seleccionar idioma:"
            TXT_CONFIG_LANG_SUCCESS="Language changed to: %s"
            # Project Selection
            TXT_PROJECT_AVAILABLE="📁 Available projects:"
            TXT_PROJECT_CHOOSE="Choose the project number (or 'q' to quit):"
            TXT_PROJECT_EMPTY="Choice cannot be empty"
            TXT_PROJECT_INVALID_NUM="Enter a valid number"
            TXT_PROJECT_INVALID_RANGE="Invalid option. Choose between 1 and %s"
            TXT_PROJECT_NONE_FOUND="No Git projects found in %s"
            TXT_PROJECT_NOT_CAPTURED="Project name was not captured correctly"
            TXT_PROJECT_NAME="Project: %s"
            TXT_PROJECT_DIR="Directory: %s"
            TXT_PROJECT_NOT_FOUND="Project directory '%s' not found in %s"
            TXT_PROJECT_NOT_GIT="Not a valid Git repository"
            # Branch
            TXT_BRANCH_ON="On branch %s ✓"
            TXT_BRANCH_NOT_MAIN="You are on branch '%s' (not main/master)"
            TXT_BRANCH_CHANGE="Do you want to switch to main branch? (y/n):"
            TXT_BRANCH_CHANGE_FAILED="Could not switch to %s"
            TXT_BRANCH_NO_MAIN="No main branch (main/master) found"
            TXT_BRANCH_CONTINUING="Continuing on branch: %s"
            # Worktree List
            TXT_WORKTREE_LIST="📋 Existing worktrees:"
            # Worktree Create
            TXT_WORKTREE_CREATE_TITLE="✨ Create New Worktree"
            TXT_WORKTREE_TYPE="Branch type:"
            TXT_WORKTREE_TYPE_1="feat (feature)"
            TXT_WORKTREE_TYPE_2="fix (bugfix)"
            TXT_WORKTREE_TYPE_3="release"
            TXT_WORKTREE_TYPE_4="refactor"
            TXT_WORKTREE_TYPE_5="Other (custom)"
            TXT_WORKTREE_TYPE_CHOOSE="Choose (1-5):"
            TXT_WORKTREE_TYPE_CUSTOM="Enter custom prefix:"
            TXT_WORKTREE_TYPE_EMPTY="Prefix cannot be empty"
            TXT_WORKTREE_TYPE_INVALID="Invalid prefix"
            TXT_WORKTREE_NAME_PROMPT="Name of %s:"
            TXT_WORKTREE_NAME_EMPTY="Name cannot be empty"
            TXT_WORKTREE_BRANCH="Branch: %s"
            TXT_WORKTREE_DIR_INFO="Directory: %s"
            TXT_WORKTREE_CONFIRM="Confirm creation? (y/n):"
            TXT_WORKTREE_CANCELLED="Operation cancelled"
            TXT_WORKTREE_CREATING="Creating worktree..."
            TXT_WORKTREE_SUCCESS="Worktree created successfully!"
            TXT_WORKTREE_NAVIGATING="Navigating to %s..."
            TXT_WORKTREE_CURRENT_DIR="Current directory: %s"
            TXT_WORKTREE_AGENT_ASK="Which agent do you want to open?"
            TXT_WORKTREE_AGENT_INVALID="Invalid option, skipping agent opening"
            TXT_WORKTREE_AGENT_CUSTOM="Agent command:"
            TXT_WORKTREE_AGENT_NONE="No agent will be opened automatically"
            TXT_WORKTREE_AGENT_STARTING="Starting %s..."
            TXT_WORKTREE_AGENT_NOT_FOUND="Command '%s' not found. Start manually if needed."
            TXT_WORKTREE_FAILED="Failed to create worktree. Check if branch already exists."
            # Worktree Remove
            TXT_WORKTREE_REMOVE_TITLE="🗑️  Remove Worktree"
            TXT_WORKTREE_REMOVE_NONE="No additional worktrees found"
            TXT_WORKTREE_REMOVE_AVAILABLE="Worktrees available for removal:"
            TXT_WORKTREE_REMOVE_CHOOSE="Choose the worktree number to remove (or 0 to cancel):"
            TXT_WORKTREE_REMOVE_CONFIRM="You are about to remove: %s"
            TXT_WORKTREE_REMOVE_CONFIRM_Q="Confirm removal? (y/n):"
            TXT_WORKTREE_REMOVING="Removing worktree..."
            TXT_WORKTREE_REMOVE_SUCCESS="Worktree removed successfully!"
            TXT_WORKTREE_REMOVE_FAILED="Failed to remove worktree"
            # Operation
            TXT_OPERATION_INVALID="Invalid operation. Use: create, remove or list"
            TXT_CONFIG_INITIAL_NEEDED="Initial configuration needed"
            TXT_AGENT_ASK_EVERY="Ask for each worktree"
            TXT_AGENT_FIXED="%s (fixed)"
            ;;
    esac
}

# Função para carregar configuração
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        if [ -z "$BASE_DIR" ]; then
            return 1
        fi
        # Carregar idioma após ler config
        load_language
        return 0
    else
        # Carregar idioma padrão
        load_language
        return 1
    fi
}

# Função para salvar configuração
save_config() {
    local dir="$1"
    local agent="${2:-$AGENT}"
    local ask_every_time="${3:-$ASK_AGENT_EVERY_TIME}"
    local lang="${4:-$LANGUAGE}"

    cat > "$CONFIG_FILE" << EOF
BASE_DIR="$dir"
AGENT="$agent"
ASK_AGENT_EVERY_TIME="$ask_every_time"
LANGUAGE="$lang"
EOF
    success "$TXT_CONFIG_SAVED $CONFIG_FILE"
}

# Função para salvar apenas agente
save_agent_config() {
    local agent="$1"
    local ask_every_time="$2"

    # Manter BASE_DIR atual
    save_config "$BASE_DIR" "$agent" "$ask_every_time"
}

# Função para configurar diretório base
setup_base_directory() {
    clear
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    ⚙️  Configurar Diretório de Trabalho${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    if [ -n "$BASE_DIR" ]; then
        info "Diretório atual: $BASE_DIR"
        echo ""
    fi

    echo -e "${CYAN}Digite o caminho do diretório onde seus projetos Git estão localizados:${NC}"
    echo -e "${YELLOW}(Use Tab para autocomplete de caminhos)${NC}"
    echo ""

    # Habilitar autocomplete de paths
    read -e -p "Diretório: " NEW_BASE_DIR

    # Expandir ~ para home
    NEW_BASE_DIR="${NEW_BASE_DIR/#\~/$HOME}"

    # Verificar se está vazio
    if [ -z "$NEW_BASE_DIR" ]; then
        warning "Diretório não pode ser vazio"
        sleep 2
        return 1
    fi

    # Verificar se diretório existe
    if [ ! -d "$NEW_BASE_DIR" ]; then
        error_exit "Diretório '$NEW_BASE_DIR' não existe"
    fi

    # Verificar se há pelo menos um projeto Git
    GIT_COUNT=$(find "$NEW_BASE_DIR" -maxdepth 2 -name ".git" -type d 2>/dev/null | wc -l)
    if [ "$GIT_COUNT" -eq 0 ]; then
        echo ""
        warning "Nenhum projeto Git encontrado em '$NEW_BASE_DIR'"
        echo ""
        read -p "$(echo -e ${YELLOW}Deseja usar este diretório mesmo assim? \(y/n\):${NC} )" CONFIRM
        if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
            warning "Configuração cancelada"
            sleep 1
            return 1
        fi
    fi

    # Salvar configuração
    save_config "$NEW_BASE_DIR"
    BASE_DIR="$NEW_BASE_DIR"

    echo ""
    success "Diretório configurado com sucesso!"
    echo ""
    info "Projetos Git encontrados: $GIT_COUNT"
    echo ""
    read -p "Pressione Enter para continuar..."
}

# Função para configurar agente IA
setup_agent_config() {
    clear
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    🤖 Configurar Agente IA${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    if [ -n "$AGENT" ]; then
        info "Agente atual: $AGENT"
        if [ "$ASK_AGENT_EVERY_TIME" = "true" ]; then
            info "Modo: Perguntar a cada worktree"
        else
            info "Modo: Sempre usar $AGENT"
        fi
        echo ""
    fi

    echo -e "${CYAN}Selecione o agente IA que você utiliza:${NC}"
    echo ""
    echo "  1) Claude Code"
    echo "  2) Cursor"
    echo "  3) Gemini"
    echo "  4) GitHub Copilot (codex)"
    echo "  5) Windsurf"
    echo "  6) Nenhum (não abrir agente automaticamente)"
    echo "  7) Outro (customizado)"
    echo ""
    read -p "Escolha (1-7): " AGENT_CHOICE

    case $AGENT_CHOICE in
        1)
            SELECTED_AGENT="claude"
            AGENT_CMD="claude"
            ;;
        2)
            SELECTED_AGENT="cursor"
            AGENT_CMD="cursor"
            ;;
        3)
            SELECTED_AGENT="gemini"
            AGENT_CMD="gemini"
            ;;
        4)
            SELECTED_AGENT="copilot"
            AGENT_CMD="code"
            ;;
        5)
            SELECTED_AGENT="windsurf"
            AGENT_CMD="windsurf"
            ;;
        6)
            SELECTED_AGENT="none"
            AGENT_CMD="none"
            ;;
        7)
            read -p "$(echo -e ${CYAN}Nome do agente:${NC} )" SELECTED_AGENT
            read -p "$(echo -e ${CYAN}Comando para abrir:${NC} )" AGENT_CMD
            if [ -z "$SELECTED_AGENT" ] || [ -z "$AGENT_CMD" ]; then
                error_exit "Nome e comando não podem ser vazios"
            fi
            ;;
        *)
            error_exit "Opção inválida"
            ;;
    esac

    echo ""
    echo -e "${CYAN}Como deseja usar o agente?${NC}"
    echo ""
    echo "  1) Sempre usar $SELECTED_AGENT (configuração fixa)"
    echo "  2) Perguntar qual agente usar a cada worktree criado"
    echo ""
    read -p "Escolha (1-2): " MODE_CHOICE

    case $MODE_CHOICE in
        1)
            ASK_EVERY_TIME="false"
            ;;
        2)
            ASK_EVERY_TIME="true"
            ;;
        *)
            error_exit "Opção inválida"
            ;;
    esac

    # Salvar configuração
    save_agent_config "$SELECTED_AGENT:$AGENT_CMD" "$ASK_EVERY_TIME"
    AGENT="$SELECTED_AGENT:$AGENT_CMD"
    ASK_AGENT_EVERY_TIME="$ASK_EVERY_TIME"

    echo ""
    success "Agente configurado com sucesso!"
    echo ""
    if [ "$ASK_EVERY_TIME" = "true" ]; then
        info "Modo: Você será perguntado qual agente usar a cada worktree"
    else
        info "Modo: Sempre usar $SELECTED_AGENT"
    fi
    echo ""
    read -p "Pressione Enter para continuar..."
}

# Função para configurar idioma
setup_language_config() {
    clear
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    $TXT_CONFIG_LANG_TITLE${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    if [ -n "$LANGUAGE" ]; then
        info "$(printf "%s: %s" "Current language" "$TXT_LANGUAGE_NAME")"
        echo ""
    fi

    echo -e "${CYAN}$TXT_CONFIG_LANG_SELECT${NC}"
    echo ""
    echo "  1) English"
    echo "  2) Português (Brasil)"
    echo "  3) Español"
    echo ""
    read -p "Choose / Escolha / Elija (1-3): " LANG_CHOICE

    case $LANG_CHOICE in
        1)
            NEW_LANGUAGE="en"
            LANG_NAME="English"
            ;;
        2)
            NEW_LANGUAGE="pt-BR"
            LANG_NAME="Português (Brasil)"
            ;;
        3)
            NEW_LANGUAGE="es"
            LANG_NAME="Español"
            ;;
        *)
            warning "$TXT_INVALID_OPTION"
            sleep 1
            return 1
            ;;
    esac

    # Salvar configuração
    LANGUAGE="$NEW_LANGUAGE"
    save_config "$BASE_DIR" "$AGENT" "$ASK_AGENT_EVERY_TIME" "$LANGUAGE"

    # Recarregar textos
    load_language

    echo ""
    success "$(printf "$TXT_CONFIG_LANG_SUCCESS" "$LANG_NAME")"
    echo ""
    read -p "$TXT_PRESS_ENTER"
}

# Carregar configuração ou solicitar setup inicial
if ! load_config; then
    setup_base_directory
    if [ -z "$BASE_DIR" ]; then
        error_exit "Configuração inicial necessária"
    fi
fi

# Configurar agente se não estiver configurado
if [ -z "$AGENT" ]; then
    setup_agent_config
fi

# Função para exibir erro e sair
error_exit() {
    echo -e "${RED}❌ Erro: $1${NC}" >&2
    exit 1
}

# Função para exibir sucesso
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Função para exibir info
info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

# Função para exibir warning
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Função para exibir menu
show_menu() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    $TXT_TITLE${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "  1) $TXT_MENU_CREATE"
    echo "  2) $TXT_MENU_REMOVE"
    echo "  3) $TXT_MENU_LIST"
    echo "  4) $TXT_MENU_CONFIG_DIR"
    echo "  5) $TXT_MENU_CONFIG_AGENT"
    echo "  6) $TXT_MENU_CHANGE_LANG"
    echo "  7) $TXT_MENU_EXIT"
    echo ""
    echo -e "${CYAN}$TXT_CURRENT_DIR: $BASE_DIR${NC}"

    # Mostrar configuração do agente
    if [ -n "$AGENT" ]; then
        AGENT_NAME="${AGENT%%:*}"
        if [ "$ASK_AGENT_EVERY_TIME" = "true" ]; then
            echo -e "${CYAN}$TXT_CURRENT_AGENT: $TXT_AGENT_ASK_EVERY${NC}"
        else
            echo -e "${CYAN}$TXT_CURRENT_AGENT: $(printf "$TXT_AGENT_FIXED" "$AGENT_NAME")${NC}"
        fi
    fi

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Função para listar projetos disponíveis
list_available_projects() {
    echo -e "${CYAN}📁 Projetos disponíveis:${NC}"
    if [ -d "$BASE_DIR" ]; then
        ls -1 "$BASE_DIR" 2>/dev/null | while read -r proj; do
            if [ -d "$BASE_DIR/$proj/.git" ]; then
                echo "  • $proj"
            fi
        done
    fi
    echo ""
}

# Função para solicitar nome do projeto interativamente
get_project_name() {
    while true; do
        clear >&2
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" >&2
        echo -e "${BLUE}    🌳 Git Worktree Manager${NC}" >&2
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" >&2
        echo "" >&2

        # Coletar projetos Git em array
        PROJECT_ARRAY=()
        if [ -d "$BASE_DIR" ]; then
            while IFS= read -r proj; do
                if [ -d "$BASE_DIR/$proj/.git" ]; then
                    PROJECT_ARRAY+=("$proj")
                fi
            done < <(ls -1 "$BASE_DIR" 2>/dev/null)
        fi

        # Verificar se há projetos
        if [ ${#PROJECT_ARRAY[@]} -eq 0 ]; then
            error_exit "Nenhum projeto Git encontrado em $BASE_DIR"
        fi

        # Mostrar menu de projetos
        echo -e "${CYAN}📁 Projetos disponíveis:${NC}" >&2
        echo "" >&2
        INDEX=1
        for proj in "${PROJECT_ARRAY[@]}"; do
            echo "  $INDEX) $proj" >&2
            ((INDEX++))
        done
        echo "" >&2

        read -p "$(echo -e ${CYAN}Escolha o número do projeto \(ou \'q\' para sair\):${NC} )" CHOICE

        # Verificar se quer sair
        if [[ "$CHOICE" == "q" ]] || [[ "$CHOICE" == "sair" ]] || [[ "$CHOICE" == "exit" ]]; then
            clear >&2
            echo -e "${CYAN}ℹ️  Saindo...${NC}" >&2
            exit 0
        fi

        # Verificar se entrada está vazia
        if [ -z "$CHOICE" ]; then
            echo "" >&2
            echo -e "${YELLOW}⚠️  Escolha não pode ser vazia${NC}" >&2
            echo "" >&2
            sleep 1
            continue
        fi

        # Verificar se é número válido
        if ! [[ "$CHOICE" =~ ^[0-9]+$ ]]; then
            echo "" >&2
            echo -e "${YELLOW}⚠️  Digite um número válido${NC}" >&2
            echo "" >&2
            sleep 1
            continue
        fi

        # Verificar se está no range
        if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt "${#PROJECT_ARRAY[@]}" ]; then
            echo "" >&2
            echo -e "${YELLOW}⚠️  Opção inválida. Escolha entre 1 e ${#PROJECT_ARRAY[@]}${NC}" >&2
            echo "" >&2
            sleep 1
            continue
        fi

        # Retornar projeto selecionado
        SELECTED_PROJECT="${PROJECT_ARRAY[$((CHOICE-1))]}"
        echo "$SELECTED_PROJECT"
        break
    done
}

# Verificar argumentos
if [ -z "$1" ]; then
    # Modo interativo - solicitar nome do projeto
    PROJECT_NAME=$(get_project_name)

    # Verificar se PROJECT_NAME está vazio
    if [ -z "$PROJECT_NAME" ]; then
        error_exit "Nome do projeto não foi capturado corretamente"
    fi

    # Limpar tela e mostrar confirmação
    clear
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    🌳 Git Worktree Manager${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
else
    PROJECT_NAME="$1"
    PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"

    # Verificar se o diretório do projeto existe
    if [ ! -d "$PROJECT_DIR" ]; then
        error_exit "Diretório do projeto '$PROJECT_NAME' não encontrado em $BASE_DIR"
    fi
fi

PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"

# Navegar para o diretório do projeto
cd "$PROJECT_DIR" || error_exit "Não foi possível acessar o diretório $PROJECT_DIR"

info "Projeto: $PROJECT_NAME"
info "Diretório: $PROJECT_DIR"
echo ""

# Verificar se está em um repositório Git
if [ ! -d ".git" ]; then
    error_exit "Não é um repositório Git válido"
fi

# Verificar branch atual
CURRENT_BRANCH=$(git branch --show-current)

# Verificar se está em branch main ou master (branches principais)
if [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "master" ]; then
    success "Na branch $CURRENT_BRANCH ✓"
else
    warning "Você está na branch '$CURRENT_BRANCH' (não é main/master)"
    echo ""
    read -p "$(echo -e ${YELLOW}Deseja trocar para branch principal? \(y/n\):${NC} )" CHANGE_BRANCH

    if [[ "$CHANGE_BRANCH" =~ ^[Yy]$ ]]; then
        # Tentar main primeiro, depois master
        if git show-ref --verify --quiet refs/heads/main; then
            git checkout main || warning "Não foi possível trocar para main"
        elif git show-ref --verify --quiet refs/heads/master; then
            git checkout master || warning "Não foi possível trocar para master"
        else
            warning "Nenhuma branch principal (main/master) encontrada"
        fi
        CURRENT_BRANCH=$(git branch --show-current)
    fi

    info "Continuando na branch: $CURRENT_BRANCH"
fi
echo ""

# Função para listar worktrees
list_worktrees() {
    echo -e "${BLUE}📋 Worktrees existentes:${NC}"
    echo ""
    git worktree list
    echo ""
}

# Função para criar worktree
create_worktree() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    ✨ Criar Novo Worktree${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Solicitar tipo
    echo -e "${CYAN}Tipo de branch:${NC}"
    echo "  1) feat (feature)"
    echo "  2) fix (bugfix)"
    echo "  3) release"
    echo "  4) refactor"
    echo "  5) Outro (customizado)"
    echo ""
    read -p "Escolha (1-5): " TYPE_CHOICE

    case $TYPE_CHOICE in
        1)
            BRANCH_TYPE="feat"
            TYPE_LABEL="feature"
            ;;
        2)
            BRANCH_TYPE="fix"
            TYPE_LABEL="fix"
            ;;
        3)
            BRANCH_TYPE="release"
            TYPE_LABEL="release"
            ;;
        4)
            BRANCH_TYPE="refactor"
            TYPE_LABEL="refactor"
            ;;
        5)
            read -p "$(echo -e ${CYAN}Digite o prefixo customizado:${NC} )" BRANCH_TYPE
            if [ -z "$BRANCH_TYPE" ]; then
                error_exit "Prefixo não pode ser vazio"
            fi
            # Validar prefixo (apenas letras minúsculas)
            BRANCH_TYPE=$(echo "$BRANCH_TYPE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]//g')
            if [ -z "$BRANCH_TYPE" ]; then
                error_exit "Prefixo inválido"
            fi
            TYPE_LABEL="$BRANCH_TYPE"
            ;;
        *)
            error_exit "Opção inválida"
            ;;
    esac

    echo ""

    # Solicitar nome (dinâmico baseado no tipo)
    read -p "$(echo -e ${CYAN}Nome do $TYPE_LABEL:${NC} )" FEATURE_NAME

    if [ -z "$FEATURE_NAME" ]; then
        error_exit "Nome não pode ser vazio"
    fi

    # Validar nome (remover espaços e caracteres especiais)
    FEATURE_NAME=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

    BRANCH_NAME="${BRANCH_TYPE}/${FEATURE_NAME}"
    WORKTREE_DIR="../${BRANCH_TYPE}_${PROJECT_NAME}_${FEATURE_NAME}"

    echo ""
    info "Branch: $BRANCH_NAME"
    info "Diretório: $WORKTREE_DIR"
    echo ""

    # Confirmar criação
    read -p "$(echo -e ${YELLOW}Confirmar criação? \(y/n\):${NC} )" CONFIRM

    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        warning "Operação cancelada"
        exit 0
    fi

    echo ""
    info "Criando worktree..."

    # Criar worktree
    if git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR" 2>/dev/null; then
        success "Worktree criado com sucesso!"
        echo ""
        info "Navegando para $WORKTREE_DIR..."
        cd "$WORKTREE_DIR" || error_exit "Não foi possível acessar $WORKTREE_DIR"

        success "Diretório atual: $(pwd)"
        echo ""

        # Abrir agente IA configurado
        if [ "$ASK_AGENT_EVERY_TIME" = "true" ]; then
            # Perguntar qual agente usar
            echo -e "${CYAN}Qual agente deseja abrir?${NC}"
            echo ""
            echo "  1) Claude Code"
            echo "  2) Cursor"
            echo "  3) Gemini"
            echo "  4) GitHub Copilot (code)"
            echo "  5) Windsurf"
            echo "  6) Nenhum"
            echo "  7) Outro"
            echo ""
            read -p "Escolha (1-7): " AGENT_NOW_CHOICE

            case $AGENT_NOW_CHOICE in
                1) AGENT_CMD_NOW="claude" ;;
                2) AGENT_CMD_NOW="cursor" ;;
                3) AGENT_CMD_NOW="gemini" ;;
                4) AGENT_CMD_NOW="code" ;;
                5) AGENT_CMD_NOW="windsurf" ;;
                6) AGENT_CMD_NOW="none" ;;
                7)
                    read -p "$(echo -e ${CYAN}Comando do agente:${NC} )" AGENT_CMD_NOW
                    ;;
                *)
                    warning "Opção inválida, pulando abertura do agente"
                    AGENT_CMD_NOW="none"
                    ;;
            esac
        else
            # Usar agente configurado
            AGENT_CMD_NOW="${AGENT#*:}"  # Extrai comando após ":"
        fi

        # Executar comando do agente (se não for "none")
        if [ "$AGENT_CMD_NOW" != "none" ]; then
            if command -v "$AGENT_CMD_NOW" &> /dev/null; then
                AGENT_NAME="${AGENT%%:*}"  # Extrai nome antes de ":"
                info "Iniciando $AGENT_NAME..."
                echo ""
                $AGENT_CMD_NOW
            else
                warning "Comando '$AGENT_CMD_NOW' não encontrado. Inicie manualmente se necessário."
            fi
        else
            info "Nenhum agente será aberto automaticamente"
        fi
    else
        error_exit "Falha ao criar worktree. Verifique se a branch já existe."
    fi
}

# Função para remover worktree
remove_worktree() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    🗑️  Remover Worktree${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Listar worktrees existentes (exceto main)
    WORKTREES=$(git worktree list | grep -v "main" | awk '{print $1}')

    if [ -z "$WORKTREES" ]; then
        warning "Nenhum worktree adicional encontrado"
        exit 0
    fi

    echo -e "${CYAN}Worktrees disponíveis para remoção:${NC}"
    echo ""

    # Array para armazenar worktrees
    WORKTREE_ARRAY=()
    INDEX=1

    while IFS= read -r line; do
        WORKTREE_ARRAY+=("$line")
        echo "  $INDEX) $line"
        ((INDEX++))
    done <<< "$WORKTREES"

    echo ""
    read -p "$(echo -e ${CYAN}Escolha o número do worktree para remover \(ou 0 para cancelar\):${NC} )" CHOICE

    if [ "$CHOICE" = "0" ]; then
        warning "Operação cancelada"
        exit 0
    fi

    if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -ge "$INDEX" ]; then
        error_exit "Opção inválida"
    fi

    SELECTED_WORKTREE="${WORKTREE_ARRAY[$((CHOICE-1))]}"

    echo ""
    warning "Você está prestes a remover: $SELECTED_WORKTREE"
    read -p "$(echo -e ${RED}Confirmar remoção? \(y/n\):${NC} )" CONFIRM

    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        warning "Operação cancelada"
        exit 0
    fi

    echo ""
    info "Removendo worktree..."

    if git worktree remove "$SELECTED_WORKTREE" --force 2>/dev/null; then
        success "Worktree removido com sucesso!"
    else
        error_exit "Falha ao remover worktree"
    fi
}

# Processar comando
OPERATION="$2"

if [ -z "$OPERATION" ]; then
    # Modo interativo - mostrar menu
    while true; do
        show_menu
        read -p "$TXT_CHOOSE_OPTION: " MENU_CHOICE
        echo ""

        case $MENU_CHOICE in
            1)
                create_worktree
                break
                ;;
            2)
                remove_worktree
                break
                ;;
            3)
                list_worktrees
                ;;
            4)
                setup_base_directory
                # Recarregar para menu com novo diretório
                clear
                ;;
            5)
                setup_agent_config
                # Recarregar para menu com novo agente
                clear
                ;;
            6)
                setup_language_config
                # Recarregar para menu com novo idioma
                clear
                ;;
            7)
                info "$TXT_EXITING"
                exit 0
                ;;
            *)
                error_exit "$TXT_INVALID_OPTION"
                ;;
        esac
    done
else
    # Modo direto - executar comando
    case $OPERATION in
        criar|create)
            create_worktree
            ;;
        remover|remove)
            remove_worktree
            ;;
        listar|list)
            list_worktrees
            ;;
        *)
            error_exit "Operação inválida. Use: criar, remover ou listar"
            ;;
    esac
fi
