const express = require('express');
const AWS = require('aws-sdk');
const router = express.Router();

const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  region: process.env.AWS_REGION,
});

router.get('/', async (req, res) => {
  try {
    const data = await s3.listObjectsV2({
      Bucket: process.env.S3_BUCKET_NAME,
    }).promise();
    const screenshots = data.Contents ? data.Contents.map(obj => obj.Key) : [];
    res.json(screenshots);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to list screenshots' });
  }
});

module.exports = router;