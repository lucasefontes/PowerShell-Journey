Set-Location "C:\Users\lfontes\OneDrive - CyberArk Ltd\PowerShell-Journey\MyScripts\OutlookScripts"
.\EmptyDeletedItems.ps1

Write-Host (".\EmptyDeletedItems.ps1 executed successfully")

Remove-Item -Path $env:TEMP\* -Recurse -Force

Clear-RecycleBin -Force

Get-Process -Name "Acrobat*" | Where-Object {$_.CloseMainWindow()}

Stop-Computer localhost -Force