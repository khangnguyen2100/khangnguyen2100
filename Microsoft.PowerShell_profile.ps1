oh-my-posh init pwsh --config 'C:\Users\khang\.config\PowerShell\khang-nguyen.omp.json' | Invoke-Expression

# this is the terminal icons for dir command
Import-Module -Name Terminal-Icons

#  Open Up the ::Administrator Powershell
function sudo {
    if ($args.Count -gt 0) {
        $argList = "& '" + $args + "'"
        $wtExe = "wt.exe"
        Start-Process -FilePath $wtExe -ArgumentList "-p", "Windows PowerShell", "-NoExit", "-c", $argList -Verb RunAs
    }
    else {
        $wtExe = "wt.exe"
        Start-Process -FilePath $wtExe -ArgumentList "-p", "Windows PowerShell", "pwsh.exe" -Verb RunAs
    }
}

# Function to Remove Items 
function rm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    Remove-Item -Path $Path -Recurse -Force
}

# function to create a new file
function touch {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [Alias("Path")]
        [string]$FilePath,
        
        [Parameter(Position = 1)]
        [Alias("ItemType")]
        [string]$Type = "File"
    )

    New-Item -Path $FilePath -ItemType $Type
}

# Function that will read file content and thn displayed into the terminal
function cat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [string]$FilePath
    )

    $content = Get-Content -Path $FilePath
    $content
}

# this function will unzip a file in the current directory
function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
$fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object{$_.FullName}
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

# alias for docker
Set-Alias -Name d -Value docker

# vscode setup
# https://vscode.dev/profile/github/1652137255755104a511a721734c0e13