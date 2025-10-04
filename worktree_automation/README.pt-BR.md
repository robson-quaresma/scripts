# 🌳 Git Worktree Manager

> **Language / Idioma / Idioma:** [🇺🇸 English](README.md) | [🇧🇷 Português](README.pt-BR.md) | [🇪🇸 Español](README.es.md)

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
✅ **Configuração Flexível**: Configure diretório de trabalho e agente IA
✅ **Suporte Multi-Agente**: Claude, Cursor, Gemini, Copilot, Windsurf e mais
✅ **Multi-idioma**: Suporte para Inglês, Português (BR) e Espanhol
✅ **Interface Colorida**: Output visual e intuitivo

## 📦 Pré-requisitos

### Sistema Operacional
- macOS (testado)
- Linux (compatível)

### Softwares Necessários
- Git 2.5+
- Bash 4.0+
- zsh ou bash (shell)

### Configuração Inicial

Na primeira execução, o script solicitará que você configure o **diretório de trabalho** onde seus projetos Git estão localizados.

**Estrutura recomendada:**

```
~/projects/                         # Seu diretório de projetos
├── projeto1/                       # Repositório Git (branch main)
│   └── .git/
├── projeto2/                       # Repositório Git (branch main)
│   └── .git/
└── projeto3/                       # Repositório Git (branch main)
    └── .git/
```

**IMPORTANTE:**
- O diretório pode ser qualquer pasta que contenha seus projetos Git
- Cada projeto deve ter um repositório Git válido
- Os worktrees serão criados no mesmo nível dos projetos
- A configuração é salva em `~/.wt_config` e pode ser alterada a qualquer momento

**Exemplo após criar worktrees:**
```
~/projects/
├── myapp/                          # Projeto principal (main)
├── feat_myapp_user-auth/           # Worktree: feat/user-auth
├── fix_myapp_login/                # Worktree: fix/login
├── release_myapp_v1.2.0/           # Worktree: release/v1.2.0
└── refactor_myapp_database/        # Worktree: refactor/database
```

## 🚀 Instalação

### Instalação Automática (Recomendado)

1. **Clone ou navegue até o diretório do script:**
   ```bash
   cd /path/to/worktree_automation
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

4. **Configure o diretório de trabalho:**

   Na primeira execução do comando `wt`, você será solicitado a configurar o diretório onde seus projetos Git estão localizados.

   ```bash
   wt
   # Digite o caminho completo (use Tab para autocomplete)
   # Exemplo: ~/projects  ou  ~/workspace/repos
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
   ln -s /path/to/worktree_automation/wt.sh ~/bin/wt
   chmod +x /path/to/worktree_automation/wt.sh
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

5. **Configure o diretório de trabalho:**
   ```bash
   wt
   # Na primeira execução, configure seu diretório de projetos
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

  1) project-a
  2) myapp
  3) website

Escolha o número do projeto (ou 'q' para sair): 2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ️  Projeto: myapp
ℹ️  Diretório: ~/projects/myapp

✅ Na branch main ✓

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🌳 Git Worktree Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1) Criar novo worktree
  2) Remover worktree existente
  3) Listar worktrees
  4) Configurar diretório de trabalho
  5) Configurar agente IA
  6) Alterar idioma
  7) Sair

📂 Diretório atual: ~/projects
🤖 Agente: claude (fixo)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Escolha uma opção: _
```

#### 2️⃣ Modo Interativo com Projeto

```bash
wt myapp
```

Especifica o projeto e mostra o menu de operações.

#### 3️⃣ Modo Direto

```bash
# Criar worktree
wt myapp criar

# Remover worktree
wt myapp remover

# Listar worktrees
wt myapp listar
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

**Resultado (exemplo com projeto "myapp" e tipo "feat"):**
- Branch criada: `feat/user-authentication`
- Diretório: `~/projects/feat_myapp_user-authentication`
- Navegação automática para o worktree
- Agente IA aberto automaticamente (se configurado)

**Padrão de nomenclatura:**
```
Diretório: {tipo}_{projeto}_{feature-name}
Branch: {tipo}/{feature-name}
```

**Exemplos:**
| Projeto | Tipo | Feature | Branch | Diretório |
|---------|------|---------|--------|-----------|
| myapp | feat | user-auth | `feat/user-auth` | `feat_myapp_user-auth/` |
| myapp | fix | login-bug | `fix/login-bug` | `fix_myapp_login-bug/` |
| myapp | release | v1.2.0 | `release/v1.2.0` | `release_myapp_v1.2.0/` |
| myapp | refactor | database | `refactor/database` | `refactor_myapp_database/` |
| myapp | chore | cleanup | `chore/cleanup` | `chore_myapp_cleanup/` |

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

## ⚙️ Configuração do Diretório de Trabalho

### Primeira Configuração

Na primeira execução do comando `wt`, você será solicitado a configurar o diretório base onde seus projetos Git estão localizados:

```bash
$ wt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ⚙️  Configurar Diretório de Trabalho
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Digite o caminho do diretório onde seus projetos Git estão localizados:
(Use Tab para autocomplete de caminhos)

Diretório: ~/projects

✅ Configuração salva em ~/.wt_config
✅ Diretório configurado com sucesso!

