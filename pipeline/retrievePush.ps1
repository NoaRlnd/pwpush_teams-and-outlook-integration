$pushId = $lePushID
$response = Invoke-RestMethod -Uri "https://pwpush.com/p/$pushId.json" -Method Get