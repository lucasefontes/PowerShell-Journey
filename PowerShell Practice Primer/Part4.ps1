#Ex 1

Get-CimClass -Namespace root\cimv2 -ClassName Win32_*

#Ex 2

Get-CimClass -ClassName Win32_LogicalDisk | Get-Member -MemberType Method

#Ex 3

Get-CimClass -ComputerName localhost -ClassName Win32_OperatingSystem | Format-List *

#Ex 4

Get-CimInstance -ComputerName localhost -ClassName Win32_Service | Where-Object {$_.State -eq "Stopped" -and $_.StartMode -eq "Auto"}

<#
Comments
The tricky thing about WMI filters is that they use the legacy operators. And you should always filter
early in your PowerShell expression, especially when you are querying many remote computers, or
a WMI class that might return many results.
Once you understand the PowerShell’s object nature, or if you only want the values not an object
with a single property of Displayname, you could do this:
Part 4 Solutions 90
(Get-CimInstance -ClassName win32_service -filter "startmode='auto' AND `
state <>'running'").Displayname
Finally, you can improve performance with Get-CimInstance by requesting only the properties
you intend to use.
(Get-CimInstance -ClassName win32_service -filter "startmode='auto' AND `
state <>'running'" -property displayname).Displayname
You’ll appreciate the performance edge as you scale-out.
#>

#Ex 5

Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object CSName,LastBootUpTime,
@{n='Up and running for:';e={((Get-Date) - $_.LastBootUpTime)}}

#Ex 6

Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object `
@{n="ComputerName";e={$_.CSName}},
@{n="FreeVirtualMemoryGB";e={[math]::round($_.FreeVirtualMemory / 1MB,2)}},
@{n="FreePhysicalMemoryGB";e={[math]::round($_.FreePhysicalMemory / 1MB,2)}},
@{n="TotalVirtualMemorySizeGB";e={[math]::round($_.TotalVirtualMemorySize / 1MB,2)}},
@{n="TotalVisibleMemorySizeGB";e={[math]::round($_.TotalVisibleMemorySize / 1MB,2)}}

#Ex 7

Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object `
@{n="ComputerName";e={$_.CSName}},
@{n="FreeVirtualMemoryGB";e={[math]::round($_.FreeVirtualMemory / 1MB,2)}},
@{n="FreePhysicalMemoryGB";e={[math]::round($_.FreePhysicalMemory / 1MB,2)}},
@{n="TotalVirtualMemorySizeGB";e={[math]::round($_.TotalVirtualMemorySize / 1MB,2)}},
@{n="TotalPhysicalMemorySizeGB";e={[math]::round($_.TotalVisibleMemorySize / 1MB,2)}},
@{n="Free Percentage of TotalPhisicalMemorySizeGB";e={[math]::round(($_.FreePhysicalMemory) / ($_.TotalVisibleMemorySize / 100),2)}},
@{n="Free Percentage of TotalVirtualMemorySizeGB";e={[math]::round(($_.FreeVirtualMemory) / ($_.TotalVirtualMemorySize / 100),2)}}

#Ex 8

Get-CimInstance -Classname Win32_Service | Sort-Object StartName,DisplayName | Format-Table -GroupBy StartName -Property Name,DisplayName,StartMode

#EX 9

Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object Name,Size,@{n="FreeSpaceGB";e={$_.FreeSpace / 1GB}}

#Ex 10

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct

#EX 11

Get-CimInstance -ClassName Win32_NTEventlogFile | Select-Object -Property LogfileName,Path,LastModified,NumberOfRecords,MaxFileSize,
@{n="FileSize";e={[math]::Round($_.FileSize)}},
@{n="PercentageOfLogInUse";e={[math]::Round(($_.FileSize) / ($_.MaxFileSize) * 100,2)}}

#EX 12

Get-CimInstance win32_group -filter "name = 'administrators' AND `
LocalAccount = 'true'" |
Get-CimAssociatedInstance -ResultClassName win32_useraccount

#EX 13

$users = Get-CimInstance win32_group -filter "name = 'administrators' AND LocalAccount = 'true'" | Get-CimAssociatedInstance -ResultClassName win32_useraccount

$groups = Get-CimInstance win32_group -filter "name = 'administrators'" | Get-CimAssociatedInstance -ResultClassName win32_group

$users
$groups

Get-CimInstance win32_group -filter "name = 'administrators' AND `
LocalAccount = 'true'" |
Get-CimAssociatedInstance | Where-Object {$_.CimClass -match "User|Group"} |
Select-Object -property Name,Domain,Caption,SID,CimClass

#EX 14

Get-Command -CommandType Cmdlet,Function -ParameterName CimSession

#Ex 15

Get-CimInstance -ClassName Win32_DiskPartition

Get-Partition -DriveLetter C | Select-Object DriveLetter,PartitionNumber,
@{n="SizeGB";e={$_.Size / 1GB}},GptType

#EX 16

$session = New-CimSession -Credential lfontes\Administrator -ComputerName WIN-E7LV0QT74KB,WIN-10JBE3JRVLE,WIN-C1RO5A3QSSH

Get-CimInstance -CimSession $session Win32_Processor | Select-Object Name,SystemName,Status,Description,LoadPercentage,Manufacturer

#Ex 17

Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object SystemName,DeviceID,Name,Size,
@{n="FreeSpaceGB";e={$_.FreeSpace / 1GB}}

_______________________________________

Get-CimSession | Get-CimInstance -ClassName Win32_LogicalDisk -Filter "drivetype=3" |
Select-Object -property @{Name="Computername";Expression={$_.Systemname}},DeviceID,VolumeName,
@{Name="SizeGB";Expression={$_.Size/1gb -as [int]}},
@{Name="FreeGB";Expression={$_.Freespace/1gb -as [int]}},
@{Name="PctFree";Expression = {($_.Freespace/$_.size)*100}}