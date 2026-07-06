@echo off
title Windows Compliance Auditor
setlocal

:: ── Step 1: Move to the script's own directory (USB Drive root) ──
cd /d "%~dp0"

:: ── Step 2: Check for Administrator rights ──────────────────────
net session >nul 2>&1
if %errorLevel% == 0 goto :RUN_AUDIT

:: ── Not Admin: Re-launch self with UAC elevation ─────────────────
echo  [INFO] Requesting Administrator privileges...
powershell -Command "Start-Process -FilePath '%~0' -Verb RunAs"
exit /b

:: ── Admin: Run the auditor ───────────────────────────────────────
:RUN_AUDIT
echo.
echo  +------------------------------------------------------+
echo  ^|   Portable Windows Compliance Auditor  v1.0         ^|
echo  ^|   Starting scan... Please wait.                     ^|
echo  +------------------------------------------------------+
echo.

WindowsAuditor.exe --export

echo.
echo  +------------------------------------------------------+
echo  ^|   Scan complete! Reports saved to reports/           ^|
echo  +------------------------------------------------------+
echo.
pause
