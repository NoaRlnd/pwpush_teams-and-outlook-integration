$headers = @{
    'X-User-Email' = 'nrolland@smb-horlogerie.com'
    'X-User-Token' = 'viv7GP2WenCzz7ki9N1GYNeZ'
}

$form = @{
    'password[payload]' = 'jaime bien les sapin'
    'password[note]' = 'si ça marche c le feu'
    'password[expire_after_views]' = 1
    'password[expire_after_duration]' = 1
}

$response = Invoke-RestMethod -Uri 'https://pwpush.com/p.json' -Method Post -Headers $headers -Body $form

$response
# ce que ça m'a renvoyé après le premier push :
# expire_after_duration : 8
# expire_after_views    : 5
# expired               : False
# url_token             : fe1wudjh8sm
# deletable_by_viewer   : True
# retrieval_step        : True
# expired_on            :
# passphrase            :
# created_at            : 2026-04-02T14:25:34.687Z
# updated_at            : 2026-04-02T14:25:34.687Z
# expire_after_days     : 3
# days_remaining        : 3
# views_remaining       : 5
# deleted               : False
# json_url              : https://pwpush.com/p/fe1wudjh8sm/r.json
# html_url              : https://pwpush.com/p/fe1wudjh8sm/r
# account_id            : 36319
# note                  : si Ã§a marche c le feu
# name                  :


# mettre l'url dans une variable pour la réutiliser :
$pushUrl = $response.html_url 


