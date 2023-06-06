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



