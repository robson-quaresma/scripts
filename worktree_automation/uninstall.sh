#!/bin/bash

# Worktree Automation - Desinstalador
# Author: Quaredx
# Description: Remove completamente o Worktree Manager do sistema

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Diretórios
TARGET_SCRIPT="$HOME/bin/wt"

# Funções de output
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}    $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Banner
clear
header "🗑️  Worktree Automation - Desinstalador"

warning "Este script irá remover:"
echo "  • Link simbólico: ~/bin/wt"
echo "  • Configurações do .zshrc"
echo "  • Configurações do .bashrc ou .bash_profile"
echo "  • Alias 'wt'"
echo ""
warning "O código fonte em scripts/worktree_automation/ NÃO será removido"
echo ""

read -p "$(echo -e ${RED}Deseja continuar? \(y/n\):${NC} )" CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    info "Desinstalação cancelada"
    exit 0
fi

echo ""
info "Iniciando desinstalação..."
echo ""

# 1. Remover link simbólico
if [ -L "$TARGET_SCRIPT" ] || [ -f "$TARGET_SCRIPT" ]; then
    rm -f "$TARGET_SCRIPT"
    success "Link simbólico removido: $TARGET_SCRIPT"
else
    info "Link simbólico não encontrado (já removido ou nunca instalado)"
fi

# 2. Remover configurações do .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if grep -q "# Git Worktree Manager" "$HOME/.zshrc"; then
        # Criar backup
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

        # Remover linhas relacionadas
        sed -i.tmp '/# Git Worktree Manager/,/alias wt=/d' "$HOME/.zshrc"
        rm -f "$HOME/.zshrc.tmp"

        success "Configurações removidas do .zshrc"
        info "Backup criado: ~/.zshrc.backup.*"
    else
        info "Nenhuma configuração encontrada no .zshrc"
    fi
fi

# 3. Remover configurações do .bashrc
if [ -f "$HOME/.bashrc" ]; then
    if grep -q "# Git Worktree Manager" "$HOME/.bashrc"; then
        # Criar backup
        cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"

        # Remover linhas relacionadas
        sed -i.tmp '/# Git Worktree Manager/,/alias wt=/d' "$HOME/.bashrc"
        rm -f "$HOME/.bashrc.tmp"

        success "Configurações removidas do .bashrc"
        info "Backup criado: ~/.bashrc.backup.*"
    else
        info "Nenhuma configuração encontrada no .bashrc"
    fi
fi

# 4. Remover configurações do .bash_profile
if [ -f "$HOME/.bash_profile" ]; then
    if grep -q "# Git Worktree Manager" "$HOME/.bash_profile"; then
        # Criar backup
        cp "$HOME/.bash_profile" "$HOME/.bash_profile.backup.$(date +%Y%m%d_%H%M%S)"

        # Remover linhas relacionadas
        sed -i.tmp '/# Git Worktree Manager/,/alias wt=/d' "$HOME/.bash_profile"
        rm -f "$HOME/.bash_profile.tmp"

        success "Configurações removidas do .bash_profile"
        info "Backup criado: ~/.bash_profile.backup.*"
    else
        info "Nenhuma configuração encontrada no .bash_profile"
    fi
fi

# 5. Verificar se ~/bin está vazio
if [ -d "$HOME/bin" ]; then
    if [ -z "$(ls -A $HOME/bin)" ]; then
        read -p "$(echo -e ${YELLOW}Diretório ~/bin está vazio. Deseja removê-lo? \(y/n\):${NC} )" REMOVE_BIN
        if [[ "$REMOVE_BIN" =~ ^[Yy]$ ]]; then
            rmdir "$HOME/bin"
            success "Diretório ~/bin removido"
        fi
    fi
fi

# 6. Resumo final
echo ""
header "✨ Desinstalação Concluída"

success "Worktree Manager removido com sucesso!"
echo ""

info "Próximos passos:"
echo "  1. Recarregue seu shell: source ~/.zshrc (ou ~/.bashrc)"
echo "  2. Ou abra um novo terminal"
echo ""

warning "O código fonte permanece em:"
echo "  ~/workspace/projects/quaredx/scripts/worktree_automation/"
echo ""
info "Para reinstalar, execute: ./install.sh"
echo ""

success "Concluído! 👋"
echo ""
