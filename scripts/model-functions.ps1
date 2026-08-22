# ============================================================================
# MODEL PROVIDER FUNCTIONS
# ============================================================================
#
# Maintained for Smart-Home-Edge-Systems.us by ChatGPT.
#
# Purpose:
#   Provides a replaceable interface between the documentation pipeline
#   and the selected AI model.
#
# Initial provider:
#   Ollama
#
# Initial model:
#   qwen2.5:7b
#
# Future providers may include:
#   Gemini
#   OpenAI
#   Other local Ollama models
#
# ============================================================================

function Test-OllamaAvailable {
    $Command = Get-Command ollama -ErrorAction SilentlyContinue

    if (-not $Command) {
        return $false
    }

    return $true
}

function Test-OllamaModel {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModelName
    )

    if (-not (Test-OllamaAvailable)) {
        return $false
    }

    $Output = ollama list 2>$null

    if ($LASTEXITCODE -ne 0) {
        return $false
    }

    foreach ($Line in $Output) {
        if ($Line -match [regex]::Escape($ModelName)) {
            return $true
        }
    }

    return $false
}

function Invoke-OllamaReview {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModelName,

        [Parameter(Mandatory = $true)]
        [string]$Prompt,

        [Parameter(Mandatory = $true)]
        [string]$Document
    )

    if (-not (Test-OllamaAvailable)) {
        throw "Ollama was not found in PATH."
    }

    if (-not (Test-OllamaModel -ModelName $ModelName)) {
        throw "Ollama model was not found: $ModelName"
    }

    $Request = @(
        $Prompt,
        "",
        "======================================================================",
        "DOCUMENT TO REVIEW",
        "======================================================================",
        "",
        $Document
    ) -join "`r`n"

    Write-Host "--> Sending document to Ollama." -ForegroundColor Cyan
    Write-Host "--> Model: $ModelName" -ForegroundColor DarkCyan

    $Output = $Request | ollama run $ModelName 2>&1

    $ExitCode = $LASTEXITCODE

    if ($ExitCode -ne 0) {
        throw "Ollama returned exit code $ExitCode."
    }

    $Result = ($Output -join "`r`n").Trim()

    if ([string]::IsNullOrWhiteSpace($Result)) {
        throw "Ollama returned an empty response."
    }

    return $Result
}

function Invoke-ModelReview {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("ollama", "gemini")]
        [string]$Provider,

        [Parameter(Mandatory = $true)]
        [string]$ModelName,

        [Parameter(Mandatory = $true)]
        [string]$Prompt,

        [Parameter(Mandatory = $true)]
        [string]$Document
    )

    switch ($Provider.ToLower()) {

        "ollama" {
            return Invoke-OllamaReview `
                -ModelName $ModelName `
                -Prompt $Prompt `
                -Document $Document
        }

        "gemini" {
            throw "Gemini provider is reserved for a later release."
        }

        default {
            throw "Unsupported model provider: $Provider"
        }
    }
}

