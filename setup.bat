@echo off
REM ========================================
REM Multimodal AI Assistant - Quick Start
REM ========================================
echo.
echo ========================================
echo Multimodal AI Assistant - Setup
echo ========================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not installed. Visit: https://www.python.org
    pause
    exit /b 1
)

REM Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not installed. Visit: https://nodejs.org
    pause
    exit /b 1
)

REM Check .env file
if not exist ".env" (
    echo.
    echo ⚠️  .env file not found!
    echo Creating from .env.example...
    copy .env.example .env
    echo.
    echo ⚠️  IMPORTANT: Edit .env and add your HuggingFace API key:
    echo    HF_API_KEY=hf_your_token_here
    echo    Get free token from: https://huggingface.co/settings/tokens
    echo.
    pause
)

REM Backend setup
echo.
echo [1/3] Setting up backend...
cd backend
if not exist "venv" (
    python -m venv venv
    call venv\Scripts\activate.bat
    pip install -r requirements.txt
) else (
    call venv\Scripts\activate.bat
)
cd ..

REM Frontend setup
echo [2/3] Setting up frontend...
cd frontend
if not exist "node_modules" (
    call npm install
)
cd ..

echo.
echo [3/3] Setup complete!
echo.
echo ========================================
echo Starting services...
echo ========================================
echo.
echo To run the application:
echo.
echo Terminal 1 - Backend:
echo   cd backend
echo   venv\Scripts\activate.bat
echo   uvicorn main:app --reload
echo.
echo Terminal 2 - Frontend:
echo   cd frontend
echo   npm run dev
echo.
echo Frontend: http://localhost:5173
echo Backend API: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
pause
