$vuesMax = 1
$joursMax = 1

$basePath = Split-Path -Path $PSScriptRoot
$credentielJSONpath = Join-Path $basePath "\credentiel.json"

$contentCredJSON = Get-Content -Raw -Path $credentielJSONpath | ConvertFrom-Json
$mail = $contentCredJSON.mail
$token = $contentCredJSON.APItoken


$headers = @{
    'X-User-Email' = $mail
    'X-User-Token' = $token
}

$body = @{
    'password[payload]' = 'jaime bien les sapin'
    'password[note]' = 'si ça marche c le feu'
    'password[expire_after_views]' = $vuesMax
    'password[expire_after_days]' = $joursMax
}

$response = Invoke-RestMethod -Uri 'https://pwpush.com/p.json' -Method Post -Headers $headers -Body $body
$response | ConvertTo-Json | Set-Content -Encoding utf8 -Path $dataJSONpath