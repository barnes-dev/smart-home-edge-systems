# ============================================================================
# HOME LAB DOCUMENTATION BUILD PIPELINE
# common.ps1
#
# Maintained for Smart-Home-Edge-Systems.us by ChatGPT.
# Release 1.1
# ============================================================================

function Write-BuildBlock {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title
    )

    Write-Host ""
    Write-Host "======================================================================" `
        -ForegroundColor DarkGray

    Write-Host $Title `
        -ForegroundColor White `
        -BackgroundColor DarkBlue

    Write-Host "======================================================================" `
        -ForegroundColor DarkGray
}

function Write-BuildInfo {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host "--> $Message" -ForegroundColor Cyan
}

function Write-BuildSuccess {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host "--> $Message" -ForegroundColor Green
}

function Write-BuildWarning {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host "--> $Message" -ForegroundColor Yellow
}

function Write-BuildError {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Error $Message
}

function Test-RequiredPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Description
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Required $Description not found: $Path"
    }

    return $true
}
