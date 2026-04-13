$currentPath = $PSScriptRoot
$basePath = Split-Path -Path $PSScriptRoot
$dataJSONpath = Join-Path $basePath "\backup\backupdata.json"
$tbVues = 3
$tbJours = 4
$txtPassphrase.Text = "test en cours"

$contentJSON = Get-Content -Raw -Path $dataJSONpath | ConvertFrom-Json
$contentJSON.expire_after_views = $tbVues.Value
$contentJSON.expire_after_days = $tbJours.Value
if ($txtPassphrase.Text = "") {
    $contentJSON.passphrase = $null
}
else {
    $contentJSON.passphrase = $txtPassphrase.Text
}
$contentJSON | ConvertTo-Json | Set-Content -Encoding utf8 -Path $dataJSONpath