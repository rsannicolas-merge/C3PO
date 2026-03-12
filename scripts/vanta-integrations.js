#!/usr/bin/env node

// Read the Vanta API token from the environment variable
const token = process.env.VANTA_API_TOKEN;

if (!token) {
  console.error('Error: VANTA_API_TOKEN environment variable is not set.');
  console.error('Usage: VANTA_API_TOKEN=your_token node vanta-integrations.js');
  process.exit(1);
}

const url = 'https://api.vanta.com/v1/integrations?pageSize=100';

fetch(url, {
  method: 'GET',
  headers: {
    'Accept': 'application/json',
    'Authorization': `Bearer ${token}`
  }
})
  .then(async (response) => {
    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`HTTP error ${response.status}: ${errorText}`);
    }
    return response.json();
  })
  .then((data) => {
    console.log(JSON.stringify(data, null, 2));
  })
  .catch((error) => {
    console.error('API Error:');
    console.error(error.message);
    if (error.cause) {
      console.error('Cause:', error.cause);
    }
    process.exit(1);
  });
