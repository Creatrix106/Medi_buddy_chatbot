# 🚀 Deployment Guide

## **Option 1: Render (Recommended - Free)**

### **Step 1: Prepare Your Repository**
1. Push your code to GitHub
2. Make sure all files are committed

### **Step 2: Deploy Backend**
1. Go to [render.com](https://render.com)
2. Sign up/Login with GitHub
3. Click "New +" → "Web Service"
4. Connect your GitHub repository
5. Configure:
   - **Name**: `medi-buddy-backend`
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `gunicorn app:app`
   - **Root Directory**: `Medi_Buddy_Chatbot Backend`

6. **Environment Variables**:
   - `OPENAI_API_KEY`: Your OpenAI API key
   - `SECRET_KEY`: Generate a random string

### **Step 3: Deploy Frontend**
1. Create another web service
2. Configure:
   - **Name**: `medi-buddy-frontend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Root Directory**: `Medi_buddy_chatbot-frontend`

3. **Environment Variables**:
   - `BACKEND_URL`: Your backend URL (e.g., `https://medi-buddy-backend.onrender.com`)

---

## **Option 2: Railway (Free Tier)**

### **Step 1: Deploy Backend**
1. Go to [railway.app](https://railway.app)
2. Sign up with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your repository
5. Set root directory to `Medi_Buddy_Chatbot Backend`
6. Add environment variables:
   - `OPENAI_API_KEY`
   - `SECRET_KEY`

### **Step 2: Deploy Frontend**
1. Create another service
2. Set root directory to `Medi_buddy_chatbot-frontend`
3. Add environment variable:
   - `BACKEND_URL`: Your Railway backend URL

---

## **Option 3: Heroku (Limited Free)**

### **Step 1: Install Heroku CLI**
```bash
# Windows
winget install --id=Heroku.HerokuCLI

# Mac
brew tap heroku/brew && brew install heroku
```

### **Step 2: Deploy Backend**
```bash
cd "Medi_Buddy_Chatbot Backend"
heroku create medi-buddy-backend
heroku config:set OPENAI_API_KEY=your_api_key
git add .
git commit -m "Deploy backend"
git push heroku main
```

### **Step 3: Deploy Frontend**
```bash
cd ../Medi_buddy_chatbot-frontend
heroku create medi-buddy-frontend
heroku config:set BACKEND_URL=https://medi-buddy-backend.herokuapp.com
git add .
git commit -m "Deploy frontend"
git push heroku main
```

---

## **Option 4: DigitalOcean (Paid - $5/month)**

### **Step 1: Create Droplet**
1. Go to [digitalocean.com](https://digitalocean.com)
2. Create a new droplet
3. Choose Ubuntu 20.04
4. Select basic plan ($5/month)

### **Step 2: SSH into Server**
```bash
ssh root@your_server_ip
```

### **Step 3: Install Dependencies**
```bash
# Update system
apt update && apt upgrade -y

# Install Python, Node.js, Nginx
apt install python3 python3-pip nodejs npm nginx -y

# Install PM2 for process management
npm install -g pm2
```

### **Step 4: Deploy Application**
```bash
# Clone your repository
git clone https://github.com/your-username/your-repo.git
cd your-repo

# Setup backend
cd "Medi_Buddy_Chatbot Backend"
pip3 install -r requirements.txt
export OPENAI_API_KEY=your_api_key
export SECRET_KEY=your_secret_key

# Start backend with PM2
pm2 start "gunicorn app:app" --name "medi-buddy-backend"

# Setup frontend
cd ../Medi_buddy_chatbot-frontend
npm install
export BACKEND_URL=http://localhost:5000

# Start frontend with PM2
pm2 start "npm start" --name "medi-buddy-frontend"

# Save PM2 configuration
pm2 save
pm2 startup
```

### **Step 5: Configure Nginx**
```bash
# Create nginx config
cat > /etc/nginx/sites-available/medi-buddy << EOF
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    location /api/ {
        proxy_pass http://localhost:5000/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable site
ln -s /etc/nginx/sites-available/medi-buddy /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
```

---

## **Environment Variables**

### **Backend Required:**
- `OPENAI_API_KEY`: Your OpenAI API key
- `SECRET_KEY`: Random string for session security
- `PORT`: Port number (usually auto-set by hosting platform)

### **Frontend Required:**
- `BACKEND_URL`: URL of your backend service
- `NODE_ENV`: Set to `production` for production

---

## **Security Considerations**

### **Production Checklist:**
- [ ] Change default secret keys
- [ ] Use HTTPS (most platforms provide this)
- [ ] Set up proper CORS origins
- [ ] Add rate limiting
- [ ] Monitor API usage
- [ ] Set up logging

### **API Key Security:**
- Never commit API keys to Git
- Use environment variables
- Rotate keys regularly
- Monitor usage to prevent abuse

---

## **Monitoring & Maintenance**

### **Health Checks:**
- Backend: `https://your-backend-url/health`
- Frontend: `https://your-frontend-url`

### **Logs:**
- Render: Built-in logging
- Railway: Built-in logging
- Heroku: `heroku logs --tail`
- DigitalOcean: `pm2 logs`

### **Scaling:**
- Most platforms auto-scale
- Monitor usage and upgrade plans as needed
- Consider CDN for static assets

---

## **Cost Estimation**

### **Free Tiers:**
- **Render**: Free for 750 hours/month
- **Railway**: Free for 500 hours/month
- **Heroku**: Free tier discontinued
- **Vercel**: Free for frontend

### **Paid Options:**
- **DigitalOcean**: $5-10/month
- **AWS**: Pay-as-you-go (~$10-20/month)
- **Google Cloud**: Free tier + pay-as-you-go

---

## **Troubleshooting**

### **Common Issues:**

1. **CORS Errors**
   - Ensure backend URL is correct
   - Check CORS configuration

2. **API Key Issues**
   - Verify API key is set correctly
   - Check OpenAI account balance

3. **Build Failures**
   - Check requirements.txt
   - Verify Python/Node versions

4. **Connection Timeouts**
   - Check firewall settings
   - Verify port configurations

### **Support:**
- Render: [docs.render.com](https://docs.render.com)
- Railway: [docs.railway.app](https://docs.railway.app)
- Heroku: [devcenter.heroku.com](https://devcenter.heroku.com) 