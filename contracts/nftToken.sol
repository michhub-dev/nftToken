// SPDX-License-Identifier: UNLICENSED
//@notice declare the solidity compiler 
pragma solidity ^0.8.1;

// Import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MichyNft is ERC721URIStorage  {
   // @notice helps to keep tract of TokensIds 
   using Counters for Counters.Counter;
   Counters.Counter private _tokensId; 

    constructor() ERC721 ("MichyToken", "MTK") {
        console.log("Hey, this is Michy's nft");
    }
    
    //@notice declare a function for users to get their NFT.
    function getNfts() public {
        //@notice get the current tokenid 
        uint256 newNft = _tokensId.current();

         //@notice mint the nft to the sender 
       _safeMint(msg.sender, newNft);
        
        
        //@notice set the nft data
        _setTokenURI(newNft, "data:application/json;base64,ewogICAgIm5hbWUiOiAiTWVtZUxvcmQiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgY29taWMgTWVtZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStUV1Z0WlV4dmNtUThMM1JsZUhRK0Nqd3ZjM1puUGc9PSIKfQ==");
        console.log("NFT has been minted to %s..", msg.sender);

        //@notice increment the counter for the next minted nft 
        _tokensId.increment(); 
    }
}