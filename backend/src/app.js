const express = require('express');
const screenshotsRouter = require('./routes/screenshots');
const contactRouter = require('./routes/contact');
require('dotenv').config();

const app = express();
app.use(express.json());

app.use('/api/screenshots', screenshotsRouter);
app.use('/api/contact', contactRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));