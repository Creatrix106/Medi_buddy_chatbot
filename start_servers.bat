@echo off
echo Starting Medi Buddy Chatbot...
echo.

echo Starting Backend Server (Flask)...
cd "Medi_Buddy_Chatbot Backend"
start "Backend Server" cmd /k "python app.py"

echo.
echo Starting Frontend Server (Node.js)...
cd ".."
start "Frontend Server" cmd /k "npm run dev"

echo.
echo Both servers are starting...
echo Backend: http://localhost:5000
echo Frontend: http://localhost:3000
echo.
echo Press any key to exit...
pause > nul 