import { useState } from 'react'
import './App.css'

export default function App() {
  // State management
  const [messages, setMessages] = useState([
    { id: 1, type: 'bot', text: 'Hello! I\'m your AI Assistant. How can I help you today?' }
  ])
  const [inputValue, setInputValue] = useState('')
  const [selectedFile, setSelectedFile] = useState(null)
  const [isLoading, setIsLoading] = useState(false)

  const API_BASE_URL = 'http://localhost:8000'

  /**
   * Send chat message to backend
   */
  const handleSendMessage = async (e) => {
    e.preventDefault()

    if (!inputValue.trim()) return

    // Add user message to chat
    const userMessage = {
      id: messages.length + 1,
      type: 'user',
      text: inputValue
    }
    setMessages([...messages, userMessage])
    setInputValue('')
    setIsLoading(true)

    try {
      // Call backend chat endpoint
      const response = await fetch(`${API_BASE_URL}/chat`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: inputValue })
      })

      if (!response.ok) throw new Error('Failed to get response')

      const data = await response.json()

      // Add bot response to chat
      const botMessage = {
        id: messages.length + 2,
        type: 'bot',
        text: data.response
      }
      setMessages(prev => [...prev, botMessage])
    } catch (error) {
      console.error('Error:', error)
      const errorMessage = {
        id: messages.length + 2,
        type: 'bot',
        text: 'Sorry, I could not process your message. Please make sure the backend is running on http://localhost:8000'
      }
      setMessages(prev => [...prev, errorMessage])
    } finally {
      setIsLoading(false)
    }
  }

  /**
   * Handle image file upload
   */
  const handleImageUpload = async (e) => {
    const file = e.target.files?.[0]
    if (!file) return

    setSelectedFile(file)
    setIsLoading(true)

    try {
      // Create FormData for multipart upload
      const formData = new FormData()
      formData.append('file', file)

      // Call backend image endpoint
      const response = await fetch(`${API_BASE_URL}/image`, {
        method: 'POST',
        body: formData
      })

      if (!response.ok) throw new Error('Failed to upload image')

      const data = await response.json()

      // Add success message to chat
      const successMessage = {
        id: messages.length + 1,
        type: 'bot',
        text: `${data.message} - Filename: ${data.filename}`
      }
      setMessages(prev => [...prev, successMessage])
      setSelectedFile(null)
    } catch (error) {
      console.error('Error:', error)
      const errorMessage = {
        id: messages.length + 1,
        type: 'bot',
        text: 'Sorry, image upload failed. Please check your connection and try again.'
      }
      setMessages(prev => [...prev, errorMessage])
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="container">
      <div className="chat-container">
        {/* Header */}
        <div className="header">
          <h1>🤖 Multimodal AI Assistant</h1>
          <p>Chat and upload images</p>
        </div>

        {/* Messages Display */}
        <div className="messages">
          {messages.map(msg => (
            <div key={msg.id} className={`message ${msg.type}`}>
              <div className="message-bubble">
                {msg.text}
              </div>
            </div>
          ))}
          {isLoading && (
            <div className="message bot">
              <div className="message-bubble typing">
                <span></span><span></span><span></span>
              </div>
            </div>
          )}
        </div>

        {/* Input Area */}
        <div className="input-area">
          {/* Chat Input */}
          <form onSubmit={handleSendMessage} className="chat-form">
            <input
              type="text"
              value={inputValue}
              onChange={(e) => setInputValue(e.target.value)}
              placeholder="Type your message here..."
              disabled={isLoading}
              className="chat-input"
            />
            <button
              type="submit"
              disabled={isLoading || !inputValue.trim()}
              className="send-btn"
            >
              Send
            </button>
          </form>

          {/* Image Upload */}
          <div className="image-upload">
            <label htmlFor="image-input" className="upload-btn">
              📸 Upload Image
            </label>
            <input
              id="image-input"
              type="file"
              accept="image/*"
              onChange={handleImageUpload}
              disabled={isLoading}
              className="file-input"
            />
            {selectedFile && (
              <span className="file-name">✓ {selectedFile.name}</span>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
