const express = require('express');
const app = express();
const port = 3000;

app.get('/health', (req, res) => {
  const secretWord = process.env.SECRET_WORD || "No secret word set";
  res.send(`<h1>SECRET_WORD: ${secretWord}</h1>`);
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
