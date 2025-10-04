# 🌳 Git Worktree Manager

Script interativo para gerenciar Git worktrees de forma simples e automatizada.

## 📋 Índice

- [Sobre](#sobre)
- [Pré-requisitos](#pré-requisitos)
- [Estrutura de Diretórios](#estrutura-de-diretórios)
- [Instalação](#instalação)
- [Uso](#uso)
- [Desinstalação](#desinstalação)
- [Troubleshooting](#troubleshooting)
- [Replicar em Outros Computadores](#replicar-em-outros-computadores)

## 🎯 Sobre

O **Git Worktree Manager** (`wt`) é uma ferramenta que automatiza a criação e gerenciamento de Git worktrees, permitindo trabalhar em múltiplas branches simultaneamente sem precisar fazer stash ou trocar de branch constantemente.

### Funcionalidades

✅ **Criação Interativa**: Cria worktrees com interface guiada
✅ **Remoção Segura**: Remove worktrees com confirmação
✅ **Listagem**: Visualiza todos worktrees ativos
✅ **Validação Automática**: Garante que está na branch `main` antes de operar
✅ **Nomenclatura Inteligente**: Sanitiza nomes automaticamente
✅ **Integração Claude**: Abre Claude Code automaticamente após criar worktree
✅ **Interface Colorida**: Output visual e intuitivo

## 📦 Pré-requisitos

### Sistema Operacional
- macOS (testado)
- Linux (compatível)

### Softwares Necessários
- Git 2.5+
- Bash 4.0+
- zsh ou bash (shell)

### Estrutura de Diretórios Obrigatória

O script espera a seguinte estrutura de pastas:

```
~/workspace/projects/quaredx/
├── projeto1/              # Repositório Git (branch main)
│   └── .git/
├── projeto2/              # Repositório Git (branch main)
│   └── .git/
└── scripts/
    └── worktree_automation/
        ├── wt.sh          # Script principal
        ├── install.sh     # Instalador
        ├── uninstall.sh   # Desinstalador
        └── README.md      # Este arquivo
```

**IMPORTANTE:**
- A pasta base **DEVE** ser: `~/workspace/projects/quaredx/`
- Cada projeto deve ter um repositório Git válido
- Os worktrees serão criados no mesmo nível dos projetos

**Exemplo após criar worktrees:**
```
~/workspace/projects/quaredx/
├── roddi/                          # Projeto principal (main)
├── feat_roddi_user-auth/           # Worktree: feat/user-auth
├── fix_roddi_login/                # Worktree: fix/login
├── release_roddi_v1.2.0/           # Worktree: release/v1.2.0
└── refactor_roddi_database/        # Worktree: refactor/database
```

## 🚀 Instalação

### Instalação Automática (Recomendado)

1. **Clone ou navegue até o diretório do script:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts/worktree_automation
   ```

2. **Execute o instalador:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **Ative o script (escolha uma opção):**

   **Opção A - Recarregar shell:**
   ```bash
   source ~/.zshrc    # Para zsh
   # ou
   source ~/.bashrc   # Para bash
   ```

   **Opção B - Abrir novo terminal:**
   ```bash
   # Simplesmente abra uma nova janela/aba do terminal
   ```

### O que o Instalador Faz

O script `install.sh` realiza automaticamente:

1. ✅ Cria o diretório `~/bin/` (se não existir)
2. ✅ Cria link simbólico: `~/bin/wt` → `wt.sh`
3. ✅ Adiciona `~/bin` ao PATH
4. ✅ Cria alias `wt` no shell config
5. ✅ Configura `.zshrc`, `.bashrc` ou `.bash_profile`
6. ✅ Valida a instalação
7. ✅ Lista projetos Git disponíveis

### Instalação Manual

Se preferir instalar manualmente:

1. **Criar diretório ~/bin:**
   ```bash
   mkdir -p ~/bin
   ```

2. **Criar link simbólico:**
   ```bash
   ln -s ~/workspace/projects/quaredx/scripts/worktree_automation/wt.sh ~/bin/wt
   chmod +x ~/workspace/projects/quaredx/scripts/worktree_automation/wt.sh
   ```

3. **Adicionar ao shell config (.zshrc ou .bashrc):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   echo 'alias wt="$HOME/bin/wt"' >> ~/.zshrc
   ```

4. **Recarregar shell:**
   ```bash
   source ~/.zshrc
   ```

## 💻 Uso

### Sintaxe

```bash
wt [projeto] [operação]
```

### Modos de Uso

#### 1️⃣ Modo Totalmente Interativo (Recomendado)

```bash
wt
```

O script irá:
1. Listar todos os projetos Git disponíveis (menu numérico)
2. Solicitar que escolha o número do projeto
3. Validar o projeto selecionado
4. Mostrar menu de opções (criar/remover/listar)

**Exemplo:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Projetos disponíveis:

  1) habitofacil
  2) roddi
  3) itm3

Escolha o número do projeto (ou 'q' para sair): 2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ️  Projeto: roddi
ℹ️  Diretório: ~/workspace/projects/quaredx/roddi

✅ Na branch main ✓

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1) Criar novo worktree
  2) Remover worktree existente
  3) Listar worktrees
  4) Sair

Escolha uma opção: _
```

#### 2️⃣ Modo Interativo com Projeto

```bash
wt roddi
```

Especifica o projeto e mostra o menu de operações.

#### 3️⃣ Modo Direto

```bash
# Criar worktree
wt roddi criar

# Remover worktree
wt roddi remover

# Listar worktrees
wt roddi listar
```

### Criar Worktree

1. **Escolha o tipo:**
   - `1` para `feat` (feature)
   - `2` para `fix` (bugfix)
   - `3` para `release`
   - `4` para `refactor`
   - `5` para `Outro (customizado)` - permite digitar qualquer prefixo

2. **Digite o nome:**
   - Exemplo: `user authentication`
   - Será convertido para: `user-authentication`

3. **Confirme a criação**

**Resultado (exemplo com projeto "roddi" e tipo "feat"):**
- Branch criada: `feat/user-authentication`
- Diretório: `~/workspace/projects/quaredx/feat_roddi_user-authentication`
- Navegação automática para o worktree
- Claude Code aberto automaticamente (se instalado)

**Padrão de nomenclatura:**
```
Diretório: {tipo}_{projeto}_{feature-name}
Branch: {tipo}/{feature-name}
```

**Exemplos:**
| Projeto | Tipo | Feature | Branch | Diretório |
|---------|------|---------|--------|-----------|
| roddi | feat | user-auth | `feat/user-auth` | `feat_roddi_user-auth/` |
| roddi | fix | login-bug | `fix/login-bug` | `fix_roddi_login-bug/` |
| roddi | release | v1.2.0 | `release/v1.2.0` | `release_roddi_v1.2.0/` |
| roddi | refactor | database | `refactor/database` | `refactor_roddi_database/` |
| roddi | chore | cleanup | `chore/cleanup` | `chore_roddi_cleanup/` |

### Remover Worktree

1. Lista todos os worktrees existentes (exceto main)
2. Escolha o número do worktree para remover
3. Confirme a remoção

**Segurança:**
- Solicita confirmação antes de remover
- Remove com `--force` para garantir limpeza completa

### Listar Worktrees

Exibe todos os worktrees ativos com:
- Caminho completo
- Branch associada
- Commit atual

## 🗑️ Desinstalação

### Desinstalação Automática

```bash
cd ~/workspace/projects/quaredx/scripts/worktree_automation
./uninstall.sh
```

### O que o Desinstalador Faz

1. ✅ Remove link simbólico `~/bin/wt`
2. ✅ Remove configurações do `.zshrc`
3. ✅ Remove configurações do `.bashrc` ou `.bash_profile`
4. ✅ Cria backups antes de modificar arquivos de configuração
5. ✅ Opcionalmente remove `~/bin/` se estiver vazio

**IMPORTANTE:** O código fonte em `scripts/worktree_automation/` **NÃO** é removido.

### Desinstalação Manual

```bash
# Remover link simbólico
rm ~/bin/wt

# Remover configurações manualmente do .zshrc ou .bashrc
# (Procure por "# Git Worktree Manager" e remova as 3 linhas)

# Recarregar shell
source ~/.zshrc
```

## 🔧 Troubleshooting

### Comando `wt` não encontrado

**Causa:** PATH não atualizado ou shell não recarregado

**Solução:**
```bash
# Recarregar shell
source ~/.zshrc  # ou source ~/.bashrc

# Ou abrir novo terminal
```

### Projeto não encontrado

**Causa:** Estrutura de diretórios incorreta

**Solução:**
1. Verificar se o projeto está em: `~/workspace/projects/quaredx/`
2. Verificar se o diretório contém `.git/`
3. Executar `wt` sem argumentos para ver projetos disponíveis

### Branch main não encontrada

**Causa:** Repositório usa `master` ou outra branch padrão

**Solução:**
Edite o script `wt.sh` linha ~80:
```bash
# De:
if [ "$CURRENT_BRANCH" != "main" ]; then

# Para:
if [ "$CURRENT_BRANCH" != "master" ]; then
```

### Claude Code não abre automaticamente

**Causa:** Claude Code não instalado ou não está no PATH

**Solução:**
- Script funciona normalmente, apenas não abre Claude
- Navegue manualmente e abra: `cd ../feature-name && claude`
- Ou desabilite no script (linha ~145): comente o bloco `if command -v claude`

### Worktree já existe

**Causa:** Tentando criar worktree com nome/branch que já existe

**Solução:**
1. Liste worktrees existentes: `wt roddi listar`
2. Remova o worktree antigo: `wt roddi remover`
3. Ou escolha outro nome

### Permissão negada ao executar scripts

**Causa:** Scripts sem permissão de execução

**Solução:**
```bash
chmod +x ~/workspace/projects/quaredx/scripts/worktree_automation/*.sh
```

### Link simbólico quebrado

**Causa:** Arquivo `wt.sh` foi movido ou removido

**Solução:**
```bash
# Reinstalar
cd ~/workspace/projects/quaredx/scripts/worktree_automation
./install.sh
```

## 🔄 Replicar em Outros Computadores

### Requisitos em Novo Computador

1. **Estrutura de diretórios:**
   ```bash
   mkdir -p ~/workspace/projects/quaredx/scripts
   ```

2. **Git instalado:**
   ```bash
   git --version
   ```

3. **Shell config (zsh ou bash):**
   ```bash
   echo $SHELL
   ```

### Passo a Passo para Replicação

#### Opção 1: Via Git (Recomendado)

```bash
# 1. Clone ou sincronize o repositório
cd ~/workspace/projects/quaredx
git clone <repo-url> scripts
# ou
git pull  # se já estiver clonado

# 2. Navegue para a pasta do script
cd scripts/worktree_automation

# 3. Execute o instalador
chmod +x install.sh
./install.sh

# 4. Recarregue o shell
source ~/.zshrc  # ou source ~/.bashrc

# 5. Teste
wt
```

#### Opção 2: Cópia Manual

```bash
# 1. Criar estrutura
mkdir -p ~/workspace/projects/quaredx/scripts/worktree_automation

# 2. Copiar arquivos
# (Use scp, rsync, cloud sync, etc.)
scp user@old-machine:~/workspace/projects/quaredx/scripts/worktree_automation/* \
    ~/workspace/projects/quaredx/scripts/worktree_automation/

# 3. Executar instalador
cd ~/workspace/projects/quaredx/scripts/worktree_automation
chmod +x *.sh
./install.sh

# 4. Recarregar shell
source ~/.zshrc

# 5. Teste
wt
```

### Checklist de Replicação

- [ ] Estrutura de diretórios criada: `~/workspace/projects/quaredx/`
- [ ] Scripts copiados para: `~/workspace/projects/quaredx/scripts/worktree_automation/`
- [ ] Instalador executado: `./install.sh`
- [ ] Shell recarregado: `source ~/.zshrc`
- [ ] Comando testado: `wt`
- [ ] Projetos Git clonados na estrutura correta

### Sincronização Contínua

Para manter o script atualizado em múltiplos computadores:

1. **Versione o script com Git:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts
   git init
   git add worktree_automation/
   git commit -m "Add worktree automation"
   git remote add origin <repo-url>
   git push -u origin main
   ```

2. **Em outros computadores:**
   ```bash
   cd ~/workspace/projects/quaredx/scripts
   git pull
   ```

3. **Reinstale se houver mudanças:**
   ```bash
   cd worktree_automation
   ./install.sh
   ```

## 📝 Estrutura de Arquivos

```
worktree_automation/
├── README.md              # Este arquivo - Documentação completa
├── wt.sh                  # Script principal - Código fonte
├── install.sh             # Instalador automático
└── uninstall.sh          # Desinstalador automático
```

### Descrição dos Arquivos

- **`wt.sh`**: Código fonte principal do Worktree Manager
- **`install.sh`**: Script de instalação automática (cria links, configura PATH, etc.)
- **`uninstall.sh`**: Script de desinstalação limpa (remove links e configurações)
- **`README.md`**: Documentação completa (este arquivo)

## 🎨 Interface

O script possui interface colorida para facilitar visualização:

- 🔴 **Vermelho**: Erros
- 🟢 **Verde**: Sucesso
- 🟡 **Amarelo**: Avisos
- 🔵 **Azul**: Títulos e menus
- 🔵 **Cyan**: Informações

## 📄 Licença

Este script foi desenvolvido para uso interno do projeto Quaredx.

## 👤 Autor

**Quaredx**

---

**Versão:** 1.0.0
**Última atualização:** 2025-10-04
