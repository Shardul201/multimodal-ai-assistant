"""
Multimodal AI Assistant Backend

A FastAPI-based backend for handling chat and image upload requests.
Production-ready with proper error handling and validation.

Requirements:
    fastapi
    uvicorn
    requests
    pillow
    python-multipart

Setup:
    1. Set environment variable: set HF_API_KEY=your_api_key_here
    2. Install dependencies: pip install -r requirements.txt
    3. Run: uvicorn main:app --reload
    4. API docs: http://localhost:8000/docs
"""

import os
import io
from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import requests
from PIL import Image

# ============================================================================
# CONFIGURATION
# ============================================================================

# Initialize FastAPI application
app = FastAPI(
    title="Multimodal AI Assistant",
    description="Backend service supporting text chat and image processing",
    version="1.0.0"
)

# Enable CORS for frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Get HuggingFace API key from environment variable
HF_API_KEY = os.getenv("HF_API_KEY")
HF_API_URL = "https://api-inference.huggingface.co/models"

if not HF_API_KEY:
    print("⚠️  WARNING: HF_API_KEY environment variable not set!")


# ============================================================================
# PYDANTIC MODELS (Request/Response schemas)
# ============================================================================

class ChatRequest(BaseModel):
    """Schema for chat endpoint request"""
    message: str


class ChatResponse(BaseModel):
    """Schema for chat endpoint response"""
    response: str


# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

def query_huggingface(payload, model_name):
    """
    Send a request to HuggingFace Inference API
    
    Args:
        payload (dict): The data to send to the model
        model_name (str): The model identifier (e.g., "distilgpt2")
    
    Returns:
        dict or list: The response from the API
    
    Raises:
        Exception: If API request fails or API key is not set
    """
    if not HF_API_KEY:
        raise Exception("HF_API_KEY environment variable not set. Please configure it before using chat.")
    
    headers = {"Authorization": f"Bearer {HF_API_KEY}"}
    url = f"{HF_API_URL}/{model_name}"
    
    try:
        response = requests.post(url, headers=headers, json=payload, timeout=30)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"❌ HuggingFace API Error: {str(e)}")
        raise Exception(f"Failed to query HuggingFace API: {str(e)}")


# ============================================================================
# ENDPOINTS
# ============================================================================

@app.get("/", response_class=JSONResponse)
async def root():
    """Root endpoint - confirms server is running"""
    return {
        "status": "running",
        "message": "Multimodal AI Assistant Backend is active! 🚀",
        "version": "1.0.0"
    }


@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    """
    Chat endpoint - generates AI responses using HuggingFace distilgpt2 model
    
    Args:
        request (ChatRequest): Contains user message
    
    Returns:
        ChatResponse: AI-generated response text
    """
    if not request.message or not request.message.strip():
        raise HTTPException(status_code=400, detail="Message cannot be empty")
    
    try:
        user_message = request.message.strip()
        
        payload = {
            "inputs": user_message,
            "parameters": {
                "max_length": 100,
                "temperature": 0.7
            }
        }
        
        print(f"📤 Processing message: {user_message[:50]}...")
        result = query_huggingface(payload, "distilgpt2")
        
        if isinstance(result, list) and len(result) > 0:
            generated_text = result[0].get("generated_text", "")
            ai_response = generated_text[len(user_message):].strip()
        else:
            ai_response = "Unable to generate response"
        
        print(f"✅ Response generated")
        return ChatResponse(response=ai_response)
    
    except Exception as e:
        print(f"❌ Chat Error: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Chat processing failed: {str(e)}")


@app.post("/image", response_class=JSONResponse)
async def process_image(file: UploadFile = File(...)):
    """
    Image processing endpoint - accepts image upload and processes it
    
    Args:
        file (UploadFile): The uploaded image file
    
    Returns:
        dict: Image details and confirmation message
    """
    try:
        allowed_extensions = {"jpg", "jpeg", "png", "gif", "webp"}
        file_extension = file.filename.split(".")[-1].lower()
        
        if file_extension not in allowed_extensions:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid file type. Allowed: {', '.join(allowed_extensions)}"
            )
        
        contents = await file.read()
        file_size = len(contents)
        
        if file_size > 10 * 1024 * 1024:
            raise HTTPException(status_code=413, detail="File size exceeds 10MB limit")
        
        image = Image.open(io.BytesIO(contents))
        width, height = image.size
        image_format = image.format
        
        print(f"✅ Image processed: {file.filename} ({width}x{height})")
        
        return {
            "status": "success",
            "message": f"Image '{file.filename}' uploaded successfully! 🖼️",
            "filename": file.filename,
            "file_size_bytes": file_size,
            "image_format": image_format,
            "dimensions": {"width": width, "height": height}
        }
    
    except Image.UnidentifiedImageError:
        raise HTTPException(status_code=400, detail="Invalid image file format")
    except Exception as e:
        print(f"❌ Image Error: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Image processing failed: {str(e)}")


# ============================================================================
# ERROR HANDLER
# ============================================================================

@app.exception_handler(Exception)
async def general_exception_handler(request, exc):
    """Global exception handler"""
    print(f"❌ Error: {str(exc)}")
    return JSONResponse(
        status_code=500,
        content={"detail": "An unexpected error occurred"}
    )


# ============================================================================
# MAIN EXECUTION
# ============================================================================

if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", 8000))
    print("🚀 Starting Multimodal AI Assistant Backend...")
    print(f"📝 API Docs: http://localhost:{port}/docs")
    uvicorn.run(app, host="0.0.0.0", port=port)
