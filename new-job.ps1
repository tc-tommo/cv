param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$company,
    [Parameter(Mandatory=$true, Position=1)]
    [string]$jobTitle
)

$folderName = "$company--$jobTitle"
$applicationPath = Join-Path -Path "applications" -ChildPath $folderName

# Create the application directory
if (-not (Test-Path $applicationPath)) {
    New-Item -ItemType Directory -Path $applicationPath | Out-Null
} else {
    Write-Host "Application folder already exists: $applicationPath"
    return
}

# Copy job-description.md
Copy-Item "job-template.md" (Join-Path $applicationPath "job-description.md") -Force

# Copy cv-template.md
Copy-Item "cv-template.md" (Join-Path $applicationPath "cv.md") -Force

# Copy cover-letter-template.md
Copy-Item "cover-letter-template.md" (Join-Path $applicationPath "cover-letter.md") -Force

# Create a blank notes.md
New-Item -ItemType File -Path (Join-Path $applicationPath "notes.md") -Force | Out-Null

# Append to tracking.csv
$trackingPath = "tracking.csv"
$date = Get-Date -Format "yyyy-MM-dd"
$entry = "$company,$jobTitle,started,$date,"
Add-Content -Path $trackingPath -Value $entry


# open job-description.md in VSCode
Start-Process "cursor" (Join-Path $applicationPath "job-description.md")