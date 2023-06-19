
for ($i = 1; $i -le 20; $i++) 
{
    $percentage = $i * 5
    Write-Progress -SecondsRemaining $i -Activity "Waiting for $i seconds before running the script" -PercentComplete $percentage -Status "$percentage% completed."
    Start-Sleep -Seconds 1
}
Write-Progress -Activity "Waiting completed" -Completed

Get-Process -Name "Acrobat*" | Where-Object {$_.CloseMainWindow()}

Set-Location "C:\Users\lfontes\OneDrive - CyberArk Ltd\PowerShell-Journey\MyScripts\OutlookScripts"
.\EmptyDeletedItems.ps1

Write-Host (".\EmptyDeletedItems.ps1 executed successfully")

Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue
Write-Host ("Files on $env:TEMP deleted successfully")

Clear-RecycleBin -Force
Write-Host ("Reclycle bin cleared.")

for ($i = 1; $i -le 40; $i++) 
{
    $percentage = $i * 2.5
    Write-Progress -SecondsRemaining $i -Activity "Waiting for $i seconds before shutting down computer" -PercentComplete $percentage -Status "$percentage% completed."
    Start-Sleep -Seconds 1
}
Write-Progress -Activity "Waiting completed" -Completed
Write-Host ("Shutting Down Computer.")
Start-Sleep -Seconds 5
Stop-Computer localhost -Force