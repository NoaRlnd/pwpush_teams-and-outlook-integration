Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$currentPath = $PSScriptRoot
$basePath = Split-Path -Path $PSScriptRoot

$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false
$Form.Text = "PWPush GUI - TestPage"
$Form.Size = New-Object System.Drawing.Size(700, 450)
$Form.StartPosition = "CenterScreen"

$lblVues = New-Object System.Windows.Forms.Label
$lblVues.Text = "limite de vue par défaut (1)"
$lblVues.Location = New-Object System.Drawing.Point(10,80)
$lblVues.Size = New-Object System.Drawing.Size(160,30)
$Form.Controls.Add($lblVues)

# trackbar limite de vues
$tbVues = New-Object System.Windows.Forms.TrackBar
$tbVues.Location = New-Object System.Drawing.Point(10, 110)
$tbVues.Size = New-Object System.Drawing.Size(320, 45)
$tbVues.Maximum = 100
$tbVues.Minimum = 1
$tbVues.Value = 1
$tbVues.TickFrequency = 10
$Form.Controls.Add($tbVues)

# logique affichage des values de la trackbar dans le label
$tbVues.Add_Scroll({
    $lblVues.Text = "Limite de vues : " + $tbVues.Value
})



$Form.ShowDialog()
