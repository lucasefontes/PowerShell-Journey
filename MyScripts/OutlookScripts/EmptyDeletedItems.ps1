<# For some reason that I could not figure it out yet, if I don't use the loop for the script to run multiple times
the loop seems to be stopped in the middle and it does not go through all items in the "$Items | ForEach-Object {$_.Delete()}"
However for now I worked around it using the loop.
#>

for ($i = 0; $i -le 10; $i++) 
{

    $percentage = $i * 10
    $olApp = New-Object -ComObject outlook.application

    #Times script was processed
    Write-Progress -Activity "Script ran $i times" -Status "$percentage% completed"
    $namespace = $olApp.GetNamespace("MAPI")

    #Get the name space and the Deleted Items folder(the number 3)
    $Folder = $namespace.GetDefaultFolder(3)

    #Remove the \\ in the string name
    $FolderPath = ($Folder.FolderPath).Substring(2,39)
    Write-Host ("The items in the mailbox\folder: [$FolderPath] will be deleted.")

    #Get all items(emails) from the Deleted Items folder
    $Items = ($Folder.Items)

    #Display how many items(emails) will be deleted
    $Count = $Items.Count
    Write-Host ("$Count emails will be deleted.")

    #Delete everything
    $Items | ForEach-Object {$_.Delete()}

    $olApp.Quit | Out-Null
    [GC]::Collect()
}
Write-Progress -Activity "Waiting completed" -Completed
Clear-Host