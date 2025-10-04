# Instalador Git Worktree Manager - PowerShell (Windows)
# Author: Quaredx

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host "  🌳 Git Worktree Manager - Instalador  " -ForegroundColor Blue
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""

# Verificar se está executando como administrador (opcional, mas recomendado)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "⚠️  Aviso: Não está executando como Administrador" -ForegroundColor Yellow
    Write-Host "   Algumas funcionalidades podem não funcionar corretamente" -ForegroundColor Yellow
    Write-Host ""
}

# Obter diretório do script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$SCRIPT_PATH = Join-Path $SCRIPT_DIR "wt.ps1"

# Verificar se wt.ps1 existe
if (-not (Test-Path $SCRIPT_PATH)) {
    Write-Host "❌ Erro: wt.ps1 não encontrado em $SCRIPT_DIR" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Script encontrado: $SCRIPT_PATH" -ForegroundColor Green
Write-Host ""

# Criar alias/função no PowerShell profile
$PROFILE_PATH = $PROFILE.CurrentUserAllHosts

Write-Host "📝 Configurando PowerShell Profile..." -ForegroundColor Cyan
Write-Host "   Profile: $PROFILE_PATH" -ForegroundColor Gray
Write-Host ""

# Criar diretório do profile se não existir
$profileDir = Split-Path -Parent $PROFILE_PATH
if (-not (Test-Path $profileDir)) {
    Write-Host "   Criando diretório do profile..." -ForegroundColor Gray
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Criar ou atualizar profile
if (-not (Test-Path $PROFILE_PATH)) {
    Write-Host "   Criando novo profile..." -ForegroundColor Gray
    New-Item -ItemType File -Path $PROFILE_PATH -Force | Out-Null
}

# Verificar se já existe configuração do wt
$profileContent = Get-Content $PROFILE_PATH -Raw -ErrorAction SilentlyContinue

if ($profileContent -notmatch '# Git Worktree Manager') {
    # Adicionar função wt ao profile
    $wtFunction = @"

# Git Worktree Manager
function wt {
    & "$SCRIPT_PATH" `$args
}

"@

    Add-Content -Path $PROFILE_PATH -Value $wtFunction
    Write-Host "✅ Função 'wt' adicionada ao PowerShell Profile" -ForegroundColor Green
}
else {
    Write-Host "ℹ️  Função 'wt' já existe no profile" -ForegroundColor Cyan
}

Write-Host ""

# Verificar se Git está instalado
Write-Host "🔍 Verificando Git..." -ForegroundColor Cyan

if (Get-Command git -ErrorAction SilentlyContinue) {
    $gitVersion = git --version
    Write-Host "✅ Git instalado: $gitVersion" -ForegroundColor Green
}
else {
    Write-Host "❌ Git não encontrado!" -ForegroundColor Red
    Write-Host "   Instale o Git em: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host "  ✅ Instalação Concluída!               " -ForegroundColor Blue
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""
Write-Host "📌 Próximos passos:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   1) Recarregue o PowerShell:" -ForegroundColor White
Write-Host "      . `$PROFILE" -ForegroundColor Gray
Write-Host ""
Write-Host "      ou abra um novo terminal PowerShell" -ForegroundColor Gray
Write-Host ""
Write-Host "   2) Execute o comando:" -ForegroundColor White
Write-Host "      wt" -ForegroundColor Gray
Write-Host ""
Write-Host "   3) Configure o diretório de projetos na primeira execução" -ForegroundColor White
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""

# Perguntar se deseja recarregar o profile agora
$reload = Read-Host "Deseja recarregar o PowerShell Profile agora? (s/n)"

if ($reload -match '^[SsYy]$') {
    Write-Host ""
    Write-Host "🔄 Recarregando profile..." -ForegroundColor Cyan
    . $PROFILE_PATH
    Write-Host "✅ Profile recarregado!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Você já pode usar o comando 'wt'" -ForegroundColor Green
}
else {
    Write-Host ""
    Write-Host "⚠️  Lembre-se de recarregar o PowerShell antes de usar 'wt'" -ForegroundColor Yellow
    Write-Host "   Comando: . `$PROFILE" -ForegroundColor Gray
}

Write-Host ""
