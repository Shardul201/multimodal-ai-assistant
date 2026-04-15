# 🚀 DEPLOYMENT GUIDE - Multimodal AI Assistant

## 📋 Pre-Deployment Checklist

- [ ] Get HuggingFace API key
- [ ] Install Docker & Docker Compose (optional but recommended)
- [ ] Configure .env file
- [ ] Test locally first
- [ ] Check frontend build
- [ ] Verify API connectivity

---

## 🔧 Step 1: Setup Environment Variables

1. Open `.env` file in the root directory
2. Add your HuggingFace API key:
   ```
   HF_API_KEY=hf_your_token_here
   ```
3. Get free token from: https://huggingface.co/settings/tokens

---

## 💻 Step 2: Local Testing (Without Docker)

### **Backend Setup:**

```powershell
# Navigate to backend
cd backend

# Install dependencies
pip install -r requirements.txt

# Run backend (from project root in .env configured)
uvicorn main:app --reload --port 8000
```

Backend runs at: `http://localhost:8000`
API Docs: `http://localhost:8000/docs`

### **Frontend Setup:**

```powershell
# In new terminal, navigate to frontend
cd frontend

# Install dependencies
npm install

# Run frontend
npm run dev
```

Frontend runs at: `http://localhost:5173`

### **Test Endpoints:**

```powershell
# Test chat
Invoke-RestMethod -Uri "http://localhost:8000/chat" `
  -Method Post `
  -ContentType "application/json" `
  -Body '{"message":"Hello"}'

# Test health check
Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get
```

---

## 🐳 Step 3: Docker Deployment (Recommended)

### **Using Docker Compose (Easiest):**

```powershell
# Build and run both services
docker-compose up --build

# Or run in background
docker-compose up --build -d

# View logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Stop services
docker-compose down
```

Access:
- Frontend: `http://localhost:3000`
- Backend API: `http://localhost:8000`
- API Docs: `http://localhost:8000/docs`

### **Manual Docker Build:**

```powershell
# Build backend image
cd backend
docker build -t multimodal-backend .

# Run backend
docker run -p 8000:8000 -e HF_API_KEY=your_key multimodal-backend

# Build frontend image
cd frontend
docker build -t multimodal-frontend .

# Run frontend
docker run -p 3000:3000 multimodal-frontend
```

---

## ☁️ Step 4: Cloud Deployment Options

### **Option A: Heroku**

```powershell
# Install Heroku CLI
# Create account on heroku.com

# Login
heroku login

# Create app
heroku create your-app-name

# Set environment variable
heroku config:set HF_API_KEY=your_key -a your-app-name

# Deploy
git push heroku main
```

### **Option B: AWS (EC2)**

1. Create EC2 instance (Ubuntu 22.04)
2. SSH into instance:
```bash
ssh -i your-key.pem ubuntu@your-instance-ip
```

3. Install dependencies:
```bash
sudo apt update
sudo apt install python3-pip nodejs npm docker.io -y
sudo usermod -aG docker $USER
```

4. Clone repository and deploy:
```bash
git clone your-repo-url
cd multimodal-ai-assistant
echo "HF_API_KEY=your_key" > .env
docker-compose up -d
```

### **Option C: Azure App Service**

```powershell
# Install Azure CLI
# Create resource group
az group create --name myResourceGroup --location eastus

# Create app service plan
az appservice plan create --name myAppPlan --resource-group myResourceGroup --sku B1 --is-linux

# Deploy
az webapp up --name your-app-name --resource-group myResourceGroup --runtime "PYTHON:3.11"
```

---

## 🔍 Step 5: Post-Deployment Verification

```powershell
# Check health
Invoke-RestMethod http://your-deployment-url/

# Test chat endpoint
Invoke-RestMethod -Uri "http://your-deployment-url/chat" `
  -Method Post `
  -ContentType "application/json" `
  -Body '{"message":"test"}'

# Check API docs
# Visit: http://your-deployment-url/docs
```

---

## 🐛 Troubleshooting

### Backend won't start
- ❌ HF_API_KEY not set: `set HF_API_KEY=your_key`
- ❌ Port 8000 in use: `netstat -ano | findstr :8000`

### Images failing
- ❌ Docker not installed: Install from docker.com
- ❌ Build fails: `docker-compose build --no-cache`

### Frontend can't reach backend
- ❌ Check CORS settings in backend/main.py
- ❌ Verify backend URL in frontend config
- ❌ Check firewall rules

---

## 📊 Production Checklist

- [ ] Set strong environment variables
- [ ] Use HTTPS/SSL certificates
- [ ] Enable rate limiting
- [ ] Setup monitoring/logs
- [ ] Configure auto-scaling
- [ ] Setup backup strategy
- [ ] Use CDN for static assets
- [ ] Enable authentication if needed

---

## 📞 Quick Commands

```powershell
# Local development
npm run dev              # Frontend
uvicorn main:app --reload  # Backend

# Docker
docker-compose up       # Start all
docker-compose down     # Stop all
docker-compose logs -f  # View logs

# Testing
curl http://localhost:8000/
curl -X POST http://localhost:8000/chat -d '{"message":"hi"}'
```

---

**Ready to deploy! Good luck! 🎉**
