Write-Host "-----------------------------------"
$txtSecret.Text = "ceci est un secret"
$currentPath = $PSScriptRoot
$basePath = Split-Path -Path $PSScriptRoot
$mainPath = Join-Path $currentPath "\main.ps1"
$secretJSONpath = Join-Path $basePath "\data\secret.json"

$txtSecret.Text | ConvertTo-Json | Set-Content -Encoding utf8 -Path $secretJSONpath
$payload = Get-Content -Raw -Path $secretJSONpath | ConvertFrom-Json
Write-Host $payload