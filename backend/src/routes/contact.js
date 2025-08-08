const express = require('express');
const router = express.Router();

router.post('/', (req, res) => {
  const { name, email, message } = req.body;
  if (!name || !email || !message) {
    return res.status(400).json({ error: 'Missing required fields' });
  }
  console.log(`Received contact: ${name}, ${email}, ${message}`);
  res.json({ message: 'Contact received' });
});

module.exports = router;