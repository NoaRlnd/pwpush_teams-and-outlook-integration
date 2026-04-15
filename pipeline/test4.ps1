$basePath = Split-Path -Path $PSScriptRoot
$credentielJSONpath = Join-Path $basePath "\credentiel.json"
$canWorkJSONpath = Join-Path $basePath "\ready.json"
$contentJSONcred = Get-Content -Raw -Path $credentielJSONpath | ConvertFrom-Json
$test = $contentJSONcred.APItoken
$canWork = Get-Content -Raw -Path $canWorkJSONpath | ConvertFrom-Json

if ($canWork.boot -eq $false) {
    Write-Host "valid"
}
else {
    Write-Host "not valisd"
}