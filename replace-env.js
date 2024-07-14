const fs = require('fs');
const path = require('path');

const configPath = path.join(__dirname, 'web', 'config.js');
const apiKey = process.env.GEMINI_API_KEY;

if (fs.existsSync(configPath)) {
  let configContent = fs.readFileSync(configPath, 'utf8');
  configContent = configContent.replace('{{GEMINI_API_KEY}}', apiKey);
  fs.writeFileSync(configPath, configContent);
  console.log('Environment variables replaced successfully');
} else {
  console.error('config.js file not found in web folder');
  process.exit(1);
}