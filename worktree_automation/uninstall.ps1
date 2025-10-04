# Desinstalador Git Worktree Manager - PowerShell (Windows)
# Author: Quaredx

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host " 🗑️  Git Worktree Manager - Desinstalador " -ForegroundColor Blue
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""

$PROFILE_PATH = $PROFILE.CurrentUserAllHosts

# Verificar se o profile existe
if (-not (Test-Path $PROFILE_PATH)) {
    Write-Host "ℹ️  PowerShell Profile não encontrado" -ForegroundColor Cyan
    Write-Host "   Nada para desinstalar" -ForegroundColor Gray
    Write-Host ""
    exit 0
}

Write-Host "📝 Profile encontrado: $PROFILE_PATH" -ForegroundColor Cyan
Write-Host ""

# Criar backup do profile
$backupPath = "$PROFILE_PATH.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
Write-Host "💾 Criando backup do profile..." -ForegroundColor Cyan
Copy-Item -Path $PROFILE_PATH -Destination $backupPath
Write-Host "✅ Backup criado: $backupPath" -ForegroundColor Green
Write-Host ""

# Ler conteúdo do profile
$profileContent = Get-Content $PROFILE_PATH -Raw

# Verificar se existe configuração do wt
if ($profileContent -match '# Git Worktree Manager') {
    Write-Host "🔍 Encontrada configuração do Git Worktree Manager" -ForegroundColor Cyan
    Write-Host ""

    # Remover a seção do Git Worktree Manager
    $newContent = $profileContent -replace '(?ms)# Git Worktree Manager.*?^}', ''

    # Salvar novo conteúdo
    $newContent | Set-Content -Path $PROFILE_PATH

    Write-Host "✅ Configuração removida do PowerShell Profile" -ForegroundColor Green
}
else {
    Write-Host "ℹ️  Nenhuma configuração do Git Worktree Manager encontrada" -ForegroundColor Cyan
}

Write-Host ""

# Perguntar se deseja remover o arquivo de configuração
$CONFIG_FILE = Join-Path $env:USERPROFILE ".wt_config"

if (Test-Path $CONFIG_FILE) {
    Write-Host "📁 Arquivo de configuração encontrado: $CONFIG_FILE" -ForegroundColor Cyan
    $removeConfig = Read-Host "Deseja remover o arquivo de configuração? (s/n)"

    if ($removeConfig -match '^[SsYy]$') {
        Remove-Item -Path $CONFIG_FILE
        Write-Host "✅ Arquivo de configuração removido" -ForegroundColor Green
    }
    else {
        Write-Host "ℹ️  Arquivo de configuração mantido" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host "  ✅ Desinstalação Concluída!            " -ForegroundColor Blue
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""
Write-Host "📌 Informações:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   • Backup do profile: $backupPath" -ForegroundColor White
Write-Host "   • Para restaurar: Copy-Item '$backupPath' -Destination '$PROFILE_PATH' -Force" -ForegroundColor Gray
Write-Host ""
Write-Host "   • Os arquivos do script (wt.ps1) NÃO foram removidos" -ForegroundColor White
Write-Host "   • Você pode removê-los manualmente se desejar" -ForegroundColor Gray
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""

# Perguntar se deseja recarregar o profile
$reload = Read-Host "Deseja recarregar o PowerShell Profile agora? (s/n)"

if ($reload -match '^[SsYy]$') {
    Write-Host ""
    Write-Host "🔄 Recarregando profile..." -ForegroundColor Cyan
    . $PROFILE_PATH
    Write-Host "✅ Profile recarregado!" -ForegroundColor Green
    Write-Host ""
    Write-Host "O comando 'wt' não estará mais disponível" -ForegroundColor Yellow
}
else {
    Write-Host ""
    Write-Host "⚠️  Recarregue o PowerShell para aplicar as mudanças" -ForegroundColor Yellow
    Write-Host "   Comando: . `$PROFILE" -ForegroundColor Gray
    Write-Host "   ou abra um novo terminal PowerShell" -ForegroundColor Gray
}

Write-Host ""
