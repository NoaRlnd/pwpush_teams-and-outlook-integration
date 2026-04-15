Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$currentPath = $PSScriptRoot
$basePath = Split-Path -Path $PSScriptRoot
$dataJSONpath = Join-Path $basePath "\data\data.json"

$contentData = Get-Content -Raw -Path $dataJSONpath | ConvertFrom-Json

$Script:keyIsModified = $false
$lblValuesTab = @(
    '15 minutes'
    '30 minutes'
    '45 minutes'
    '1 heure'
    '6 heures'
    '12 heures'
    '1 jour'
    '2 jours'
    '3 jours'
    '4 jours'
    '5 jours'
    '6 jours'
)

$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false
$Form.Text = "PWPush GUI - parametres"
$Form.Size = New-Object System.Drawing.Size(700,450)
$Form.StartPosition = "CenterParent" 

$scrollBar = New-Object System.Windows.Forms.VScrollBar
$scrollBar.Dock = [System.Windows.Forms.DockStyle]::Right

# checkbox passphrase
$chkPassphrase = New-Object System.Windows.Forms.CheckBox
$chkPassphrase.Text = "Ajout d'une passphrase"
$chkPassphrase.Location = New-Object System.Drawing.Point(10,20)
$chkPassphrase.Size = New-Object System.Drawing.Size(180,20)
$chkPassphrase.Checked = if ($contentData.passphrase -ne "") {$true} else {$false}
$Form.Controls.Add($chkPassphrase)

# label Passphrase
$lblPassphrase = New-Object System.Windows.Forms.Label
$lblPassphrase.Text = "passphrase (vide par défaut) :"
$lblPassphrase.Location = New-Object System.Drawing.Point(10,50)
$lblPassphrase.Size = New-Object System.Drawing.Size(180,20)
$Form.Controls.Add($lblPassphrase)

# textbox passphrase
$txtPassphrase = New-Object System.Windows.Forms.TextBox
$txtPassphrase.Location = New-Object System.Drawing.Point(10,80)
$txtPassphrase.Size = New-Object System.Drawing.Size(390,20)
$txtPassphrase.Text = $contentData.passphrase
$txtPassphrase.Enabled = if ($contentData.passphrase -ne "") {$true} else {$false}
$Form.Controls.Add($txtPassphrase)

# label Vues
$lblVues = New-Object System.Windows.Forms.Label
$lblVues.Text = $contentData.expire_after_views.ToString() + " vues avant expiration (par défaut 1)"
$lblVues.Location = New-Object System.Drawing.Point(10,110)
$lblVues.Size = New-Object System.Drawing.Size(270,30)
$Form.Controls.Add($lblVues)

# trackbar limite de vues
$tbVues = New-Object System.Windows.Forms.TrackBar
$tbVues.Location = New-Object System.Drawing.Point(10,150)
$tbVues.Size = New-Object System.Drawing.Size(320, 45)
$tbVues.Maximum = 100
$tbVues.Minimum = 1
$tbVues.Value = $contentData.expire_after_views
$tbVues.TickFrequency = 10
$Form.Controls.Add($tbVues)

# label temps
$lblTime = New-Object System.Windows.Forms.Label
$lblTime.Text = "Expiration du lien (par défaut 15 min) : " + $lblValuesTab[$contentData.expire_after_duration]
$lblTime.Location = New-Object System.Drawing.Point(10,200)
$lblTime.Size = New-Object System.Drawing.Size(270,30)
$Form.Controls.Add($lblTime)

# trackbar limite de temps
$tbTime = New-Object System.Windows.Forms.TrackBar
$tbTime.Location = New-Object System.Drawing.Point(10,240)
$tbTime.Size = New-Object System.Drawing.Size(180, 45)
$tbTime.Maximum = 11
$tbTime.Minimum = 0
$tbTime.Value = $contentData.expire_after_duration
$tbTime.TickFrequency = 2
$Form.Controls.Add($tbTime)

#label clé api
$lblAPIkey = New-Object System.Windows.Forms.Label
$lblAPIkey.Text = "changer de clé API :"
$lblAPIkey.Location = New-Object System.Drawing.Point(10,300)
$lblAPIkey.Size = New-Object System.Drawing.Size(120,30)
$Form.Controls.Add($lblAPIkey)

# bouton changer clé API
$btnAPIkey = New-Object System.Windows.Forms.Button
$btnAPIkey.Text = "Changer"
$btnAPIkey.Location = New-Object System.Drawing.Point(140,297)
$btnAPIkey.Size = New-Object System.Drawing.Size(65,24)
$Form.Controls.Add($btnAPIkey)

# bouton valider
$btnValider = New-Object System.Windows.Forms.Button
$btnValider.Text = "Valider"
$btnValider.Location = New-Object System.Drawing.Point(300,375)
$btnValider.Size = New-Object System.Drawing.Size(80,30)
$Form.Controls.Add($btnValider)


# logique  enable/disable
$chkPassphrase.Add_CheckedChanged({
    $txtPassphrase.Enabled = $chkPassphrase.Checked
})

# logique affichage des values de la trackbar dans le label
$tbVues.Add_Scroll({
    $lblVues.Text = "Limite de vues : " + $tbVues.Value
})

# paeil mais pour time
$tbTime.Add_Scroll({
    $lblTime.Text = "Expiration du lien : " + $lblValuesTab[$tbTime.Value]
})

# logique bouton clé API
$btnAPIkey.Add_Click({
    $popUp = [Microsoft.VisualBasic.Interaction]::InputBox("entrez votre token API", "Pop-up", "")
    if ($popUp.length -lt 15 -or $popUp -match "\s") {
        [System.Windows.Forms.MessageBox]::Show("veuillez remplir avec une vraie clé API, ou correctement")
    }
    else {
        $Script:popUpItem = @{
            "APItoken" = $popUp
        }
        $keyIsModified = $true
    }
})

# logique bouton valider
$btnValider.Add_Click({
    $contentData.expire_after_views = $tbVues.Value
    $contentData.expire_after_duration = $tbTime.Value
    if ($chkPassphrase.Checked -eq $false) {
        $contentData.passphrase = ""
    }
    else {
        $contentData.passphrase = $txtPassphrase.Text
    }
    if ($keyIsModified = $true) {
        $popUpItem | ConvertTo-Json | Set-Content -Encoding utf8 -Path $credentielJSONpath
    }
    $contentData | ConvertTo-Json | Set-Content -Encoding utf8 -Path $dataJSONpath
    $Form.Close()
})


$Form.ShowDialog()