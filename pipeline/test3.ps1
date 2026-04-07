$basePath = Split-Path -Path $PSScriptRoot
$credentielJSONpath = Join-Path $basePath "\credentiel.json"

$contentCredJSON = Get-Content -Raw -Path $credentielJSONpath | ConvertFrom-Json
$mail = '"'+$contentCredJSON.mail+'"'
$token = '"'+$contentCredJSON.APItoken+'"'

Write-Host $mail
Write-Host $token