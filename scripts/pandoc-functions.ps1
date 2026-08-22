# ============================================================================
# PANDOC FUNCTIONS
# ============================================================================
#
# Maintained for Smart-Home-Edge-Systems.us by ChatGPT.
#
# Purpose:
#   Isolates all Pandoc operations from the main build script.
#
# ============================================================================

function Convert-DocxToMarkdown {
    param(
        [Parameter(Mandatory = $true)]
        [string]$InputDocx,

        [Parameter(Mandatory = $true)]
        [string]$OutputMarkdown,

        [Parameter(Mandatory = $true)]
        [string]$AssetDirectory
    )

    if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
        throw "Pandoc was not found in PATH."
    }

    if (-not (Test-Path -LiteralPath $InputDocx)) {
        throw "Input DOCX not found: $InputDocx"
    }

    if (-not (Test-Path -LiteralPath $AssetDirectory)) {
        New-Item -ItemType Directory -Path $AssetDirectory -Force | Out-Null
    }

    pandoc `
        $InputDocx `
        -f "docx+styles" `
        -t "markdown" `
        "--extract-media=$AssetDirectory" `
        -o $OutputMarkdown

    $ExitCode = $LASTEXITCODE

    if ($ExitCode -ne 0) {
        throw "Pandoc DOCX to Markdown failed with exit code $ExitCode."
    }

    if (-not (Test-Path -LiteralPath $OutputMarkdown)) {
        throw "Pandoc did not create Markdown output: $OutputMarkdown"
    }
}

function Convert-MarkdownToHtml {
    param(
        [Parameter(Mandatory = $true)]
        [string]$MarkdownFile,

        [Parameter(Mandatory = $true)]
        [string]$OutputHtml,

        [Parameter(Mandatory = $true)]
        [string]$TemplateFile,

        [Parameter(Mandatory = $true)]
        [string]$LuaFilter,

        [Parameter(Mandatory = $true)]
        [string]$Title
    )

    if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
        throw "Pandoc was not found in PATH."
    }

    if (-not (Test-Path -LiteralPath $MarkdownFile)) {
        throw "Markdown file not found: $MarkdownFile"
    }

    if (-not (Test-Path -LiteralPath $TemplateFile)) {
        throw "Pandoc template not found: $TemplateFile"
    }

    if (-not (Test-Path -LiteralPath $LuaFilter)) {
        throw "Pandoc Lua filter not found: $LuaFilter"
    }

    $Arguments = @(
        $MarkdownFile,
        "-f", "markdown+fenced_divs+bracketed_spans",
        "-t", "html5",
        "--template=$TemplateFile",
        "--metadata", "title=$Title",
        "--standalone",
        "--toc",
        "--toc-depth=4",
        "--id-prefix=nav-",
        "--lua-filter=$LuaFilter",
        "-o", $OutputHtml
    )

    pandoc @Arguments

    $ExitCode = $LASTEXITCODE

    if ($ExitCode -ne 0) {
        throw "Pandoc Markdown to HTML failed with exit code $ExitCode."
    }

    if (-not (Test-Path -LiteralPath $OutputHtml)) {
        throw "Pandoc did not create HTML output: $OutputHtml"
    }
}

