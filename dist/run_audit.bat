@echo off
title Windows Compliance Auditor Launcher
:: ============================================================
:: Portable Windows Compliance Auditor - Run As Admin Script
:: ============================================================

:: 1. Check for Administrative Privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [INFO] Running with Administrator privileges...
    
    rem Go to the directory of this batch script (on the USB drive)
    cd /d "%~dp0"
    
    rem Run the compiled auditor program with auto export flag
    WindowsAuditor.exe --export
    
    echo.
    echo ============================================================
    echo [INFO] Scan complete. You can safely close this window.
    echo ============================================================
    pause
) else (
    echo [INFO] Requesting Administrator privileges (UAC Prompt)...
    
    rem Re-launch this script and request RunAs (Admin elevation)
    powershell -Command "Start-Process -FilePath '%~0' -Verb RunAs"
)
