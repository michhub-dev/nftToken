import React, { useEffect, useState } from "react";
import './styles/App.css';
import twitterLogo from './assets/twitter-logo.svg';
import { ethers } from "ethers";
import MichyNft from './utils/MichyNft.json';

// Constants
const TWITTER_HANDLE = 'michyToken';
const TWITTER_LINK = `https://twitter.com/${TWITTER_HANDLE}`;
const OPENSEA_LINK = "https://testnets.opensea.io/collection/michytoken-hjpoekjts2";
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
    setEventListener();
    
    } else {
      console.log("No authorized account found");
    }
  }
  // function to connect the wallet
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

     let chainId = await ethereum.request({method: "eth_chainId"});
     console.log("Connected to chain..", chainId);

     let rinkebyChainId = "0x4";
     if(chainId !== rinkebyChainId) {
       alert("You are not connected to the rinkeby test network!");
     }
     setEventListener();
  } catch(error){
     console.log(error);
  }
   }
  // set an event listener to capture the mint event, get the tokenId, and give the user their OpenSea link for their newly minted NFT.
  const setEventListener = async () => {
    try{
      const { ethereum } = window;

      if(ethereum){
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectContract = new ethers.Contract(contractAddress, MichyNft.abi, signer);
connectContract.on(NewMichyNftMinted, (from, tokenId) => {
  console.log(from, tokenId.toNumber());
  alert(`Your NFT has been minted and sent to your wallet. It may be blank right now, it could take a max of 10 min to show on the opensea. View it here: https://testnets.opensea.io/assets/${contractAddress}/${tokenId.toNumber()}`);
});
        console.log("Set up event listener")
      
    
    } else {
        console.log("Ethereum object doesn't exist");
      } 
    } catch(error){
      console.log(error)
      }
  }

  // function to call the contract from the web
  const callContractFromWeb = async () => {
    const contractAddress = "0xD51CeA86C9Ce8DcA05122CfE498220cbfcAaE948";

    try{
      const { ethereum } = window;

      if (ethereum) {
  const provider = new ethers.providers.Web3Provider(ethereum);
const signer = provider.getSigner();
        // create the connection to the contract 
        const connectContract = new ethers.Contract(contractAddress, MichyNft.abi, signer);
        

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
  const renderNotConnected = () => (
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
         {/* {renderNotConnected()}
           <p className="sub-text">Contract public addresses {userAddress}</p> */}
        </div>
          {userAccount === "" 
     ? renderNotConnected()
    : (
      <button onClick={callContractFromWeb} className="cta-button connect-wallet-button"> Mint NFT</button>
    )}
  );
        <div className="footer-container">
       <a
            className="footer-text"
            href={OPENSEA_LINK}
            target="_blank"
            rel="noreferrer"
          >View collection on OpenSea </a>
          <img alt="Twitter Logo" className="twitter-logo" src={twitterLogo} />
          <a
            className="footer-text"
            href={TWITTER_LINK}
            target="_blank"
            rel="noreferrer"
          >{`Follow me @${TWITTER_HANDLE}`}</a>
        </div>
      </div>
    </div>
  );
};

export default App;