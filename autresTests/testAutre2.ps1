
Get-ChildItem -Path .\autresTests\*.ps1 | ForEach-Object {
    $filePath = $_.FullName
    Write-Host "Contenu de $filePath :"
    Get-Content -Path $filePath
    Write-Host "-----------------------------"
}