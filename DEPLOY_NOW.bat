@echo off
title Deploy Bong Store to HostGator
color 0A
echo.
echo ========================================
echo   DEPLOY BONG STORE TO HOSTGATOR
echo ========================================
echo.
echo Your SSH key is ready on the server!
echo.
echo Choose deployment method:
echo.
echo [1] Deploy with PASSWORD (Easiest - Recommended)
echo [2] Deploy with SSH KEY (Advanced)
echo [3] View Setup Guide
echo [4] Cancel
echo.
choice /c 1234 /n /m "Enter your choice (1-4): "

if errorlevel 4 goto :cancel
if errorlevel 3 goto :guide
if errorlevel 2 goto :sshkey
if errorlevel 1 goto :password

:password
echo.
echo Starting deployment with password authentication...
echo.
echo You'll need:
echo   - Your HostGator domain name
echo   - Your cPanel password
echo.
pause
powershell.exe -ExecutionPolicy Bypass -File "%~dp0DEPLOY_WITH_PASSWORD.ps1"
goto :end

:sshkey
echo.
echo Starting deployment with SSH key...
echo.
echo Make sure you've downloaded your SSH key first!
echo See GET_SSH_KEY.md for instructions.
echo.
pause
powershell.exe -ExecutionPolicy Bypass -File "%~dp0DEPLOY_TO_HOSTGATOR.ps1"
goto :end

:guide
echo.
echo Opening setup guide...
start "" "%~dp0GET_SSH_KEY.md"
echo.
echo After reviewing the guide, run this script again.
echo.
pause
goto :end

:cancel
echo.
echo Deployment cancelled.
echo.
pause
goto :end

:end

