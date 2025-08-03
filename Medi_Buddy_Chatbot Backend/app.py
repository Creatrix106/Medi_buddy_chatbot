from flask import Flask, request, jsonify, session
from flask_cors import CORS
import openai, os
from dotenv import load_dotenv

# Load .env file locally (for development)
# For production (Render), environment variables are set in the platform
load_dotenv('api.env', override=False)

app = Flask(__name__)
CORS(app, origins=['http://localhost:3000', 'http://127.0.0.1:3000', 'https://medi-buddy-frontend.onrender.com'], supports_credentials=True)  # allow frontend calls
app.secret_key = os.getenv("SECRET_KEY", "super-secret-key")  # needed for sessions


openai.api_key = os.getenv("OPENAI_API_KEY")

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({"status": "healthy", "message": "MediBuddy API is running"})

@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.get_json()
        # Handle both 'message' and 'text' fields for compatibility
        user_input = data.get('message') or data.get('text', '')

        if not user_input:
            return jsonify({"error": "Message is required"}), 400

        # Check if OpenAI API key is set
        if not openai.api_key:
            print("ERROR: OpenAI API key is not set")
            return jsonify({"error": "OpenAI API key is not configured"}), 500

        
        if 'history' not in session:
            session['history'] = [
                {"role": "system", "content": 
                 "You are MediBuddy, a medical assistant with Lady Tsunade's personality from Naruto: "
                 "confident, caring, occasionally stern, with a touch of humor. "
                 "You provide medical help in a friendly tone."}
            ]

        # Add user message to memory
        session['history'].append({"role": "user", "content": user_input})

        # Limit to last 10 messages (avoid token overload)
        session['history'] = session['history'][-10:]

        # Send to OpenAI
        print(f"Sending request to OpenAI with {len(session['history'])} messages")
        response = openai.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=session['history']
        )

        bot_reply = response.choices[0].message['content']
        session['history'].append({"role": "assistant", "content": bot_reply})

        return jsonify({"response": bot_reply})

    except openai.APIError as e:
        print(f"OpenAI API error: {str(e)}")
        return jsonify({"error": f"OpenAI API error: {str(e)}"}), 500
    except Exception as e:
        print(f"Server error: {str(e)}")
        return jsonify({"error": f"Server error: {str(e)}"}), 500


@app.route('/reset', methods=['POST'])
def reset_chat():
    """Optional endpoint to reset memory"""
    session.pop('history', None)
    return jsonify({"status": "Chat memory cleared"})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
