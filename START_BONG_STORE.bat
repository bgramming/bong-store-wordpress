@echo off
title Bong Store WordPress - Quick Start
echo.
echo ========================================
echo   BONG STORE WORDPRESS
echo   Quick Start Script
echo ========================================
echo.
echo Starting Docker containers...
echo.

docker-compose up -d

echo.
echo ========================================
echo   CONTAINERS STARTED!
echo ========================================
echo.
echo Your Bong Store is now running at:
echo.
echo   Frontend:    http://localhost:8080
echo   Admin:       http://localhost:8080/wp-admin
echo   phpMyAdmin:  http://localhost:8081
echo.
echo Default WordPress credentials:
echo   Username: admin
echo   Password: (set during installation)
echo.
echo ========================================
echo.
echo Opening browser...
timeout /t 3 /nobreak >nul
start http://localhost:8080
echo.
echo To stop the store, run: docker-compose down
echo.
pause

