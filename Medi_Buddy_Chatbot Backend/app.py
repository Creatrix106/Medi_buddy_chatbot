from flask import Flask, request, jsonify, session
from flask_cors import CORS
import google.generativeai as genai
import os
from dotenv import load_dotenv

# Load .env file locally (for development)
# For production (Render), environment variables are set in the platform
load_dotenv('api.env', override=False)

app = Flask(__name__)
CORS(app, origins=['http://localhost:3000', 'http://127.0.0.1:3000', 'https://medi-buddy-frontend.onrender.com'], supports_credentials=True)  # allow frontend calls
app.secret_key = os.getenv("SECRET_KEY", "super-secret-key")  # needed for sessions

# Configure Gemini
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({"status": "healthy", "message": "MediBuddy API is running"})

@app.route('/test', methods=['GET'])
def test_endpoint():
    """Test endpoint to verify API key and basic functionality"""
    try:
        api_key = os.getenv("GEMINI_API_KEY")
        if not api_key:
            return jsonify({"error": "GEMINI_API_KEY not set", "status": "error"}), 500
        
        # Test Gemini connection
        import google.generativeai as genai
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-1.5-flash')
        
        # Simple test response
        response = model.generate_content("Say 'Hello from MediBuddy!'")
        
        return jsonify({
            "status": "success",
            "message": "Gemini API is working",
            "test_response": response.text,
            "api_key_set": bool(api_key)
        })
    except Exception as e:
        return jsonify({
            "status": "error",
            "error": str(e),
            "api_key_set": bool(os.getenv("GEMINI_API_KEY"))
        }), 500

@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.get_json()
        # Handle both 'message' and 'text' fields for compatibility
        user_input = data.get('message') or data.get('text', '')

        if not user_input:
            return jsonify({"error": "Message is required"}), 400

        # Debug: Print environment variables
        print("=== BACKEND DEBUG ===")
        print(f"GEMINI_API_KEY set: {bool(os.getenv('GEMINI_API_KEY'))}")
        print(f"OPENAI_API_KEY set: {bool(os.getenv('OPENAI_API_KEY'))}")
        print(f"User input: {user_input}")

        # Check if Gemini API key is set
        if not os.getenv("GEMINI_API_KEY"):
            print("ERROR: Gemini API key is not set")
            return jsonify({"error": "Gemini API key is not configured"}), 500

        # Initialize chat if not exists
        if 'chat_session' not in session:
            # Create a new chat session with Lady Tsunade personality
            model = genai.GenerativeModel('gemini-1.5-flash')
            session['chat_session'] = model.start_chat(history=[])
            
            # Set the personality context
            personality_prompt = """You are MediBuddy, a medical assistant with Lady Tsunade's personality from Naruto. 
            
            Your personality traits:
            - Confident and authoritative like Lady Tsunade
            - Caring and nurturing towards patients
            - Occasionally stern when needed, especially about medical safety
            - Has a touch of humor and warmth
            - Very knowledgeable about medicine and healing
            - Speaks with confidence and occasionally uses medical terminology
            - Shows concern for patient well-being
            - May occasionally reference your "medical ninja" skills in a light-hearted way
            
            You provide medical help in a friendly but professional tone. Always prioritize patient safety and recommend consulting a doctor for serious conditions. You can help with:
            - General health advice
            - Symptom explanations
            - Basic first aid guidance
            - Medication information
            - Lifestyle recommendations
            
            Remember: You're not a replacement for professional medical care, especially for serious conditions."""
            
            # Send the personality prompt to set the context
            session['chat_session'].send_message(personality_prompt)

        # Send user message to Gemini
        print(f"Sending request to Gemini: {user_input}")
        response = session['chat_session'].send_message(user_input)
        
        bot_reply = response.text
        print(f"Gemini response: {bot_reply}")

        return jsonify({"response": bot_reply})

    except Exception as e:
        print(f"Server error: {str(e)}")
        return jsonify({"error": f"Server error: {str(e)}"}), 500

@app.route('/reset', methods=['POST'])
def reset_chat():
    """Optional endpoint to reset memory"""
    session.pop('chat_session', None)
    return jsonify({"status": "Chat memory cleared"})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    print("=== MEDIBUDDY BACKEND STARTING ===")
    print(f"Using Gemini API: {bool(os.getenv('GEMINI_API_KEY'))}")
    print(f"Port: {port}")
    app.run(host='0.0.0.0', port=port, debug=False)
