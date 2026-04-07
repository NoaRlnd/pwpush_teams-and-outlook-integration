Write-Host "--------------------------------------------"
$currentPath = Get-Location
$compteurJsonPath = Join-Path $currentPath "\data\compteur.json"
Write-Host $compteurJsonPath

$compteur = Get-Content -Raw -Path $compteurJsonPath | ConvertFrom-Json
Write-Host $compteur.compteur