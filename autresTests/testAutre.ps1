Write-Host = "---------------------------------------"

Write-Host $PSScriptRoot
$truc = Split-Path -Path $PSScriptRoot
Write-Host $truc

$dataJSON = Join-Path $truc "\data\data.json"
Write-Host $dataJSON