# $pushUrl = "https://pwpush.com/p/fe1wudjh8sm/r"
# $currentPath = Get-Location
# $JSONdata = Join-Path $currentPath "\data\data.json"

# $contentJSON = Get-Content -Raw -Path $JSONdata | ConvertFrom-Json
# $contentJSON.html_url = $pushUrl
# $contentJSON | ConvertTo-Json | Set-Content -Encoding utf8 -Path $JSONdata

Write-Host "-------------------------------"
# $basePath = Split-Path -Path $PSScriptRoot
# $credentielJSONpath = Join-Path $basePath "\credentiel.json"
$basePath = Get-Location
$credentielJSONpath = Join-Path $basePath "\credentiel.json"

$contentCredJSON = Get-Content -Raw -Path $credentielJSONpath | ConvertFrom-Json
$mail = '"'+$contentCredJSON.mail+'"'
$token = '"'+$contentCredJSON.APItoken+'"'

Write-Host $mail
Write-Host $token