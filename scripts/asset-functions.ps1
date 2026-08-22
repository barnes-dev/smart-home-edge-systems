# ============================================================================
# ASSET FUNCTIONS
# ============================================================================
#
# Maintained for Smart-Home-Edge-Systems.us by ChatGPT.
#
# Purpose:
#   Handles extracted images, asset naming, HTML references, and ZIP files.
#
# ============================================================================

function Get-ExtractedMediaDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$AssetDirectory
    )

    return (Join-Path $AssetDirectory "media")
}

function Get-ExtractedMediaFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$MediaDirectory
    )

    if (-not (Test-Path -LiteralPath $MediaDirectory)) {
        return @()
    }

    return @(Get-ChildItem `
        -Path $MediaDirectory `
        -File `
        | Sort-Object Name)
}

function New-AssetArchive {
    param(
        [Parameter(Mandatory = $true)]
        [string]$AssetDirectory,

        [Parameter(Mandatory = $true)]
        [string]$ArchivePath
    )

    $Files = Get-ChildItem `
        -Path $AssetDirectory `
        -File `
        | Where-Object { $_.FullName -ne $ArchivePath }

    if (-not $Files) {
        return $false
    }

    if (Test-Path -LiteralPath $ArchivePath) {
        Remove-Item -LiteralPath $ArchivePath -Force
    }

    Compress-Archive `
        -Path $Files.FullName `
        -DestinationPath $ArchivePath `
        -Force

    return (Test-Path -LiteralPath $ArchivePath)
}

function Remove-TemporaryMediaDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$MediaDirectory
    )

    if (Test-Path -LiteralPath $MediaDirectory) {
        Remove-Item `
            -LiteralPath $MediaDirectory `
            -Recurse `
            -Force
    }
}

