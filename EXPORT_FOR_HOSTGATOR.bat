@echo off
title Export Bong Store for HostGator
echo.
echo ========================================
echo   EXPORT BONG STORE FOR HOSTGATOR
echo ========================================
echo.
echo This will create a zip file of your Age Verification plugin
echo that you can upload to HostGator.
echo.
pause
echo.
echo Creating plugin zip file...
echo.

cd wp-content\plugins
powershell Compress-Archive -Path age-verification -DestinationPath ..\..\age-verification.zip -Force

cd ..\..

echo.
echo ========================================
echo   EXPORT COMPLETE!
echo ========================================
echo.
echo Plugin exported to: age-verification.zip
echo.
echo Next steps:
echo 1. Open HostGator cPanel
echo 2. Install WordPress (via Softaculous)
echo 3. Install WooCommerce
echo 4. Upload age-verification.zip via Plugins menu
echo 5. Follow the guide in docs\HOSTGATOR_DEPLOYMENT.md
echo.
echo Opening deployment guide...
timeout /t 3 /nobreak >nul
start docs\HOSTGATOR_DEPLOYMENT.md
echo.
pause

