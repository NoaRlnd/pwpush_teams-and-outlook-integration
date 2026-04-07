#spaghetti code incoming, désolé :)
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$currentPath = $PSScriptRoot
$basePath = Split-Path -Path $PSScriptRoot
$dataJSONpath = Join-Path $basePath "\data\data.json"
$testDataJSONpath = Join-Path $basePath "\data\testdata.json"
$secretJSONpath = Join-Path $basePath "\data\secret.json"
$visuelsPath = Join-Path $basePath "\visuels"
$visuelsBGpath = Join-Path $visuelsPath "\arriere_plan_main.png"
$visuelsCHMKpath = Join-Path $visuelsPath "\checkmark.png"
$pushPath = Join-Path $currentPath "\push.ps1"
$compteurJsonPath = Join-Path $basePath "\data\compteur.json"


$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false
$Form.Text = "PWPush GUI"
$Form.Size = New-Object System.Drawing.Size(500, 460)
$Form.StartPosition = "CenterScreen"
$Form.BackgroundImage = [System.Drawing.Image]::FromFile($visuelsBGpath)

# truc de timer, absolument ignoble à comprendre, mais mieux que start-sleep pour pas bloquer l'UI
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 60000  # 60 secondes

# label Secret
$lblSecret = New-Object System.Windows.Forms.Label
$lblSecret.Text = "Secret à envoyer :"
$lblSecret.Location = New-Object System.Drawing.Point(10,20)
$lblSecret.Size = New-Object System.Drawing.Size(150,20)
$Form.Controls.Add($lblSecret)

# textbox Secret
$txtSecret = New-Object System.Windows.Forms.TextBox
$txtSecret.Location = New-Object System.Drawing.Point(10,50)
$txtSecret.Size = New-Object System.Drawing.Size(450,20)
$Form.Controls.Add($txtSecret)

# checkbox Teams
$chkTeams = New-Object System.Windows.Forms.CheckBox
$chkTeams.Text = "Envoyer sur Teams"
$chkTeams.Location = New-Object System.Drawing.Point(10,90)
$chkTeams.Size = New-Object System.Drawing.Size(130,20)

$Form.Controls.Add($chkTeams)

# Label Webhook
$lblWebhook = New-Object System.Windows.Forms.Label
$lblWebhook.Text = "Webhook Teams :"
$lblWebhook.Location = New-Object System.Drawing.Point(10,120)
$lblWebhook.Size = New-Object System.Drawing.Size(150,20)
$Form.Controls.Add($lblWebhook)

# Textbox Webhook
$txtWebhook = New-Object System.Windows.Forms.TextBox
$txtWebhook.Location = New-Object System.Drawing.Point(10,150)
$txtWebhook.Size = New-Object System.Drawing.Size(450,20)
$txtWebhook.Enabled = $false
$Form.Controls.Add($txtWebhook)

# checkbox Mail
$chkMail = New-Object System.Windows.Forms.CheckBox
$chkMail.Text = "Envoi mail"
$chkMail.Location = New-Object System.Drawing.Point(10,190)
$Form.Controls.Add($chkMail)

# Label Email
$lblMail = New-Object System.Windows.Forms.Label
$lblMail.Text = "Adresse email :"
$lblMail.Location = New-Object System.Drawing.Point(10,220)
$lblMail.Size = New-Object System.Drawing.Size(90,20)
$Form.Controls.Add($lblMail)

#textbox Email
$txtMail = New-Object System.Windows.Forms.TextBox
$txtMail.Location = New-Object System.Drawing.Point(10,250)
$txtMail.Size = New-Object System.Drawing.Size(450,20)
$txtMail.Enabled = $false
$Form.Controls.Add($txtMail)

# bouton Générer
$btnGenerate = New-Object System.Windows.Forms.Button
$btnGenerate.Text = "Générer lien PWPush"
$btnGenerate.Location = New-Object System.Drawing.Point(10,300)
$btnGenerate.Size = New-Object System.Drawing.Size(200,30)
$Form.Controls.Add($btnGenerate)

# zone résultat
$txtResult = New-Object System.Windows.Forms.TextBox
$txtResult.Text = ""
$txtResult.PlaceholderText = "1 minute entre chaque demandes de liens, par pitié"
$txtResult.Location = New-Object System.Drawing.Point(10,350)
$txtResult.Size = New-Object System.Drawing.Size(450,20)
$txtResult.ReadOnly = $true
$Form.Controls.Add($txtResult)

# Bouton copier
$btnCopy = New-Object System.Windows.Forms.Button
$btnCopy.Text = "Copier"
$btnCopy.Location = New-Object System.Drawing.Point(175,380)
$btnCopy.Size = New-Object System.Drawing.Size(100,30)
$Form.Controls.Add($btnCopy)

# icone checkmark 
$btnchkmark = New-Object System.Windows.Forms.Button
$btnchkmark.Location = New-Object System.Drawing.Point(300,380)
$btnchkmark.Size = New-Object System.Drawing.Size(30,30)
$btnchkmark.Enabled = $false
$Form.Controls.Add($btnchkmark)

# logique trigger du timer
$timer.Add_Tick({
    $btnGenerate.Enabled = $true
    $txtSecret.Enabled = $true
    $timer.Stop()
})

# enable/Disable logique
$chkTeams.Add_CheckedChanged({
    $txtWebhook.Enabled = $chkTeams.Checked
})

$chkMail.Add_CheckedChanged({
    $txtMail.Enabled = $chkMail.Checked
})

# logique de la checkmark du bouton copier
$btnCopy.Add_Click({
    if ($txtResult.Text -ne "") {
        [System.Windows.Forms.Clipboard]::SetText($txtResult.Text)
        $btnchkmark.Enabled = $true
        $btnchkmark.Image = [System.Drawing.Image]::FromFile($visuelsCHMKpath)
        Start-Sleep -Seconds 1.5
        $btnchkmark.Image = $null
        $btnchkmark.Enabled = $false
    }
})

#logique du bouton générer
$btnGenerate.Add_Click({
    $btnGenerate.Enabled = $false
    $txtSecret.Enabled = $false
    $txtSecret.Text | ConvertTo-Json | Set-Content -Encoding utf8 -Path $secretJSONpath
    $compteur = Get-Content -Raw -Path $compteurJsonPath | ConvertFrom-Json
    if ($compteur.compteur -eq $false) {
            if ($txtResult.Text -eq "") {
                & $pushPath
                $lien = Get-Content -Raw -Path $dataJSONpath | ConvertFrom-Json
                $txtResult.Text = $lien.html_url
            }
            else {
                $txtResult.Text = ""
                & $pushPath
                $lien = Get-Content -Raw -Path $dataJSONpath | ConvertFrom-Json
                $txtResult.Text = $lien.html_url
            }
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("veuillez laisser un écart d'une minute entre les générations de liens")
    }
    $timer.Start()
})







$Form.ShowDialog()