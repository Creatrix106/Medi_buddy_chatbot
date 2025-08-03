#!/bin/bash

echo "========================================"
echo "Medi Buddy Chatbot Setup"
echo "========================================"
echo

echo "Checking prerequisites..."
echo

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed"
    echo "Please install Python 3.8+ from https://python.org"
    exit 1
else
    echo "✓ Python 3 is installed"
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js is not installed"
    echo "Please install Node.js 14+ from https://nodejs.org"
    exit 1
else
    echo "✓ Node.js is installed"
fi

echo
echo "Setting up backend..."
cd "Medi_Buddy_Chatbot Backend"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment and install dependencies
echo "Activating virtual environment and installing dependencies..."
source venv/bin/activate
pip install -r requirements.txt

echo
echo "Setting up frontend..."
cd ".."
echo "Installing Node.js dependencies..."
npm install

echo
echo "========================================"
echo "Setup Complete!"
echo "========================================"
echo
echo "IMPORTANT: Before running the application:"
echo "1. Edit 'Medi_Buddy_Chatbot Backend/api.env'"
echo "2. Add your OpenAI API key"
echo "3. Run './start_servers.sh' to start both servers"
echo
echo "Backend will run on: http://localhost:5000"
echo "Frontend will run on: http://localhost:3000"
echo 