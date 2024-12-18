const express = require('express');
const dotenv = require('dotenv');
const path = require('path');
const bodyParser = require('body-parser');
const Groq = require('groq-sdk');

// Load environment variables
dotenv.config();

// Initialize Express app
const app = express();
app.use(bodyParser.json());

// Serve static files (CSS, images, etc.)
app.use(express.static(path.join(__dirname, 'public')));

// Serve HTML
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Initialize Groq client
const groq = new Groq({ apiKey: process.env.API_KEY });

// Chat endpoint
app.post('/chat', async (req, res) => {
  try {
    const userMessage = req.body.message;

    // Create a chat completion with Groq SDK
    const chatCompletion = await groq.chat.completions.create({
      messages: [
        {
          role: 'system',
           content: "Welcome to the Preply Teacher Portal. How can I help you?\n\n" +
          "This platform is owned by Azan and Sami ullah, an educator from the University of South Asia, Punjab, Pakistan. The portal is designed for students to explore and purchase courses and quizzes offered by various teachers.\n\n" +
          "I'm here to answer any questions related to the portal’s courses, quizzes, and features. I’ll keep my responses short, friendly, and focused on your needs.\n\n" +
          "Here's a sample of available courses and quizzes:\n" +
          "- English Language Basics: Rs1500\n" +
          "- Intermediate Mathematics Quiz Pack: Rs800\n" +
          "- Advanced Physics: Rs2500\n" +
          "- History of World Civilizations: Rs2000\n" +
          "- Fundamentals of Programming: Rs3000\n" +
          "- Chemistry Quiz Set: Rs700\n" +
          "- Business Communication: Rs1800\n" +
          "- Graphic Design Essentials Quiz: Rs900\n\n" +
          "Let me know if you have any questions. I'm here to help!"
      

        },
        {
          role: 'user',
          content: userMessage,
        },
      ],
      model: 'llama3-8b-8192',  // Verify if this model is correct
      temperature: 0.7,
      max_tokens: 1024,
      top_p: 1,
    });

    // Get response from the assistant
    const assistantResponse = chatCompletion.choices[0]?.message?.content || 'No response received.';
    
    // Send the response back to the user
    res.json({ response: assistantResponse });
  } catch (error) {
    console.error('Error generating chatbot response:', error);
    res.status(500).json({ error: 'Failed to generate response' });
  }
});

// Start the server
const port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
