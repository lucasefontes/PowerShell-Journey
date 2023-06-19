$First_Name=Read-Host "What is the user's First Name?".Trim()
$Last_Name=Read-Host "What is the user's Last Name?".Trim()
$User_Name=$First_Name.SubString(0,1)+$Last_Name
$Log_File="C:\Logs\$User_Name.log"
Write-Output "Creating user: $User_Name" | Tee-Object $Log_File -Append
New-ADUser -Name $User_Name -GivenName $First_Name -Surname $Last_Name -DisplayName $User_Name -SamAccountName $User_Name -Enabled $false
| Tee-Object $Log_File -Append
Start-Sleep 5
Get-ADUser -filter *|Where-Object {$_.SamAccountName -eq $User_Name} | Tee-Object $Log_File -Append