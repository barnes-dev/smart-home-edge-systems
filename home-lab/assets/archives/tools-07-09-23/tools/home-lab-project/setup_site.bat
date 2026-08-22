@echo off
setlocal enabledelayedexpansion

:: Save the exact folder where this script is running from (%~dp0 includes a trailing \)
set "SCRIPT_SRC=%~dp0"

:: --- set the working directory that you want to use
set "TARGET_DIR=C:\Users\barne\Documents\HomeAssistant\Proxmox\WebDesign\smart-home-edge-systems"

:: --- what domain name are you going to use
set "DOMAIN=smart-home-edge-systems.us"

:: Define the list of main categories
set "CATEGORIES=3d-printing home-assistant home-lab marketing media r-d storage surveillance voice"

echo ===================================================
echo       SMART HOME EDGE SYSTEMS MASTER MATRIX SETUP
echo ===================================================
echo.
echo Running from parent folder location...
echo Target Directory: %TARGET_DIR%
echo.
pause

:: 1. Force wipe the target project folder safely from the outside
if exist "%TARGET_DIR%" (
    echo Wiping existing project directory contents...
    rmdir /s /q "%TARGET_DIR%"
)

:: 2. Recreate the fresh project folder
echo Creating pristine project workspace...
mkdir "%TARGET_DIR%"

:: --- MOVE TO THE NEW DIRECTORY MATRIX ---
cd /d "%TARGET_DIR%"

:: --- CORE DIRECTORY MATRIX STRUCTURE ---
mkdir ".github\workflows" 2>NUL
mkdir "authors" 2>NUL
mkdir "styles" 2>NUL
mkdir "includes" 2>NUL
mkdir "assets\icons" 2>NUL
mkdir "assets\figures" 2>NUL


if exist "%SCRIPT_SRC%sample-files\*.html" (
    move /y "%SCRIPT_SRC%sample-files\*.html" "includes\" >nul
)

:: --- PLACEHOLDER ENGINE GENERATION ---
type nul > "index.html"
type nul > "404.html"
type nul > "robots.txt"
type nul > "sitemap.xml"

type nul > "styles\global.css"
type nul > "authors\index.html"

:: Loop through each category
for %%C in (%CATEGORIES%) do (
    echo Creating directories for: %%C
    
    :: Create the subdirectories
    mkdir "%%C\guides" 2>NUL
    mkdir "%%C\reference" 2>NUL
    mkdir "%%C\assets\figures" 2>NUL
    mkdir "%%C\assets\icons" 2>NUL
    
    :: Create internal files
    type nul > "%%C\guides\index.html"
    type nul > "%%C\reference\index.html"
    type nul > "%%C\index.html"
)

:: --- GENERATE SYSTEM DOMAIN RULE FILTERS ---
echo %DOMAIN%> CNAME

:: --- SYSTEM GENERATED .GITIGNORE RULES ---
(
echo # Logs and system dumps
echo *.log
echo .DS_Store
echo Thumbs.db
echo.
echo # Backup and configuration assets to avoid tracking
echo *.bak
echo *.config
echo .env
echo.
echo # Proxmox / Home Assistant backup dumps
echo *.tar.gz
echo *.backup
) > .gitignore

:: --- LAUNCH VISUAL STUDIO CODE ---
echo.
echo Launching Visual Studio Code inside target workspace...
start "" code .

echo.
echo Framework ready! This script will now auto-close.
timeout /t 3
exit