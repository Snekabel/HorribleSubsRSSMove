#=============================================================================
# AnimeRSSMove v1.0 by Neo
# AnimeRSSMove.ps1 -InputFile '<file path>' -OutputPath = '<file destination>'
#=============================================================================
### Parameters, Title, Checks, Variables
# Set parameters
Param(
	[Parameter(Mandatory=$true, Position=0)]
	[string]$InputFile = "",
	[Parameter(Mandatory=$true, Position=1)]
	[string]$OutputPath = ""
)

# Set PowerShell title.
$host.ui.RawUI.WindowTitle = "AnimeRSSMove v1.0 by Neo"

# Wait 5 seconds to bypass errors created by other software.
Start-Sleep -Seconds 5

# Check if input file exists, if it doesn't exit script.
If (-Not ([System.IO.File]::Exists($InputFile))) {
	exit
}

# Check if output path exists, if it doesn't exit script.
If (-Not (Test-Path $OutputPath)) {
	exit
}

# Default variables.
$InputFileName = Split-Path $InputFile -Leaf
$InputFileStartSubstring = $InputFileName.IndexOf("]")
$InputFileEndSubstring = $InputFileName.LastIndexOf("-")
$FolderName = $InputFileName.Substring(0, $InputFileEndSubstring).Substring($InputFileStartSubstring+1).Trim()
$FolderPath = $OutputPath + $FolderName
$FolderPathFileName = $FolderPath + "\" + $InputFileName

# Check if folder path exists, if it doesn't create folder.
If (-Not (Test-Path $FolderPath)) {
	New-Item -Path $OutputPath -Name $FolderName -ItemType "directory"
}

# Check if file already exists in the path, if it does delete it.
If ([System.IO.File]::Exists($FolderPathFileName)) {
	[System.IO.File]::Delete($FolderPathFileName)
}

# Move file to new folder.
[System.IO.File]::Move($Inputfile, $FolderPathFileName)
