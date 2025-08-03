#!/bin/bash

echo "Starting Medi Buddy Chatbot..."
echo

echo "Starting Backend Server (Flask)..."
cd "Medi_Buddy_Chatbot Backend"
gnome-terminal --title="Backend Server" -- bash -c "python app.py; exec bash" &

echo
echo "Starting Frontend Server (Node.js)..."
cd ".."
gnome-terminal --title="Frontend Server" -- bash -c "npm run dev; exec bash" &

echo
echo "Both servers are starting..."
echo "Backend: http://localhost:5000"
echo "Frontend: http://localhost:3000"
echo
echo "Press Ctrl+C to stop all servers"
wait 