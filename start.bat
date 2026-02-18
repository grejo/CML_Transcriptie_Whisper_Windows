@echo off
title CML Transcriptie Tool - Setup
chcp 65001 >nul 2>&1

echo.
echo ============================================
echo   CML Transcriptie Tool - Setup
echo ============================================
echo.

REM Ga naar de map waar dit script staat
cd /d "%~dp0"

REM 1. Check/installeer Python
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo Python niet gevonden, installatie wordt geprobeerd via winget...
    echo.
    winget install --id Python.Python.3.11 --accept-source-agreements --accept-package-agreements
    if %errorlevel% neq 0 (
        echo.
        echo FOUT: Python kon niet automatisch geinstalleerd worden.
        echo.
        echo Installeer Python handmatig:
        echo   1. Download van https://www.python.org/downloads/
        echo   2. Zorg ervoor dat je "Add Python to PATH" aanvinkt
        echo   OF voer uit: winget install Python.Python.3.11
        echo.
        pause
        exit /b 1
    )
    echo.
    echo [OK] Python geinstalleerd via winget
    echo.
    echo BELANGRIJK: Sluit dit venster en dubbelklik opnieuw op start.bat
    echo zodat Python correct in het PATH wordt geladen.
    echo.
    pause
    exit /b 0
)
for /f "tokens=*" %%i in ('python --version 2^>^&1') do set PYVER=%%i
echo [OK] %PYVER%

REM 2. Check ffmpeg
where ffmpeg >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ffmpeg niet gevonden, installatie wordt geprobeerd...
    winget install --id Gyan.FFmpeg --accept-source-agreements --accept-package-agreements >nul 2>&1
    if %errorlevel% neq 0 (
        echo.
        echo FOUT: ffmpeg kon niet automatisch geinstalleerd worden.
        echo.
        echo Installeer ffmpeg handmatig:
        echo   1. Download van https://www.gyan.dev/ffmpeg/builds/
        echo   2. Pak uit en voeg de bin-map toe aan je PATH
        echo   OF voer uit: winget install ffmpeg
        echo.
        pause
        exit /b 1
    )
    echo [OK] ffmpeg geinstalleerd via winget
    REM Refresh PATH na installatie
    set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WinGet\Links"
) else (
    echo [OK] ffmpeg gevonden
)

REM 3. Maak venv als die niet bestaat
if not exist "venv" (
    echo.
    echo Virtuele omgeving aanmaken...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo FOUT: Kon virtuele omgeving niet aanmaken.
        pause
        exit /b 1
    )
    echo [OK] Virtuele omgeving aangemaakt
)

REM 4. Activeer venv
call venv\Scripts\activate.bat
echo [OK] Virtuele omgeving geactiveerd

REM 5. Check/installeer dependencies
python -c "import whisperx" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo Afhankelijkheden installeren...
    echo (Dit kan enkele minuten duren bij eerste gebruik)
    echo.
    pip install --upgrade pip --quiet
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo.
        echo FOUT: Installatie van afhankelijkheden mislukt.
        pause
        exit /b 1
    )
    echo.
    echo [OK] Alle afhankelijkheden geinstalleerd
)

echo.
echo ============================================
echo.

REM 6. Start de transcriptietool
python transcribe.py

REM 7. Houd venster open
echo.
pause
