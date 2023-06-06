$First_Name="John "
$Last_Name=" Doe"
$Domain="@ForTheITPro.com"
$Email_Address=$First_Name.Trim().SubString(0,1) + $Last_Name.Trim()+$Domain     
Write-Host $Email_Address