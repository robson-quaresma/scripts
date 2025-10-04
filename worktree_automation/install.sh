#!/bin/bash

# Worktree Automation - Instalador
# Author: Quaredx
# Description: Script de instalação automática do Worktree Manager

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Diretórios
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SCRIPT="$SCRIPT_DIR/wt.sh"
BIN_DIR="$HOME/bin"
TARGET_SCRIPT="$BIN_DIR/wt"

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
header "🌳 Worktree Automation - Instalador"

# Verificar se o script fonte existe
if [ ! -f "$SOURCE_SCRIPT" ]; then
    error "Script wt.sh não encontrado em $SCRIPT_DIR"
    exit 1
fi

info "Script fonte encontrado: $SOURCE_SCRIPT"
echo ""

# 1. Criar diretório ~/bin se não existir
info "Verificando diretório ~/bin..."
if [ ! -d "$BIN_DIR" ]; then
    mkdir -p "$BIN_DIR"
    success "Diretório ~/bin criado"
else
    success "Diretório ~/bin já existe"
fi
echo ""

# 2. Criar link simbólico
info "Criando link simbólico..."

# Remover link antigo se existir
if [ -L "$TARGET_SCRIPT" ] || [ -f "$TARGET_SCRIPT" ]; then
    warning "Script existente encontrado em $TARGET_SCRIPT"
    read -p "$(echo -e ${YELLOW}Deseja sobrescrever? \(y/n\):${NC} )" OVERWRITE
    if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        error "Instalação cancelada"
        exit 1
    fi
    rm -f "$TARGET_SCRIPT"
    info "Script antigo removido"
fi

ln -s "$SOURCE_SCRIPT" "$TARGET_SCRIPT"
chmod +x "$SOURCE_SCRIPT"
success "Link simbólico criado: $TARGET_SCRIPT -> $SOURCE_SCRIPT"
echo ""

# 3. Configurar shell (zsh)
info "Configurando shell..."
SHELL_CONFIGURED=false

# Detectar shell atual
CURRENT_SHELL=$(basename "$SHELL")

# Configurar .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "# Git Worktree Manager" "$HOME/.zshrc"; then
        cat >> "$HOME/.zshrc" << 'EOF'

# Git Worktree Manager
export PATH="$HOME/bin:$PATH"
alias wt="$HOME/bin/wt"
EOF
        success "Configuração adicionada ao .zshrc"
        SHELL_CONFIGURED=true
    else
        info ".zshrc já está configurado"
        SHELL_CONFIGURED=true
    fi
fi

# Configurar .bashrc ou .bash_profile
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "# Git Worktree Manager" "$HOME/.bashrc"; then
        cat >> "$HOME/.bashrc" << 'EOF'

# Git Worktree Manager
export PATH="$HOME/bin:$PATH"
alias wt="$HOME/bin/wt"
EOF
        success "Configuração adicionada ao .bashrc"
        SHELL_CONFIGURED=true
    else
        info ".bashrc já está configurado"
        SHELL_CONFIGURED=true
    fi
elif [ -f "$HOME/.bash_profile" ]; then
    if ! grep -q "# Git Worktree Manager" "$HOME/.bash_profile"; then
        cat >> "$HOME/.bash_profile" << 'EOF'

# Git Worktree Manager
export PATH="$HOME/bin:$PATH"
alias wt="$HOME/bin/wt"
EOF
        success "Configuração adicionada ao .bash_profile"
        SHELL_CONFIGURED=true
    else
        info ".bash_profile já está configurado"
        SHELL_CONFIGURED=true
    fi
fi

if [ "$SHELL_CONFIGURED" = true ]; then
    echo ""
else
    warning "Nenhum arquivo de configuração de shell encontrado"
    warning "Adicione manualmente ao seu shell config:"
    echo ""
    echo "  export PATH=\"\$HOME/bin:\$PATH\""
    echo "  alias wt=\"\$HOME/bin/wt\""
    echo ""
fi

# 4. Testar instalação
info "Testando instalação..."
if [ -x "$TARGET_SCRIPT" ]; then
    success "Script está executável"
else
    error "Script não está executável"
    exit 1
fi

# 5. Verificar estrutura de diretórios necessária
echo ""
info "Verificando estrutura de diretórios..."

BASE_DIR="$HOME/workspace/projects/quaredx"
if [ ! -d "$BASE_DIR" ]; then
    warning "Diretório base não encontrado: $BASE_DIR"
    warning "Certifique-se de criar esta estrutura antes de usar o script"
else
    success "Estrutura de diretórios encontrada: $BASE_DIR"

    # Listar projetos disponíveis
    PROJECTS=$(ls -1 "$BASE_DIR" 2>/dev/null | while read -r proj; do
        if [ -d "$BASE_DIR/$proj/.git" ]; then
            echo "$proj"
        fi
    done)

    if [ -n "$PROJECTS" ]; then
        echo ""
        success "Projetos Git encontrados:"
        echo "$PROJECTS" | while read -r proj; do
            echo "  • $proj"
        done
    else
        warning "Nenhum projeto Git encontrado em $BASE_DIR"
    fi
fi

# 6. Resumo final
echo ""
header "✨ Instalação Concluída"

success "Script instalado com sucesso!"
echo ""
info "Localização do script: $SOURCE_SCRIPT"
info "Link simbólico: $TARGET_SCRIPT"
info "Alias: wt"
echo ""

if [ "$CURRENT_SHELL" = "zsh" ]; then
    warning "Execute o comando abaixo para ativar o script agora:"
    echo ""
    echo -e "${CYAN}    source ~/.zshrc${NC}"
elif [ "$CURRENT_SHELL" = "bash" ]; then
    warning "Execute o comando abaixo para ativar o script agora:"
    echo ""
    if [ -f "$HOME/.bashrc" ]; then
        echo -e "${CYAN}    source ~/.bashrc${NC}"
    else
        echo -e "${CYAN}    source ~/.bash_profile${NC}"
    fi
else
    warning "Shell não reconhecido: $CURRENT_SHELL"
    warning "Reinicie seu terminal ou adicione manualmente ao PATH"
fi

echo ""
info "Ou simplesmente abra um novo terminal"
echo ""

info "Uso: wt [projeto] [criar|remover|listar]"
info "Exemplo: wt roddi criar"
info "Exemplo: wt (modo interativo)"
echo ""

success "Pronto para usar! 🚀"
echo ""
