$compteurJsonPath = Join-Path $basePath "\data\compteur.json"
$compteur = Get-Content -Raw -Path $compteurJsonPath | ConvertFrom-Json

if ($compteur.compteur = "False") {
    Write-Host "fonctionnel"
}
else {
    Write-Host "non-fonctionnel"
}