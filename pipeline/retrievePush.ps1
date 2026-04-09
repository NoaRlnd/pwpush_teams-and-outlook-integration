$pushId = "ythk7uhwvdcbouqqoe4"
#ajoute le passphrase "fresh" dans la query du dessous
$response = Invoke-RestMethod -Uri "https://pwpush.com/p/$pushId.json?passphrase=fresh" -Method Get
$response | ConvertTo-Json | Set-Content -Encoding utf8 -Path $dataJSONpath