Clear-Host
Write-Output "*** IMPORTANT MESSAGE ***" | Tee-Object -Variable Second_Place
Write-Host "The first place it went was to the screen. The second place it will go is the 'second_place' variable."
Write-Host "The variable contains: " $Second_Place

Write-Host "Message A"
Write-Output "Message B"

$First_Name="John" | Write-Host
$Last_Name="Doe" | Write-Output
Write-Host "Your name is $First_Name $Last_Name"