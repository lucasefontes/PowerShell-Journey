# EX 18

Copy-Item HKCU:\Environment -Destination HKCU:\EnvBackup -PassThru

# Ex 21

Get-ChildItem -Path Cert:\* -Recurse | Where-Object {$_.NotAfter -lt (Get-Date)} | Format-List -Property FriendlyName,Issuer,PSPath,PSParentPath

# EX 22

Get-PSDrive

# EX 23

New-Item -Path "env:temp\a\b\c\d\e\f" -Type Directory

# EX 24

New-Item -Path "$env:temp\foo\bar\xyz\" -ItemType Directory
New-Item -Path "$env:temp\foo\bar\xyz\data.txt" -ItemType File

# EX 25

New-Item -Path "HKLM:\SOFTWARE\PSPrimer\Data"
New-ItemProperty -path "HKLM:\SOFTWARE\PSPrimer\Data" -Name "Version" -Value 1
New-ItemProperty -path "HKLM:\SOFTWARE\PSPrimer\Data" -Name "Random" -PropertyType DWORD -Value(Get-Random -Minimum 10 -Maximum 99)
New-ItemProperty -path "HKLM:\SOFTWARE\PSPrimer\Data" -Name "Free" -Value(Get-PSDrive -PSProvider FileSystem -Name C)



