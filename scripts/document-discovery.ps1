# ============================================================================
# DOCUMENT DISCOVERY
# ============================================================================
#
# Home Lab Documentation Build Pipeline
# Maintained for Smart-Home-Edge-Systems.us by ChatGPT
#
# Purpose:
#   Locate DOCX source documents for the documentation build pipeline.
#
# ============================================================================

function Get-BuildDocuments {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true)]
        [string]$ProjectRoot,

        [Parameter(Mandatory = $false)]
        [string]$DocBaseName = $null,

        [Parameter(Mandatory = $false)]
        [ValidateSet("guides", "reference")]
        [string]$TargetFolder = $null

    )

    # ------------------------------------------------------------------------
    # Determine search locations
    # ------------------------------------------------------------------------

    $SearchDirectories = @()

    if ($TargetFolder) {

        $TargetPath = Join-Path $ProjectRoot $TargetFolder

        if (Test-Path -LiteralPath $TargetPath) {
            $SearchDirectories += $TargetPath
        }
    }
    else {

        $GuidesPath = Join-Path $ProjectRoot "guides"
        $ReferencePath = Join-Path $ProjectRoot "reference"

        if (Test-Path -LiteralPath $GuidesPath) {
            $SearchDirectories += $GuidesPath
        }

        if (Test-Path -LiteralPath $ReferencePath) {
            $SearchDirectories += $ReferencePath
        }
    }

    # ------------------------------------------------------------------------
    # Search for DOCX files
    # ------------------------------------------------------------------------

    $Documents = @()

    foreach ($SearchDirectory in $SearchDirectories) {

        if ($DocBaseName) {

            $Candidate = Join-Path $SearchDirectory "$DocBaseName.docx"

            if (Test-Path -LiteralPath $Candidate) {

                $Documents += Get-Item -LiteralPath $Candidate
            }
        }
        else {

            $Documents += Get-ChildItem `
                -LiteralPath $SearchDirectory `
                -Filter "*.docx" `
                -File `
                -ErrorAction SilentlyContinue
        }
    }

    # ------------------------------------------------------------------------
    # Remove duplicates and return results
    # ------------------------------------------------------------------------

    $Documents |
        Sort-Object FullName -Unique
}