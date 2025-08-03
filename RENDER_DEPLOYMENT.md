# Render Deployment Guide for Medi Buddy Chatbot

## 🚀 Step-by-Step Deployment Instructions

### Prerequisites
- GitHub repository with your code
- Gemini API key (from Google AI Studio)
- Render account (free tier available)

## 📋 Backend Deployment (Flask)

### 1. Create Backend Service on Render

1. **Go to Render Dashboard**
   - Visit: https://dashboard.render.com
   - Sign up/Login with GitHub

2. **Create New Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository

3. **Configure Backend Service**
   ```
   Name: medi-buddy-backend
   Root Directory: Medi_Buddy_Chatbot Backend
   Environment: Python 3
   Build Command: pip install -r requirements.txt
   Start Command: gunicorn app:app
   ```

4. **Set Environment Variables**
   - Go to "Environment" tab
   - Add these variables:
   ```
   GEMINI_API_KEY = your_actual_gemini_api_key_here
   SECRET_KEY = af0785f0283c049e88cd2f61c0e9dbaef6495a4d120085866915e1210590b47c
   PYTHON_VERSION = 3.10.12
   ```

5. **Deploy Backend**
   - Click "Create Web Service"
   - Wait for deployment to complete
   - Note the URL (e.g., `https://medi-buddy-backend.onrender.com`)

## 📋 Frontend Deployment (Node.js)

### 2. Create Frontend Service on Render

1. **Create Another Web Service**
   - Click "New +" → "Web Service"
   - Connect the same GitHub repository

2. **Configure Frontend Service**
   ```
   Name: medi-buddy-frontend
   Root Directory: . (root of repository)
   Environment: Node
   Build Command: npm install
   Start Command: npm start
   ```

3. **Set Environment Variables**
   ```
   NODE_ENV = production
   BACKEND_URL = https://your-backend-url.onrender.com
   ```

4. **Deploy Frontend**
   - Click "Create Web Service"
   - Wait for deployment to complete
   - Note the URL (e.g., `https://medi-buddy-frontend.onrender.com`)

## 🔧 Environment Variables Reference

### Backend Variables
```bash
GEMINI_API_KEY=your-actual-gemini-api-key-here
SECRET_KEY=af0785f0283c049e88cd2f61c0e9dbaef6495a4d120085866915e1210590b47c
PYTHON_VERSION=3.10.12
```

### Frontend Variables
```bash
NODE_ENV=production
BACKEND_URL=https://your-backend-service-url.onrender.com
```

## 🐛 Troubleshooting

### Common Issues

1. **Gemini API Error**
   - ✅ Ensure `GEMINI_API_KEY` is set correctly in backend environment
   - ✅ Check that the API key is valid from Google AI Studio
   - ✅ Verify you have credits in your Google AI account

2. **CORS Error**
   - ✅ Backend CORS is configured for Render domains
   - ✅ Frontend `BACKEND_URL` points to correct backend URL

3. **Build Failures**
   - ✅ Check that `requirements.txt` is in the backend directory
   - ✅ Verify `package.json` is in the root directory
   - ✅ Ensure all dependencies are listed correctly

4. **Connection Timeout**
   - ✅ Both services are deployed and running
   - ✅ Environment variables are set correctly
   - ✅ Check Render logs for specific errors

### Health Checks

Test these URLs after deployment:

**Backend Health Check:**
```
https://your-backend-url.onrender.com/health
```

**Frontend Health Check:**
```
https://your-frontend-url.onrender.com/health
```

### Logs and Debugging

1. **View Logs on Render**
   - Go to your service dashboard
   - Click "Logs" tab
   - Check for error messages

2. **Common Log Messages**
   - `Gemini API error`: Check API key and credits
   - `Failed to communicate with Flask`: Check BACKEND_URL
   - `Module not found`: Check requirements.txt and package.json

## 🔄 Redeployment

If you need to redeploy:

1. **Push changes to GitHub**
   ```bash
   git add .
   git commit -m "Fix OpenAI error handling"
   git push origin main
   ```

2. **Redeploy on Render**
   - Render automatically redeploys on git push
   - Or manually trigger from dashboard

## 📊 Monitoring

- **Uptime**: Render provides basic uptime monitoring
- **Logs**: Available in service dashboard
- **Performance**: Monitor response times in logs

## 💰 Cost Estimation

- **Render Free Tier**: 750 hours/month per service
- **OpenAI API**: ~$1-5/month for moderate usage
- **Total**: Free for development/testing

## 🚀 Quick Test

After deployment, test the chatbot:

1. Visit your frontend URL
2. Type a medical question
3. Check if the bot responds correctly
4. Monitor logs for any errors

## 📞 Support

If issues persist:
1. Check Render logs for specific error messages
2. Verify all environment variables are set
3. Test backend health endpoint
4. Check Gemini API key and credits 