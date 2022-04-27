import React, { useEffect, useState } from "react";
import './styles/App.css';
import twitterLogo from './assets/twitter-logo.svg';
import { ethers } from "ethers";
import MichyNft from './utils/MichyNft.json';

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
  const connectWallet = async () => {
   try{
      const { ethereum } = window;

    if (!ethereum) {
      alert("Get metamask");
      return;
    }

    // Request access to account 
 const accounts = await ethereum.request({ method: "eth_requestAccounts" });
     console.log("Connected", accounts[0]);
 const userAddress = setUserAccount(accounts[0]);
  } catch(error){
     console.log(error);
  }
   }
  const callContractFromWeb = async () => {
    const contractAddress = "0xaaD1b3C55671379DC208AB2De6143798b3809446";

    try{
      const { ethereum } = window;

      if (ethereum) {
        const provider = new ethers.providers.web3Provider(ethereum);
        const signer = provider.getSigner();
        // create the connection to the contract 
        const connectContract = new ethers.contract(contractAddress, MichyNft.abi, signer);

        console.log("pop wallet now to pay gas...")
        //call the contract
        const nftTxn = await connectContract.getNfts();
        console.log("Mining...pls wait");
          await nftTxn.wait();//wait for it to be mined
        // link the etherscan url 
        console.log(`Mined, view transaction: https://rinkeby.etherscan.io/tx/${nftTxn.hash}`);
      } else{
        alert("ethereum object doesn't exist");
      }
    } catch(error) {
      console.log(error)
    }
  }
  

  // Render Methods
  const renderNotConnectedContainer = () => (
    <button className="cta-button connect-wallet-button" onClick={connectWallet}>
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
          <p className="header gradient-text">Michy's NFT Collection</p>
          <p className="sub-text">
            Each unique. Each beautiful. Discover your NFT today.
          </p>
         {/* {renderNotConnectedContainer()}
           <p className="sub-text">Contract public addresses {userAddress}</p> */}
        </div>
          {userAccount === "" 
     ? renderNotConnectedContainer()
    : (
      <button onClick={callContractFromWeb} className="cta-button connect-wallet-button"> Mint NFT</button>
    )}
  );
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