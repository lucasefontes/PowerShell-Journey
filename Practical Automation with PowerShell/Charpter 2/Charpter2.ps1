Function Set-ArchiveFilePath{
    [CmdletBinding()]
    [OutputType([string])]
    param(
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,
 
    [Parameter(Mandatory = $true)]
    [string]$ZipPrefix,
 
    [Parameter(Mandatory = $true)]
    [datetime]$Date
    )
 
    if(-not (Test-Path -Path $ZipPath)){
        New-Item -Path $ZipPath -ItemType Directory | Out-Null
        Write-Verbose "Created folder '$ZipPath'"
    }
    
    $timeString = $Date.ToString('yyyyMMdd')
    $ZipName = "$($ZipPrefix)$($timeString).zip"
    $ZipFile = Join-Path $ZipPath $ZipName
 
    if(Test-Path -Path $ZipFile){
        throw "The file '$ZipFile' already exists"
    }
 
    $ZipFile
}