ℹ️  Projetos Git encontrados: 3
```

### Reconfigurar Diretório

Para alterar o diretório de trabalho a qualquer momento:

1. Execute `wt` (sem argumentos)
2. Escolha opção `4) Configurar diretório de trabalho`
3. Digite o novo caminho (use Tab para autocomplete)
4. Confirme a mudança

### Arquivo de Configuração

A configuração é salva em `~/.wt_config`:

```bash
# Ver configuração atual
cat ~/.wt_config

# Resetar configuração (será solicitado novo diretório na próxima execução)
rm ~/.wt_config
```

## 🤖 Configuração do Agente IA

### Agentes Suportados

O script suporta abertura automática de diversos agentes IA após criar um worktree:

- **Claude Code** (`claude`)
- **Cursor** (`cursor`)
- **Gemini** (`gemini`)
- **GitHub Copilot** (`code`)
- **Windsurf** (`windsurf`)
- **Nenhum** (não abrir agente automaticamente)
- **Outro** (customizado - informe o comando)

### Primeira Configuração

Na primeira execução (após configurar o diretório de trabalho), você será solicitado a configurar o agente IA:

```bash
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🤖 Configurar Agente IA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Selecione o agente IA que você utiliza:

  1) Claude Code
  2) Cursor
  3) Gemini
  4) GitHub Copilot (codex)
  5) Windsurf
  6) Nenhum (não abrir agente automaticamente)
  7) Outro (customizado)

Escolha (1-7): 1

Como deseja usar o agente?

  1) Sempre usar claude (configuração fixa)
  2) Perguntar qual agente usar a cada worktree criado

Escolha (1-2): 1

✅ Agente configurado com sucesso!

ℹ️  Modo: Sempre usar claude
```

### Modos de Uso

#### Modo Fixo (Padrão)

O agente configurado será aberto automaticamente sempre que criar um worktree.

**Vantagem:** Mais rápido, não precisa escolher toda vez.

#### Modo Dinâmico (Perguntar a cada vez)

Ao criar um worktree, você será perguntado qual agente abrir.

**Vantagem:** Flexibilidade para alternar entre agentes conforme necessidade.

### Reconfigurar Agente

Para alterar o agente ou modo a qualquer momento:

1. Execute `wt` (sem argumentos)
2. Escolha opção `5) Configurar agente IA`
3. Selecione o novo agente
4. Escolha o modo (fixo ou perguntar)

### Exemplo de Uso

**Modo Fixo:**
```bash
$ wt myapp criar
# ... criação do worktree ...
ℹ️  Iniciando claude...
# Claude abre automaticamente ✅
```

**Modo Dinâmico:**
```bash
$ wt myapp criar
# ... criação do worktree ...

Qual agente deseja abrir?

  1) Claude Code
  2) Cursor
  3) Gemini
  4) GitHub Copilot (code)
  5) Windsurf
  6) Nenhum
  7) Outro

Escolha (1-7): 2

ℹ️  Iniciando cursor...
# Cursor abre ✅
```

### Arquivo de Configuração

A configuração do agente é salva em `~/.wt_config`:

```bash
BASE_DIR="/Users/{user}/projects"
AGENT="claude:claude"
ASK_AGENT_EVERY_TIME="false"
LANGUAGE="pt-BR"
```

**Formato:** `AGENT="nome:comando"`

## 🌐 Configuração de Idioma

O script suporta três idiomas:
- **English** (inglês)
- **Português (Brasil)** (padrão)
- **Español** (espanhol)

### Alterar Idioma

1. Execute `wt` (sem argumentos)
2. Escolha opção `6) Alterar idioma`
3. Selecione seu idioma preferido
4. A interface será atualizada imediatamente

A preferência de idioma é salva em `~/.wt_config` e persiste entre sessões.

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

**Causa:** Diretório de trabalho não configurado ou projeto não existe

**Solução:**
1. Configurar/reconfigurar o diretório de trabalho: `wt` → opção 4
2. Verificar se o projeto contém `.git/`
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

### Agente IA não abre automaticamente

**Causa:** Agente não instalado ou não está no PATH

**Solução:**
- Script funciona normalmente, apenas não abre o agente
- Navegue manualmente e abra: `cd ../feature-name && claude`
- Ou reconfigure o agente: `wt` → opção 5

### Worktree já existe

**Causa:** Tentando criar worktree com nome/branch que já existe

**Solução:**
1. Liste worktrees existentes: `wt myapp listar`
2. Remova o worktree antigo: `wt myapp remover`
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
├── README.md              # Documentação completa em Inglês
├── README.pt-BR.md        # Este arquivo - Documentação em Português
├── README.es.md           # Documentação em Espanhol
├── wt.sh                  # Script principal - Código fonte
├── install.sh             # Instalador automático
└── uninstall.sh          # Desinstalador automático
```

### Descrição dos Arquivos

- **`wt.sh`**: Código fonte principal do Worktree Manager
- **`install.sh`**: Script de instalação automática (cria links, configura PATH, etc.)
- **`uninstall.sh`**: Script de desinstalação limpa (remove links e configurações)
- **`README.md`**: Documentação completa em Inglês
- **`README.pt-BR.md`**: Documentação completa em Português (este arquivo)
- **`README.es.md`**: Documentação completa em Espanhol

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

**Versão:** 2.0.0
**Última atualização:** 2025-10-04

> **Language / Idioma / Idioma:** [🇺🇸 English](README.md) | [🇧🇷 Português](README.pt-BR.md) | [🇪🇸 Español](README.es.md)
