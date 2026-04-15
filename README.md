# 🤖 Multimodal AI Assistant

A simple, lightweight AI assistant project with a FastAPI backend and React frontend. Perfect for college projects!

## 📋 Project Structure

```
multimodal-ai-assistant/
│
├── backend/
│   ├── main.py              # FastAPI application
│   └── requirements.txt      # Python dependencies
│
├── frontend/
│   ├── src/
│   │   ├── App.jsx         # Main React component
│   │   ├── App.css         # Styling
│   │   └── main.jsx        # Entry point
│   ├── index.html          # HTML template
│   ├── package.json        # npm dependencies
│   └── vite.config.js      # Vite configuration
│
└── README.md               # This file
```

## ✨ Features

### Backend (FastAPI)
- **GET `/`** - Health check endpoint
- **POST `/chat`** - Send messages and get AI-like responses
- **POST `/image`** - Upload images and get confirmation
- CORS enabled for frontend communication
- Well-commented, production-ready code

### Frontend (React + Vite)
- **Chat Interface** - Send/receive messages in real-time
- **Image Upload** - Upload images with visual feedback
- **Typing Animation** - Realistic AI typing effect
- **Responsive Design** - Works on desktop and mobile
- **Error Handling** - User-friendly error messages
- Clean, modern UI with gradient branding

## 🚀 Quick Start

### Prerequisites
- Python 3.8+ (for backend)
- Node.js 16+ (for frontend)
- npm or yarn

### Setup Backend

1. Navigate to backend folder:
```bash
cd backend
```

2. Create a Python virtual environment (recommended):
```bash
# On Windows
python -m venv venv
venv\Scripts\activate

# On macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Run the server:
```bash
python main.py
```

The backend will start at: **http://localhost:8000**

API documentation will be available at: **http://localhost:8000/docs**

### Setup Frontend

1. Open a new terminal and navigate to frontend folder:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

The frontend will start at: **http://localhost:5173**

## 💻 Usage

1. **Make sure both servers are running:**
   - Backend: `http://localhost:8000`
   - Frontend: `http://localhost:5173`

2. **Open the frontend in your browser:**
   - Navigate to `http://localhost:5173`

3. **Try the features:**
   - Type messages in the chat box and send
   - Click the upload button to upload images
   - Watch the AI respond in real-time

## 🔌 API Endpoints

### Health Check
```
GET /
Response: {"message": "AI Assistant Running"}
```

### Chat
```
POST /chat
Request: {"message": "Hello"}
Response: {"response": "You said: Hello"}
```

### Image Upload
```
POST /image
Request: Form-data with file
Response: {"message": "Image received successfully", "filename": "image.jpg"}
```

## 🎨 Customization

### Change AI Responses
Edit the `chat()` function in `backend/main.py`:
```python
# Add custom logic in the chat endpoint
elif "custom_keyword" in user_message.lower():
    ai_response = "Custom response here"
```

### Modify Styling
Edit `frontend/src/App.css` to change colors, fonts, and layout.

### Change API Port
- Backend: Edit `main.py` line with `uvicorn.run()`
- Frontend: Edit `frontend/vite.config.js` proxy setting

## 📦 Dependencies

### Backend
- `fastapi` - Web framework
- `uvicorn` - ASGI server
- `pydantic` - Data validation
- `python-multipart` - File upload support

### Frontend
- `react` - UI library
- `vite` - Build tool

## 🐛 Troubleshooting

### "Connection refused" error
- ✓ Make sure backend is running on http://localhost:8000
- ✓ Check if port 8000 is not used by another process

### Image upload not working
- ✓ Verify the file is a valid image (JPG, PNG, GIF, WebP)
- ✓ Check browser console for error messages

### Frontend not loading
- ✓ Make sure frontend is running on http://localhost:5173
- ✓ Try clearing browser cache (Ctrl+Shift+Delete)

### CORS errors
- ✓ Backend CORS is already configured for all origins
- ✓ Check network tab in browser console for details

## 📝 Notes

- **No API keys required** - Works completely offline
- **Simple responses** - AI responses are template-based (not using external APIs)
- **Lightweight** - Minimal dependencies, fast setup
- **College-friendly** - Clean code with comments and documentation
- **Easy deployment** - Can be deployed to various platforms

## 🎓 Learning Outcomes

This project teaches:
- FastAPI basics and async Python
- REST API design (GET, POST)
- File upload handling
- React hooks (useState)
- Async/await in JavaScript
- CORS and HTTP communication
- Frontend-backend integration
- Responsive CSS design

## 📄 License

Free to use for educational purposes!

## 🤝 Next Steps

To extend this project:
1. Add user authentication
2. Integrate a real AI API (OpenAI, Anthropic)
3. Add database for message history
4. Deploy to cloud (Render, Vercel)
5. Add more features (voice, video)

---

**Happy coding! 🚀**
