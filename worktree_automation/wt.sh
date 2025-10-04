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

# Função para carregar configuração
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        if [ -z "$BASE_DIR" ]; then
            return 1
        fi
        return 0
    else
        return 1
    fi
}

# Função para salvar configuração
save_config() {
    local dir="$1"
    echo "BASE_DIR=\"$dir\"" > "$CONFIG_FILE"
    success "Configuração salva em $CONFIG_FILE"
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

# Carregar configuração ou solicitar setup inicial
if ! load_config; then
    setup_base_directory
    if [ -z "$BASE_DIR" ]; then
        error_exit "Configuração inicial necessária"
    fi
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
    echo -e "${BLUE}    🌳 Git Worktree Manager${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "  1) Criar novo worktree"
    echo "  2) Remover worktree existente"
    echo "  3) Listar worktrees"
    echo "  4) Configurar diretório de trabalho"
    echo "  5) Sair"
    echo ""
    echo -e "${CYAN}📂 Diretório atual: $BASE_DIR${NC}"
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

        # Verificar se claude está disponível
        if command -v claude &> /dev/null; then
            info "Iniciando Claude Code..."
            echo ""
            claude
        else
            warning "Claude Code não encontrado. Inicie manualmente se necessário."
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
        read -p "Escolha uma opção: " MENU_CHOICE
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
                info "Saindo..."
                exit 0
                ;;
            *)
                error_exit "Opção inválida"
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
