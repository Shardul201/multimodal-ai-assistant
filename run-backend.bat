@echo off
setlocal enabledelayedexpansion

REM ========================================
REM Run Backend - Multimodal AI Assistant
REM ========================================

cd /d "%~dp0backend"

echo ========================================
echo Starting Multimodal AI Assistant Backend
echo ========================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not installed from https://www.python.org
    pause
    exit /b 1
)

REM Create and activate venv
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate venv
call venv\Scripts\activate.bat

REM Install dependencies if needed
if not exist "venv\Lib\site-packages\fastapi" (
    echo Installing dependencies...
    pip install -r requirements.txt
)

REM Check for HF_API_KEY
if "%HF_API_KEY%"=="" (
    echo.
    echo WARNING: HF_API_KEY not set!
    echo Please set: set HF_API_KEY=your_key_here
    echo Get free key from: https://huggingface.co/settings/tokens
    echo.
)

set PORT=8000
echo.
echo Starting backend on http://localhost:%PORT%
echo API Docs: http://localhost:%PORT%/docs
echo.

REM Start with uvicorn
uvicorn main:app --reload --port %PORT%

pause
