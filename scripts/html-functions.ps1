# ============================================================================
# HTML FUNCTIONS
# ============================================================================
#
# Home Lab Documentation Build Pipeline
# Maintained for Smart-Home-Edge-Systems.us by ChatGPT
#
# Purpose:
#   HTML cleanup and normalization functions.
#
# ============================================================================

function Normalize-HtmlLabels {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true)]
        [string]$Html

    )

    # ------------------------------------------------------------------------
    # Figure labels
    #
    # Converts variations such as:
    #
    #   Figure:
    #   Figure 1:
    #   Figure&nbsp;:
    #   Figure&nbsp;1:
    #
    # into sequential Figure labels.
    # ------------------------------------------------------------------------

    $FigureIndex = 0

    $Html = $Html -replace `
        '\bFigure(?:\s*|&nbsp;)*\d*:', {

            $FigureIndex++

            "Figure ${FigureIndex}:"
        }

    # ------------------------------------------------------------------------
    # Table labels
    # ------------------------------------------------------------------------

    $TableIndex = 0

    $Html = $Html -replace `
        '\bTable(?:\s*|&nbsp;)*\d*:', {

            $TableIndex++

            "Table ${TableIndex}:"
        }

    # ------------------------------------------------------------------------
    # Code labels
    # ------------------------------------------------------------------------

    $CodeIndex = 0

    $Html = $Html -replace `
        '\bCode(?:\s*|&nbsp;)*\d*:', {

            $CodeIndex++

            "Code ${CodeIndex}:"
        }

    return $Html
}


function Save-NormalizedHtml {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true)]
        [string]$InputPath,

        [Parameter(Mandatory = $true)]
        [string]$OutputPath

    )

    if (-not (Test-Path -LiteralPath $InputPath)) {

        throw "HTML input file not found: $InputPath"
    }

    $Html = Get-Content `
        -LiteralPath $InputPath `
        -Raw `
        -ErrorAction Stop

    $Html = Normalize-HtmlLabels -Html $Html

    $OutputDirectory = Split-Path `
        -Parent `
        $OutputPath

    if (-not (Test-Path -LiteralPath $OutputDirectory)) {

        New-Item `
            -ItemType Directory `
            -Path $OutputDirectory `
            -Force |
            Out-Null
    }

    Set-Content `
        -LiteralPath $OutputPath `
        -Value $Html `
        -Encoding UTF8 `
        -ErrorAction Stop
}