@echo off
title Check HostGator Server
color 0B
echo.
echo ========================================
echo   CHECK HOSTGATOR SERVER FILES
echo ========================================
echo.
echo This will connect to your HostGator server
echo and show you what files are there.
echo.
echo You'll need:
echo   - Your domain name
echo   - Your cPanel password
echo.
pause
echo.
powershell.exe -ExecutionPolicy Bypass -File "%~dp0CHECK_HOSTGATOR_SERVER.ps1"

