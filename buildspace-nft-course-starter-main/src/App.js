import React, { useEffect, useState } from "react";
import './styles/App.css';
import twitterLogo from './assets/twitter-logo.svg';

// Constants
const TWITTER_HANDLE = '_buildspace';
const TWITTER_LINK = `https://twitter.com/${TWITTER_HANDLE}`;
const OPENSEA_LINK = '';
const TOTAL_MINT_COUNT = 50;

const App = () => {
  // A state variable to store the users public wallet
  const [userAccount, setUserAccount] = useState("");
  
  const checkIfConnected = async () => {
    //Need to have access to window.ethereum 
    const { ethereum } = window;

    if(!ethereum) {
      console.log("Get metamask!");
      return;
    } else{
      console.log("You are good to go", ethereum);
    }
  
  // check if we are authorize to access the users wallet
  const accounts = await ethereum.request({ method: 'eth_accounts' });
// check if the user has more than one account, then grap the first one
  if (accounts.length !== 0) {
      const account = accounts[0];
      console.log("Found an authorized account:", account);
      setUserAccount(account);
    } else {
      console.log("No authorized account found");
    }
  }
  // Render Methods
  const renderNotConnectedContainer = () => (
    <button className="cta-button connect-wallet-button">
      Connect to Wallet
    </button>
  );

  useEffect(() => {
    checkIfConnected();
  },[])

  return (
    <div className="App">
      <div className="container">
        <div className="header-container">
          <p className="header gradient-text">My NFT Collection</p>
          <p className="sub-text">
            Each unique. Each beautiful. Discover your NFT today.
          </p>
          {renderNotConnectedContainer()}
        </div>
        <div className="footer-container">
          <img alt="Twitter Logo" className="twitter-logo" src={twitterLogo} />
          <a
            className="footer-text"
            href={TWITTER_LINK}
            target="_blank"
            rel="noreferrer"
          >{`built on @${TWITTER_HANDLE}`}</a>
        </div>
      </div>
    </div>
  );
};

export default App;