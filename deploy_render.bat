@echo off
echo ========================================
echo    Medi Buddy Chatbot Deployment
echo ========================================
echo.

echo Step 1: Prepare for Deployment
echo ------------------------------
echo 1. Make sure your code is pushed to GitHub
echo 2. Get your OpenAI API key ready
echo 3. Have your GitHub account ready
echo.

echo Step 2: Deploy to Render
echo -------------------------
echo 1. Go to: https://render.com
echo 2. Sign up/Login with GitHub
echo 3. Click "New +" → "Web Service"
echo 4. Connect your GitHub repository
echo.

echo Backend Configuration:
echo - Name: medi-buddy-backend
echo - Environment: Python 3
echo - Build Command: pip install -r requirements.txt
echo - Start Command: gunicorn app:app
echo - Root Directory: Medi_Buddy_Chatbot Backend
echo.

echo Environment Variables for Backend:
echo - OPENAI_API_KEY: Your OpenAI API key
echo - SECRET_KEY: Generate a random string
echo.

echo Frontend Configuration:
echo - Name: medi-buddy-frontend
echo - Environment: Node
echo - Build Command: npm install
echo - Start Command: npm start
echo - Root Directory: Medi_buddy_chatbot-frontend
echo.

echo Environment Variables for Frontend:
echo - BACKEND_URL: Your backend URL (e.g., https://medi-buddy-backend.onrender.com)
echo.

echo Step 3: Test Your Deployment
echo -----------------------------
echo 1. Wait for both services to deploy
echo 2. Test the health endpoint: https://your-backend-url/health
echo 3. Test the frontend: https://your-frontend-url
echo.

echo Need help? Check DEPLOYMENT.md for detailed instructions
echo.
pause 