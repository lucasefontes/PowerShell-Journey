<#
Get Performance Information, status of System Health
Used to populate Reports and a database

• Computer name
• Total number of processes
• Total processor load
• % free physical memory
• % free space on drive C:
• The computer’s uptime

Needs to take Credentials, optional logging.

Get-TMComputerStatus -ComputerName -Credentials domain\User -ErrorLogFilePath errorlog.txt
Get-TMComputerStatus -ComputerName COMP01 -Credetials Domain\User
Get-TMComputerStatus -CompuiterName COMP01,COMP02 -Credentials Domain\User
Get-Content Servers.txt | Get-TMComputerStatus -Credentials Domain\User
Import-CSV servers.csv | Get-TMComputerStatus -Credentials Domain\User
Get-TMComputerStatus (Get-ADComputer -Filter *).Name -Credentials Domain\User

Import-CSV servers.csv | Get-TMComputerStatus -credential $cred |
Export-CSV status.csv
Get-Content group1.txt | Get-TMComputerStatus |
ConvertTo-HTML <parameters>

Get-TMComputerStatus (Get-ADComputer -filter *).name |
Sort-Object Computername |
Format-Table -GroupBy Computername -property Date,Uptime,Pct* |
Out-File report.txt

#>

$env:COMPUTERNAME
Get-CimInstance -ClassName Win32_OperatingSystem
Get-CimInstance -ClassName Win32_ComputerSystem | fl *
Get-CimInstance -ClassName Win32_Processor
Get-CimInstance -ClassName Win32_Process
Get-Volume