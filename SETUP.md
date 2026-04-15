# Multimodal AI Assistant - Setup Guide

## 🎯 Quick Start (Choose your OS)

### Windows Users
**Terminal 1 (Backend):**
```
run-backend.bat
```

**Terminal 2 (Frontend):**
```
run-frontend.bat
```

### macOS/Linux Users
**Terminal 1 (Backend):**
```bash
chmod +x run-backend.sh
./run-backend.sh
```

**Terminal 2 (Frontend):**
```bash
chmod +x run-frontend.sh
./run-frontend.sh
```

---

## 📋 Manual Setup Steps

### Backend Setup (Python)

1. **Navigate to backend directory:**
   ```
   cd backend
   ```

2. **Create virtual environment (Windows):**
   ```
   python -m venv venv
   venv\Scripts\activate
   ```
   Or **(macOS/Linux):**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies:**
   ```
   pip install -r requirements.txt
   ```

4. **Start backend server:**
   ```
   python main.py
   ```
   ```
   ✓ Backend running on http://localhost:8000
   ✓ API docs on http://localhost:8000/docs
   ```

### Frontend Setup (Node.js)

1. **Open new terminal and navigate to frontend:**
   ```
   cd frontend
   ```

2. **Install dependencies:**
   ```
   npm install
   ```

3. **Start development server:**
   ```
   npm run dev
   ```
   ```
   ✓ Frontend running on http://localhost:5173
   ```

4. **Open in browser:**
   ```
   http://localhost:5173
   ```

---

## 🔍 Verify Installation

### Check Backend
- Visit: http://localhost:8000
- Should see: `{"message": "AI Assistant Running"}`
- API docs: http://localhost:8000/docs

### Check Frontend
- Visit: http://localhost:5173
- Should see: AI Assistant chat interface

---

## ✅ Test the Features

### Test Chat
1. Type a message: "Hello, how are you?"
2. Backend responds with message echo

### Test Image Upload
1. Click "📸 Upload Image"
2. Select any image file
3. See confirmation message

---

## 🛠️ Troubleshooting

### Issue: "Connection refused" on frontend
**Solution:**
- Ensure backend is running on http://localhost:8000
- Check if port 8000 is available: `netstat -ano | findstr :8000` (Windows)
- Kill process if needed: `taskkill /PID <PID> /F` (Windows)

### Issue: "Module not found" error (Python)
**Solution:**
- Activate virtual environment
- Run `pip install -r requirements.txt` again
- Check Python version: `python --version` (should be 3.8+)

### Issue: "npm command not found"
**Solution:**
- Install Node.js: https://nodejs.org (16+ recommended)
- Restart terminal after installation
- Verify: `node --version` and `npm --version`

### Issue: Port already in use
**Solution:**
- Backend (8000): `netstat -ano | findstr :8000`
- Frontend (5173): `netstat -ano | findstr :5173`
- Kill process: `taskkill /PID <PID> /F` (Windows)
- Or use different port in config files

### Issue: CORS errors
**Solution:**
- CORS is already configured in backend
- Clear browser cache: `Ctrl+Shift+Delete`
- Try incognito/private mode

---

## 📦 Project Files

| File | Purpose |
|------|---------|
| `backend/main.py` | FastAPI server with endpoints |
| `backend/requirements.txt` | Python dependencies |
| `frontend/src/App.jsx` | Main React component |
| `frontend/src/App.css` | Styling |
| `frontend/package.json` | npm dependencies |
| `run-backend.bat/.sh` | Quick start script |
| `run-frontend.bat/.sh` | Quick start script |
| `README.md` | Full documentation |

---

## 🎨 Customization

### Add Custom AI Response
Edit `backend/main.py` in the `chat()` function:
```python
elif "your_keyword" in user_message.lower():
    ai_response = "Your custom response"
```

### Change Colors
Edit `frontend/src/App.css`:
```css
background: linear-gradient(135deg, #YOUR_COLOR1 0%, #YOUR_COLOR2 100%);
```

### Change Port (Backend)
Edit `backend/main.py` last line:
```python
uvicorn.run(app, host="0.0.0.0", port=YOUR_PORT)
```

### Change Port (Frontend)
Edit `frontend/vite.config.js`:
```javascript
port: YOUR_PORT,
```

---

## 🚀 Next Steps

- [x] Local development working
- [ ] Deploy backend (Render, Railway, Heroku)
- [ ] Deploy frontend (Vercel, Netlify)
- [ ] Connect to real AI API (OpenAI, Anthropic)
- [ ] Add database for chat history
- [ ] Add user authentication

---

## 📞 Support

If you encounter issues:
1. Check browser console (F12) for errors
2. Check backend server logs
3. Verify both servers are running
4. Check firewall/antivirus settings
5. Ensure correct Python and Node.js versions

---

**Ready to run? Start with the Quick Start section above! 🚀**
