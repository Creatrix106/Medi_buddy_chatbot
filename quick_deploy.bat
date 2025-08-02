@echo off
echo ========================================
echo    QUICK DEPLOYMENT GUIDE
echo ========================================
echo.

echo 📋 STEP 1: Get OpenAI API Key
echo ------------------------------
echo 1. Go to: https://platform.openai.com
echo 2. Sign up/Login
echo 3. Go to "API Keys"
echo 4. Click "Create new secret key"
echo 5. Copy the key (starts with sk-)
echo.

echo 🔧 STEP 2: Deploy to Render (Recommended)
echo -----------------------------------------
echo 1. Go to: https://render.com
echo 2. Sign up with GitHub
echo 3. Click "New +" → "Web Service"
echo 4. Connect repository: Creatrix106/Medi_buddy_chatbot
echo.

echo 📦 STEP 3: Deploy Backend
echo --------------------------
echo 1. Create backend service
echo 2. Configure:
echo    - Name: medi-buddy-backend
echo    - Environment: Python 3
echo    - Build Command: pip install -r requirements.txt
echo    - Start Command: gunicorn app:app
echo    - Root Directory: Medi_Buddy_Chatbot Backend
echo.
echo 3. Environment Variables:
echo    - OPENAI_API_KEY = your API key from step 1
echo    - SECRET_KEY = af0785f0283c049e88cd2f61c0e9dbaef6495a4d120085866915e1210590b47c
echo.

echo 🌐 STEP 4: Deploy Frontend
echo ---------------------------
echo 1. Create another web service
echo 2. Configure:
echo    - Name: medi-buddy-frontend
echo    - Environment: Node
echo    - Build Command: npm install
echo    - Start Command: npm start
echo    - Root Directory: Medi_buddy_chatbot-frontend
echo.
echo 3. Environment Variables:
echo    - BACKEND_URL = your backend URL (e.g., https://medi-buddy-backend.onrender.com)
echo    - NODE_ENV = production
echo.

echo ✅ STEP 5: Test Your Deployment
echo --------------------------------
echo 1. Wait for both services to deploy
echo 2. Visit your frontend URL
echo 3. Test the chatbot
echo 4. Check logs if there are issues
echo.

echo 📁 Your Environment Variables:
echo ------------------------------
echo BACKEND:
echo - OPENAI_API_KEY = (get from OpenAI)
echo - SECRET_KEY = af0785f0283c049e88cd2f61c0e9dbaef6495a4d120085866915e1210590b47c
echo.
echo FRONTEND:
echo - BACKEND_URL = (your backend URL after deployment)
echo - NODE_ENV = production
echo.

echo 📖 For detailed instructions, see:
echo - DEPLOYMENT.md
echo - deployment_env_vars.txt
echo.

pause 