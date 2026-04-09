Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false
$Form.Text = "PWPush GUI - MailPage"
$Form.Size = New-Object System.Drawing.Size(450, 700)
$Form.StartPosition = "CenterParent" 


$Form.ShowDialog()