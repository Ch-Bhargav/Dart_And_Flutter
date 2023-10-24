const express = require('express');
const mongodb = require('mongoose');
const app = express();
const port = 3000; // Set your desired port number


//Database Connection
const uri = "mongodb+srv://admin:toor@database.sfb562n.mongodb.net/?retryWrites=true&w=majority"
mongodb.connect(uri);

// Define a route
app.get('/', (req, res) => {
  res.send('Hello, Express!');
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
