@echo off
echo ========================================
echo Medi Buddy Chatbot Setup
echo ========================================
echo.

echo Checking prerequisites...
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.8+ from https://python.org
    pause
    exit /b 1
) else (
    echo ✓ Python is installed
)

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please install Node.js 14+ from https://nodejs.org
    pause
    exit /b 1
) else (
    echo ✓ Node.js is installed
)

echo.
echo Setting up backend...
cd "Medi_Buddy_Chatbot Backend"

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate virtual environment and install dependencies
echo Activating virtual environment and installing dependencies...
call venv\Scripts\activate
pip install -r requirements.txt

echo.
echo Setting up frontend...
cd ".."
echo Installing Node.js dependencies...
npm install

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo IMPORTANT: Before running the application:
echo 1. Edit "Medi_Buddy_Chatbot Backend/api.env"
echo 2. Add your OpenAI API key
echo 3. Run "start_servers.bat" to start both servers
echo.
echo Backend will run on: http://localhost:5000
echo Frontend will run on: http://localhost:3000
echo.
pause 