@echo off
title Setup Burning Beats Store
color 0A
echo.
echo ========================================
echo   SETUP BURNINGBEATS.STORE
echo ========================================
echo.
echo This will configure your live store:
echo   - Activate Age Verification plugin
echo   - Configure WooCommerce
echo   - Create product categories
echo   - Set up shop pages
echo.
echo Site: https://burningbeats.store
echo.
pause
echo.
powershell.exe -ExecutionPolicy Bypass -File "%~dp0SETUP_LIVE_STORE.ps1"

