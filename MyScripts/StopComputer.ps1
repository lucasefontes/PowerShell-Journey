
for ($i = 1; $i -le 20; $i++) 
{
    $percentage = $i * 5
    Write-Progress -SecondsRemaining $i -Activity "Waiting for $i seconds before running the script" -PercentComplete $percentage -Status "$percentage% completed."
    Start-Sleep -Seconds 1
}

$seconds = 10
Start-Sleep -Seconds $seconds
foreach ($second in $seconds)
{
    $second++
    Start-Sleep -Seconds $second
    Write-Host ("Sleeping for $second seconds")
}

Set-Location "C:\Users\lfontes\OneDrive - CyberArk Ltd\PowerShell-Journey\MyScripts\OutlookScripts"
.\EmptyDeletedItems.ps1

Write-Host (".\EmptyDeletedItems.ps1 executed successfully")

Remove-Item -Path $env:TEMP\* -Recurse -Force

Clear-RecycleBin -Force

Get-Process -Name "Acrobat*" | Where-Object {$_.CloseMainWindow()}

Stop-Computer localhost -Force