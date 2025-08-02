# Medi Buddy Chatbot

A medical assistant chatbot with Lady Tsunade's personality from Naruto, providing medical help in a friendly and confident tone.

## 🏗️ Architecture

```
Frontend (Port 3000) → Express Server → Flask Backend (Port 5000) → OpenAI API
```

## 📁 Project Structure

```
Medi_buddy_chatbot-stack/
├── Medi_Buddy_Chatbot Backend/     # Flask API Server
│   ├── app.py                      # Main Flask application
│   ├── api.env                     # Environment variables
│   ├── requirements.txt            # Python dependencies
│   └── README.md
└── Medi_buddy_chatbot-frontend/    # Node.js Frontend
    ├── server.js                   # Express server
    ├── package.json                # Node.js dependencies
    ├── frontend/public/            # Static files
    │   ├── index.html             # Chat interface
    │   ├── script.js              # Frontend JavaScript
    │   └── style.css              # Styling
    └── assert/img/                # Images
        └── stethoscope.png
```

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- Node.js 14+
- OpenAI API key

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd "Medi_Buddy_Chatbot Backend"
   ```

2. **Create virtual environment:**
   ```bash
   python -m venv venv
   ```

3. **Activate virtual environment:**
   - Windows: `venv\Scripts\activate`
   - Mac/Linux: `source venv/bin/activate`

4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Configure environment:**
   - Edit `api.env` file
   - Add your OpenAI API key: `OPENAI_API_KEY=your_actual_api_key_here`

6. **Run the backend:**
   ```bash
   python app.py
   ```
   Backend will run on `http://localhost:5000`

### Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd Medi_buddy_chatbot-frontend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Run the frontend:**
   ```bash
   npm run dev
   ```
   Frontend will run on `http://localhost:3000`

## 🔧 API Endpoints

### Backend (Flask)
- `GET /health` - Health check
- `POST /chat` - Send message to chatbot
- `POST /reset` - Reset chat history

### Frontend (Express)
- `GET /` - Serve chat interface
- `POST /userinput` - Proxy to Flask backend

## 🎨 Features

- **Modern Chat Interface**: Clean, responsive design
- **AI-Powered Responses**: Uses OpenAI GPT-3.5-turbo
- **Character Personality**: Lady Tsunade from Naruto
- **Session Management**: Maintains conversation history
- **Error Handling**: Robust error handling and user feedback
- **Real-time Chat**: Smooth message flow with typing indicators

## 🛠️ Technologies Used

### Backend
- **Flask**: Python web framework
- **OpenAI**: AI language model
- **Flask-CORS**: Cross-origin resource sharing
- **python-dotenv**: Environment variable management

### Frontend
- **Express.js**: Node.js web framework
- **Vanilla JavaScript**: Frontend logic
- **CSS3**: Modern styling with animations
- **Material Icons**: UI icons

## 🔍 Troubleshooting

### Common Issues

1. **OpenAI API Error**
   - Ensure your API key is correctly set in `api.env`
   - Check if you have sufficient credits in your OpenAI account

2. **Connection Error**
   - Make sure both backend (port 5000) and frontend (port 3000) are running
   - Check if ports are not being used by other applications

3. **CORS Error**
   - Backend has CORS enabled, but ensure frontend is making requests to correct URL

### Health Checks

- Backend: `http://localhost:5000/health`
- Frontend: `http://localhost:3000`

## 📝 Development

### Adding New Features
1. Backend changes: Modify `app.py`
2. Frontend changes: Modify files in `frontend/public/`
3. Styling changes: Modify `style.css`

### Environment Variables
- `OPENAI_API_KEY`: Your OpenAI API key
- `SECRET_KEY`: Flask session secret (change in production)
- `PORT`: Server port (default: 5000)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the ISC License.

---

**Authors**: SID BABA AND RACHIT BABA 