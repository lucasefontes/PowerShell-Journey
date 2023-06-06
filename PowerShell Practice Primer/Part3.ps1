#EX 1

$numbers = 1..20
$numbers[4]

#Ex 2

$numbers = @()
$numbers = @(Get-Random -Count 10 -Minimum 10 -Maximum 100)
$sum = 0
$numbers | ForEach-Object {$sum += $_}
$sum

#Ex 3

$params = @{   
            ComputerName=$env:COMPUTERNAME
            PowerShellVersion=$PSVersionTable
            CurrentDate=(Get-Date).ToLongDateString()
}
$params

#Ex 4

$params.Add('Name',@('Bits','WinRM'))
$params.Remove('PowershellVersion')
$params.Remove('CurrentDate')

Get-Service @params

# Ex 5

$params = [ordered]@{
    'ComputerName'=$env:COMPUTERNAME
    'Processes'=(Get-Service | Where-Object {$_.Status -eq 'Running'})
    'Top5WorkingSets'=(Get-Process | Sort-Object -Property WS -Descending -Top 5)
    'TempFolderSizeInBytes'=(Get-ChildItem $env:temp | Measure-Object -Property Length -Sum).Sum
}

New-Object -TypeName PSObject -Property $params

#Ex 5/6 + 

# ordered
$params = [PSCustomObject]@{
    'ComputerName'=$env:COMPUTERNAME
    'Processes'=(Get-Service | Where-Object {$_.Status -eq 'Running'})
    'Top5WorkingSets'=(Get-Process | Sort-Object -Property WS -Descending -Top 5)
    'TempFolderSizeInBytes'=(Get-ChildItem $env:temp | Measure-Object -Property Length -Sum).Sum
}

#EX 7

Get-WinEvent -ListLog * | 
Where-Object {$_.RecordCount -ne 0} | 
Select-Object -Property LogName,RecordCount,MaximumSizeinBytes,
@{l='ComputerName';e={$env:COMPUTERNAME}}

#EX8

Get-ChildItem C:\Users\lfontes\Downloads | 
Group-Object -Property Extension | 
Select-Object Count,Name,
@{n='SizeInBytes';e={($_.Group | Measure-Object -Property Length -Sum).Sum}}

#EX 9

$letters = 'a','b','c','d','e' | Get-Random
Write-Host ("The random letter generated was: $letters")
switch($letters){
    'a' {$result = 'alpha'}
    'b' {$result = 'bravo'}
    'c' {$result = 'charlie'}
    'd' {$result = 'delta'}
    'e' {$result = 'echo'}
}
$result

#Ex 10

$a = "PowerShell Forever"
$achar = $a.ToLower().ToCharArray()
($achar | Sort-Object ) -join ''

#Ex 11

$h = Get-Service | Group-Object -Property StartupType -AsHashTable -AsString

#Ex 12

$h.Disabled[17]

#Ex 13

$numbers = (1..50)

foreach ($number in $numbers){
    if($number % 2 -eq 0){
        Write-Host "$number is even"
    } 
}

#Ex 14

$i = 0
while ($i -le 25){
    "`$i = $i"
     $i = $i + 5
}

#Ex 15

Get-Process | Where-Object {$_.StartTime -ne $null} | Sort-Object -Property StartTime -Top 25 | Select-Object ID,Name,StartTime,Path,
@{l="How long it's running";e={(Get-Date) - $_.StartTime}}

#Ex 16

$numbers = Get-Random -Minimum 10 -Maximum 100 -Count 25
Write-Host "The random numbers are: $numbers"
$numbers2 = foreach ($number in $numbers){
    $number * 3
}
Write-Host "The random numbers multiplied by 3 are: $numbers2" 
$numbers2 | Measure-Object -Sum -Average -Maximum -Minimum | Select-Object Sum,Average,Maximum,Minimum

#Ex 17

New-Alias -Name np -Value notepad.exe
New-Alias -Name tx -Value tzutil.exe
New-Alias -Name ct -Value control.exe

Get-Alias np,tx,ct | Select-Object Name,
@{Name="Value";Expression={$_.ResolvedCommandName}},description |
ConvertTo-Json | Out-File c:\Users\lfontes\Desktop\myaliases.json

Get-ChildItem alias:\ -Include np,tx,ct -Recurse | Remove-Item

$in = Get-Content c:\Users\lfontes\Desktop\myaliases.json | ConvertFrom-Json
$in | New-Alias -Description "user-defined" -PassThru

#Ex 18

Get-ChildItem -Path $env:temp | Where-Object {$_.Length -le 100 -or $_.Length -ge 1MB}

#Ex 19

$path = "$($env:temp)\$(Get-Date -Format yyyy-M-d)-$env:COMPUTERNAME.xml"
Get-ChildItem -Path $env:temp | Where-Object {$_.Length -le 100 -or $_.Length -ge 1MB} |
Export-Clixml -Encoding utf8 -Path $path

#Ex 20

Invoke-RestMethod -Uri "https://jdhitsolutions.com/blog/feed/" | Select-Object title,link,
@{n='Publication Date';e={($_.pubDate.ToString()) | Get-date}} | Out-GridView

#Ex 21

Invoke-RestMethod -Uri "https://jdhitsolutions.com/blog/feed/" | Select-Object title,link,
@{n='Publication Date';e={($_.pubDate.ToString()) | Get-date}} | Out-GridView

#Ex 22

Get-History | Where-Object {$_.CommandLine -notlike '*help*'}

#Ex 23

Get-DnsClientCache | Where-Object {$_.Type -ne "AAAA"} | Select-Object @{n='ComputerName';e={$env:COMPUTERNAME}},Entry,Type,TimeToLive,Data

#Ex 24

$MyName = "Lucas"
$MyBirthday = "4/25/1991, 8:45AM"

#
$MyBirthdayVar = $MyBirthday | Get-Date
$MyAge = ((Get-Date).Year) - (($MyBirthdayVar).Year)
$TimeSpan = (Get-Date) -  $MyBirthdayVar
$TimeSpanDays = $TimeSpan.Days
$TimeSpanHours = $TimeSpan.Hours
$TimeSpanMinutes = $TimeSpan.Minutes
$TimeSpanSeconds = $TimeSpan.Seconds
$TimeSpanMilliseconds = $TimeSpan.Milliseconds
$DayOfWeekVar = $MyBirthDayVar.DayOfWeek
$RetirementDate = $MyBirthdayVar.AddYears(65)

Write-Host ("$MyName, You were born in $MyBirthdayVar, the day of the week was $DayOfWeekVar and you are $MyAge years old, you are on this earth for $TimeSpanDays days, $TimeSpanHours hours, $TimeSpanMinutes minutes, $TimeSpanSeconds seconds and $TimeSpanMilliseconds milliseconds. You should be able to retire on $RetirementDate")

# Ex 25

Get-Process | Where-Object {$_.Company -notlike "*Microsoft*"}
