Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$currentPath = $PSScriptRoot
$basePath = Split-Path -Path $PSScriptRoot
$dataJSONpath = Join-Path $basePath "\data\data.json"

$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false
$Form.Text = "PWPush GUI - parametres"
$Form.Size = New-Object System.Drawing.Size(700,450)
$Form.StartPosition = "CenterParent" 

# checkbox passphrase
$chkPassphrase = New-Object System.Windows.Forms.CheckBox
$chkPassphrase.Text = "Envoi par Teams"
$chkPassphrase.Location = New-Object System.Drawing.Point(10,20)
$chkPassphrase.Size = New-Object System.Drawing.Size(130,20)
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
$txtPassphrase.Enabled = $false
$Form.Controls.Add($txtPassphrase)

# label Vues
$lblVues = New-Object System.Windows.Forms.Label
$lblVues.Text = "limite de vue (par défaut 1)"
$lblVues.Location = New-Object System.Drawing.Point(10,110)
$lblVues.Size = New-Object System.Drawing.Size(160,30)
$Form.Controls.Add($lblVues)

# trackbar limite de vues
$tbVues = New-Object System.Windows.Forms.TrackBar
$tbVues.Location = New-Object System.Drawing.Point(10,150)
$tbVues.Size = New-Object System.Drawing.Size(320, 45)
$tbVues.Maximum = 100
$tbVues.Minimum = 1
$tbVues.Value = 1
$tbVues.TickFrequency = 10
$Form.Controls.Add($tbVues)

# label Jours
$lblJours = New-Object System.Windows.Forms
$lblJours.Text = "limite de jours (par défaut 1)"
$lblJours.Location = New-Object System.Drawing.Point(10,200)
$lblJours.Size = New-Object System.Drawing.Size(160,30)
$Form.Controls.Add($lblJours)

# trackbar limite de Jours
$tbJours = New-Object System.Windows.Forms.TrackBar
$tbJours.Location = New-Object System.Drawing.Point(10,240)
$tbJours.Size = New-Object System.Drawing.Size(180, 45)
$tbJours.Maximum = 6
$tbJours.Minimum = 1
$tbJours.Value = 1
$tbJours.TickFrequency = 2
$Form.Controls.Add($tbJours)

# bouton valider
$btnValider = New-Object System.Windows.Forms.Button
$btnValider.Text = "Valider"
$btnValider.Location = New-Object System.Drawing.Point(300,400)
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

# paeil mais pour les jours
$tbJours.Add_Scroll({
    $lblJours.Text = "Limite de jours : " + $tbJours.Value
})

# logique bouton valider
$btnValider.Add_Click({
    $contentJSON = Get-Content -Raw -Path $dataJSONpath | ConvertFrom-Json
    $contentJSON.expire_after_views = $tbVues.Value
    $contentJSON.expire_after_days = $tbJours.Value
    if ($txtPassphrase.Text = "") {
        $contentJSON.passphrase = $null
    }
    else {
        $contentJSON.passphrase = $txtPassphrase.Text
    }
    # ajouter ici les autres genre passphrase, expire after days, etc
    $contentJSON | ConvertTo-Json | Set-Content -Encoding utf8 -Path $dataJSONpath
    $Form.Close()
})


$Form.ShowDialog()