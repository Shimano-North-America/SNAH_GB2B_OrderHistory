const axios = require('axios').default;
let accessToken = null;
let tokenExpiryTime = null;

const API_CREDENTIALS = {
  grant_type: 'client_credentials',
  client_id: 'sb-snah_orderhistory!t3479',
  client_secret: '94fb109f-eb68-48a6-a5a0-a7b83a33bfb0$1CLuB5GGlxl_5dC-fqySUjdpjzfsa3JWOLzz5Yfhimg=',
};
debugger;
const fetchAccessToken = async () => {
  const tokenData = new URLSearchParams(API_CREDENTIALS).toString();
  const options = {
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  };
  try {
    const response = await axios.post("https://sna-common-dev.authentication.us20.hana.ondemand.com/oauth/token", tokenData, options);
    accessToken = response.data.access_token;
    tokenExpiryTime = Date.now() + (response.data.expires_in * 1000) - 60000; 
    console.log('Access token fetched successfully');
    return accessToken;
  } catch (error) {
    console.error(error.message);
  }
};


const getAccessToken = async () => {
  debugger;
  if (!accessToken || Date.now() >= tokenExpiryTime || !tokenExpiryTime) {
    console.log('Access token expired or not available, fetching a new one...');
    await fetchAccessToken();
  }
  return accessToken;
};

module.exports = {
  getAccessToken,
};
