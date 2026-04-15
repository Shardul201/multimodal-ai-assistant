@echo off
setlocal enabledelayedexpansion

REM ========================================
REM Run Frontend - Multimodal AI Assistant
REM ========================================

cd /d "%~dp0frontend"

echo ========================================
echo Starting Multimodal AI Assistant Frontend
echo ========================================
echo.

REM Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not installed from https://nodejs.org
    pause
    exit /b 1
)

echo Node version:
node --version
echo.

REM Install dependencies
if not exist "node_modules" (
    echo Installing npm dependencies...
    call npm install
    if errorlevel 1 (
        echo ERROR: Failed to install npm packages
        pause
        exit /b 1
    )
)

echo.
echo Starting frontend on http://localhost:5173
echo.

REM Start development server
timeout /t 2 /nobreak
start http://localhost:5173
call npm run dev

pause
