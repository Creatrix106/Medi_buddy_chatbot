const express = require("express");
const path = require("path");
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

const axios = require('axios');

async function sendDataToFlask(Prompt) {
  // Use environment variable for backend URL or default to localhost
  const backendUrl = process.env.BACKEND_URL || 'http://127.0.0.1:5000';
  
  const response = await axios.post(`${backendUrl}/chat`, Prompt, {
    headers: {
      'Content-Type': 'application/json'
    }
  });
  console.log('Response from Flask:', response.data);
  FlaskResponse = response.data;
  console.log(FlaskResponse.response, "Response received")

  return response.data;
} 