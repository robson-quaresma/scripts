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

# Diretório base dos projetos
BASE_DIR=~/workspace/projects/quaredx

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
    echo "  4) Sair"
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
        clear
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}    🌳 Git Worktree Manager${NC}"
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""

        list_available_projects

        read -p "$(echo -e ${CYAN}Digite o nome do projeto \(ou \'q\' para sair\):${NC} )" PROJECT_INPUT

        # Verificar se quer sair
        if [[ "$PROJECT_INPUT" == "q" ]] || [[ "$PROJECT_INPUT" == "sair" ]] || [[ "$PROJECT_INPUT" == "exit" ]]; then
            clear
            info "Saindo..."
            exit 0
        fi

        # Verificar se entrada está vazia
        if [ -z "$PROJECT_INPUT" ]; then
            echo ""
            warning "Nome do projeto não pode ser vazio"
            echo ""
            sleep 1
            continue
        fi

        # Verificar se o diretório existe
        if [ ! -d "$BASE_DIR/$PROJECT_INPUT" ]; then
            echo ""
            echo -e "${RED}❌ Projeto '$PROJECT_INPUT' não encontrado em $BASE_DIR${NC}"
            echo ""
            sleep 2
            continue
        fi

        # Verificar se é um repositório Git
        if [ ! -d "$BASE_DIR/$PROJECT_INPUT/.git" ]; then
            echo ""
            echo -e "${RED}❌ '$PROJECT_INPUT' não é um repositório Git válido${NC}"
            echo ""
            sleep 2
            continue
        fi

        # Projeto válido encontrado - retornar apenas o nome
        clear
        echo "$PROJECT_INPUT"
        break
    done
}

# Verificar argumentos
if [ -z "$1" ]; then
    # Modo interativo - solicitar nome do projeto
    PROJECT_NAME=$(get_project_name)
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

# Verificar se está na branch main
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    warning "Você está na branch '$CURRENT_BRANCH'"
    echo -e "${YELLOW}Trocando para branch 'main'...${NC}"
    git checkout main || error_exit "Não foi possível trocar para branch main"
    echo ""
fi

success "Na branch main ✓"
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
    echo ""
    read -p "Escolha (1 ou 2): " TYPE_CHOICE

    case $TYPE_CHOICE in
        1)
            BRANCH_TYPE="feat"
            ;;
        2)
            BRANCH_TYPE="fix"
            ;;
        *)
            error_exit "Opção inválida"
            ;;
    esac

    echo ""

    # Solicitar nome da feature
    read -p "$(echo -e ${CYAN}Nome da feature/fix:${NC} )" FEATURE_NAME

    if [ -z "$FEATURE_NAME" ]; then
        error_exit "Nome não pode ser vazio"
    fi

    # Validar nome (remover espaços e caracteres especiais)
    FEATURE_NAME=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

    BRANCH_NAME="${BRANCH_TYPE}/${FEATURE_NAME}"
    WORKTREE_DIR="../${FEATURE_NAME}"

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
