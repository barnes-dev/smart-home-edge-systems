[CmdletBinding()]
param(
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$DocBaseName = $null,

    [Parameter(Mandatory = $false, Position = 1)]
    [ValidateSet("guides", "reference")]
    [string]$TargetFolder = $null
)

$HomeLabRootDir  = "C:\Users\barne\Documents\HomeAssistant\Proxmox\Web Design\smart-home-edge-systems\home-lab"
$BaseAssetDir    = Join-Path $HomeLabRootDir "assets\figures"

if (-not [string]::IsNullOrEmpty($DocBaseName)) {
    $NormalizedPath = $DocBaseName.Replace('/', '\').Trim('\')
    
    if ($NormalizedPath -match "^(guides|reference)\\(.*)$") {
        $FolderContext = $Matches[1]
        $DocBaseName   = $Matches[2]
    } elseif (-not [string]::IsNullOrEmpty($TargetFolder)) {
        $FolderContext = $TargetFolder
    } else {
        $FolderContext = "reference"
    }

    $SourceDocxDir = Join-Path $PSScriptRoot $FolderContext
    $InputDocx     = Join-Path $SourceDocxDir "${DocBaseName}.docx"
}

if ([string]::IsNullOrEmpty($DocBaseName)) {
    Write-Host "--> No file specified. Scanning sequentially through target environments..." -ForegroundColor Cyan
    $ScanTargets = @("guides", "reference")

    foreach ($Target in $ScanTargets) {
        $SourceDir = Join-Path $PSScriptRoot $Target
        if (Test-Path $SourceDir) {
            $DocxFiles = Get-ChildItem -Path $SourceDir -Filter "*.docx" -File
            
            if ($DocxFiles) {
                Write-Host "--> Found $($DocxFiles.Count) files in '$Target'. Starting batch process..." -ForegroundColor Green
                foreach ($File in $DocxFiles) {
                    Write-Host "`n==========================================================================" -ForegroundColor Gray
                    Write-Host " PROCESSING [$Target]: $($File.BaseName)" -ForegroundColor Yellow -BackgroundColor DarkGreen
                    Write-Host "==========================================================================" -ForegroundColor Gray
                    & $MyInvocation.MyCommand.Path -DocBaseName $File.BaseName -TargetFolder $Target
                }
            } else {
                Write-Host "--> No .docx files found in '$Target' folder." -ForegroundColor Gray
            }
        }
    }
    Write-Host "`nSUCCESS: All environments and batch files processed!" -ForegroundColor Green
    return
}

$OutputGuidesDir = Join-Path $HomeLabRootDir $FolderContext
$TempMarkdown    = Join-Path $PSScriptRoot "${DocBaseName}-temp.md"
$FinalHtml       = Join-Path $PSScriptRoot "${DocBaseName}.html"

$SubFolderName   = $DocBaseName.Trim().ToLower() -replace '\s+', '-'
$SubFolderName   = $SubFolderName -replace '[^a-zA-Z0-9-]', ''
$TargetAssetDir  = [System.IO.Path]::GetFullPath((Join-Path $BaseAssetDir $SubFolderName))
$WebAssetPath    = "../assets/figures/$SubFolderName"

if (-not (Test-Path $InputDocx)) {
    Write-Error "CRITICAL: The source document '$InputDocx' was not found in the '$FolderContext' directory."
    return
}

$TextInfo = (Get-Culture).TextInfo
$CleanBaseString = $DocBaseName -replace '[-_]', ' '
$StandardTitleCase = $TextInfo.ToTitleCase($CleanBaseString)

$Acronyms = @("Dns", "Lxc", "Haos", "Vm", "Ip", "Igpu", "Nginx", "Nas", "Ssh")
$Words = $StandardTitleCase -split ' '

for ($i = 0; $i -lt $Words.Count; $i++) {
    if ($Acronyms -contains $Words[$i]) {
        $Words[$i] = $Words[$i].ToUpper()
    }
}
$ExtractedTitle = $Words -join ' '
Write-Host "--> Dynamic Parameter Title applied: '$ExtractedTitle'" -ForegroundColor Green

Write-Host "--> Converting $InputDocx to Markdown and extracting media..." -ForegroundColor Cyan

$ExistedBeforeRun = Test-Path $TargetAssetDir
if ($ExistedBeforeRun) {
    $FolderContents = Get-ChildItem -Path $TargetAssetDir -Force
    if ($FolderContents) {
        Write-Host "--> Clearing existing files inside: $TargetAssetDir" -ForegroundColor DarkYellow
        Remove-Item (Join-Path $TargetAssetDir "*") -Recurse -Force
    }
}

pandoc $InputDocx -f docx -t markdown --extract-media=$TargetAssetDir -o $TempMarkdown

$PandocNestedMedia = Join-Path $TargetAssetDir "media"
$HasImages = Test-Path $PandocNestedMedia

if (-not $HasImages) {
    Write-Host "--> No images extracted by Pandoc." -ForegroundColor DarkYellow
    if (-not $ExistedBeforeRun -and (Test-Path $TargetAssetDir)) {
        Write-Host "--> Removing empty asset directory: $TargetAssetDir" -ForegroundColor DarkYellow
        Remove-Item $TargetAssetDir -Force
    }
}

Write-Host "--> Compiling HTML with Pandoc templates..." -ForegroundColor Cyan
$PandocArgs = @(
    $TempMarkdown,
    "-f", "markdown",
    "-t", "html5",
    "--template=template.html",
    "--metadata", "title=$ExtractedTitle",
    "--standalone",
    "--toc",
    "--toc-depth=4",
    "--id-prefix=nav-",
    "-o", $FinalHtml
)
pandoc @PandocArgs

Write-Host "--> Isolating document content container blocks..." -ForegroundColor Cyan
$HtmlContent = Get-Content $FinalHtml -Raw
$MarkdownContent = Get-Content $TempMarkdown -Raw

if ($HtmlContent -match "(?s)(.*<article class=`"document-content`"[^>]*>)(.*)(</article>.*)") {
    $PreContent  = $Matches[1]
    $BodyContent = $Matches[2]
    $PostContent = $Matches[3]

    $script:FigIdx = 1
    $script:TableIdx = 1
    $script:CodeIdx = 1

    $BodyContent = ([regex]"\bFigure(?:\s*|&nbsp;)*\d*:").Replace($BodyContent, { "Figure $($script:FigIdx):"; $script:FigIdx++ })
    $BodyContent = ([regex]"\bTable(?:\s*|&nbsp;)*\d*:").Replace($BodyContent, { "Table $($script:TableIdx):"; $script:TableIdx++ })
    $BodyContent = ([regex]"\bCode(?:\s*|&nbsp;)*\d*:").Replace($BodyContent, { "Code $($script:CodeIdx):"; $script:CodeIdx++ })

    $HtmlContent = $PreContent + $BodyContent + $PostContent
}

if ($HtmlContent -match "<title>\s*</title>") {
    $HtmlContent = $HtmlContent -replace "<title>\s*</title>", "<title>$ExtractedTitle</title>"
}

if ($HasImages) {
    Write-Host "--> Processing extracted images..." -ForegroundColor Cyan
    $ExtractedFiles = Get-ChildItem -Path $PandocNestedMedia -File | Sort-Object Name
    $ImageIndex = 1
    $ProcessedBaseNames = @{}

    foreach ($File in $ExtractedFiles) {
        $OriginalName = $File.Name
        $Extension = $File.Extension
        $TargetFileName = $OriginalName

        $EscapedDir = [Regex]::Escape($TargetAssetDir) -replace '\\\\', '[/\\\\]'
        $EscapedFile = [Regex]::Escape($OriginalName)
        $MdPattern = "!\[([^\]]*)\]\(${EscapedDir}[/\\\\]media[/\\\\]${EscapedFile}\)"

        if ($MarkdownContent -match $MdPattern) {
            $CaptionText = $Matches[1].Trim()
            if ($CaptionText) {
                $FullCaption = "Figure-${ImageIndex}-${CaptionText}"
                $CleanName = $FullCaption -replace '[^a-zA-Z0-9-]', ''
                $TargetFileName = "${CleanName}${Extension}"
            }
        }

        if ($ProcessedBaseNames.ContainsKey($TargetFileName)) {
            Write-Warning "--> Internal Duplicate Name Detected. Appending unique suffix."
            $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($TargetFileName)
            $TargetFileName = "${BaseName}-1${Extension}"
        } else {
            $ProcessedBaseNames[$TargetFileName] = $true
        }

        $FinalDestinationFile = Join-Path $TargetAssetDir $TargetFileName
        Move-Item -Path $File.FullName -Destination $FinalDestinationFile -Force

        $OldHtmlSrcPattern = 'src="[^"]*' + [Regex]::Escape("media/$OriginalName") + '"'
        $NewHtmlSrc = "src=`"$WebAssetPath/$TargetFileName`""
        $HtmlContent = $HtmlContent -replace $OldHtmlSrcPattern, $NewHtmlSrc

        $ImageIndex++
    }
    Remove-Item $PandocNestedMedia -Recurse -Force
}

$CleanWebAssetPath = $WebAssetPath -replace '\\', '/'
$HtmlContent = [Regex]::Replace($HtmlContent, 'src="[^"]*/assets/figures/[^"]*/media/([^"]+)"', "src=`"$CleanWebAssetPath/`$1`"")
$HtmlContent | Set-Content $FinalHtml

Write-Host "--> Deploying page file to final target context directory..." -ForegroundColor Cyan
if (-not (Test-Path $OutputGuidesDir)) {
    New-Item -ItemType Directory -Path $OutputGuidesDir -Force | Out-Null
}

$HtmlDestination = Join-Path $OutputGuidesDir "${DocBaseName}.html"
Move-Item -Path $FinalHtml -Destination $HtmlDestination -Force

Write-Host "--> Build complete. Clean workspace teardown processing..." -ForegroundColor Cyan
if (Test-Path $TempMarkdown) { Remove-Item $TempMarkdown -Force }

Write-Host "SUCCESS: Workspace scrubbed. Acronym mappings applied successfully!" -ForegroundColor Green
