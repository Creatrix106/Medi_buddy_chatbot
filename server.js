const express = require("express");
const path = require("path");
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

let FlaskResponse;

// Debug logging
console.log('=== DEBUG INFO ===');
console.log('Current directory (__dirname):', __dirname);
console.log('Looking for public directory at:', path.join(__dirname, 'public'));
console.log('Looking for index.html at:', path.join(__dirname, 'public', 'index.html'));

// Serve static files from the public directory
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'healthy', 
    message: 'MediBuddy Frontend is running',
    timestamp: new Date().toISOString()
  });
});

app.post('/userinput', (req, res) => {
  const UserInput = req.body;
  console.log('Data Received from User', UserInput);

  sendDataToFlask(UserInput)
    .then(flaskResponse => {
      res.status(200).send({ flaskResponse });
    })
    .catch(error => {
      console.error('Error communicating with Flask:', error);
      res.status(500).send({ error: 'Failed to communicate with Flask server' });
    });
});

app.listen(PORT, () => {
  console.log(`Server is running on port 'http://localhost:${PORT}'`);
});

async function sendDataToFlask(Prompt) {
  // Use environment variable for backend URL or default to localhost
  const backendUrl = process.env.BACKEND_URL || 'http://127.0.0.1:5000';
  
  console.log('=== BACKEND COMMUNICATION DEBUG ===');
  console.log('Backend URL:', backendUrl);
  console.log('Sending request to:', `${backendUrl}/chat`);
  console.log('Request payload:', Prompt);
  
  try {
    const response = await axios.post(`${backendUrl}/chat`, Prompt, {
      headers: {
        'Content-Type': 'application/json'
      }
    });
    console.log('Response from Flask:', response.data);
    FlaskResponse = response.data;
    console.log(FlaskResponse.response, "Response received");
    return response.data;
  } catch (error) {
    console.error('=== BACKEND COMMUNICATION ERROR ===');
    console.error('Error details:', error.message);
    console.error('Error response:', error.response?.data);
    console.error('Error status:', error.response?.status);
    throw error;
  }
} 