Write-Host "--------------------------------------------"
$currentPath = $PSScriptRoot
Write-Host $currentPath
$pushPath = Join-Path $currentPath "\push.ps1"
Write-Host $pushPath