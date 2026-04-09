#source du code : ITconnect 
Import-Module Send-MailKitMessage

# SMTP : Serveur
$SMTPServer = "smtp-mail.outlook.com"

# SMTP : Port
$SMTPPort = 587

# SMTP : Expéditeur
$SMTPSender = [MimeKit.MailboxAddress]"[mail en question]"

# SMTP : Destinataire(s)
$SMTPRecipientList = [MimeKit.InternetAddressList]::new()
$SMTPRecipientList.Add([MimeKit.InternetAddress]"[mail en question]")

# SMTP : Identifiants
$SMTPCreds = Get-Credential -UserName "[mail en question]" -Message "Veuillez saisir le mot de Passe"

# E-mail : objet
$EmailSubject = "E-mail envoyé avec Send-MailKitMessage"

# E-mail : corps
$EmailBody = "<h1>Démo Send-MailKitMessage</h1>"

# Envoyer l'e-mail
Send-MailKitMessage -SMTPServer $SMTPServer -Port $SMTPPort -From $SMTPSender -RecipientList $SMTPRecipientList `
                    -Subject $EmailSubject -HTMLBody $EmailBody -Credential $SMTPCreds -UseSecureConnectionIfAvailable