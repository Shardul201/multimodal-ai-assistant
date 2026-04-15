# 🚀 ONE-CLICK DEPLOYMENT GUIDE

## Deploy with Just ONE CLICK! Click the button below:

### ⚡ **DEPLOY TO RENDER** (Free)

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

---

## 🎯 If Button Doesn't Work - Manual 3-Step Setup

### **Step 1: Connect GitHub** (60 seconds)
```
1. Go to: https://render.com
2. Click "Sign up with GitHub"
3. Authorize Render to access your GitHub repos
```

### **Step 2: Deploy Backend** (2 minutes)
```
1. Click "New +" → "Web Service"
2. Select your repository
3. Fill in:
   - Name: multimodal-ai-backend
   - Root Directory: backend
   - Build: pip install -r requirements.txt
   - Start: uvicorn main:app --host 0.0.0.0 --port 10000
4. Click "Advanced" → Add Environment:
   - Name: HF_API_KEY
   - Value: hf_your_token_here
5. Click "Deploy Web Service"
```

✅ Wait 2-3 minutes...
✅ Backend live at: `https://your-service-name.onrender.com`

### **Step 3: Deploy Frontend** (2 minutes)
```
1. Click "New +" → "Static Site"
2. Select your repository
3. Fill in:
   - Root Directory: frontend
   - Build Command: npm install && npm run build
   - Publish Directory: dist
4. Click "Deploy"
```

✅ Wait 1-2 minutes...
✅ Frontend live at: `https://your-frontend-name.onrender.com`

---

## ✅ YOU'RE DONE!

Your project is now live online forever (free tier):
- 🌐 Frontend: https://your-frontend.onrender.com
- 🔌 Backend API: https://your-backend.onrender.com/docs

**Every time you push to GitHub, it auto-deploys!**

---

## 🔄 Auto-Deploy on Every Push

Once deployed, Render automatically deploys when you push to GitHub:

```powershell
git add .
git commit -m "Update"
git push
# ✅ Auto-deployed in 2 minutes!
```

---

## 📝 IMPORTANT: Before Deploying

Make sure you have:
- ✅ GitHub account
- ✅ Code pushed to GitHub
- ✅ HuggingFace API key (free from huggingface.co)

---

## 🆘 Troubleshooting

**Backend won't deploy?**
- Check: HF_API_KEY is set correctly
- Check: requirements.txt is in backend folder
- Check: main.py is in backend folder

**Frontend won't deploy?**
- Check: package.json is in frontend folder
- Check: vite.config.js exists

**Services won't talk to each other?**
- Update frontend to use backend URL in production
- Edit: `frontend/src/` - change API endpoint

---

## 🎁 BONUS: Deploy Anywhere Else

### **Railway** (Also Free)
- Visit: https://railway.app?referralCode=render
- Click "Deploy"

### **Vercel** (Frontend)
- Visit: https://vercel.com
- Import GitHub repo
- Click "Deploy"

---

**Choose ONE platform above and you're done in 5 minutes! 🚀**
