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
        _setTokenURI(newNft, "data:application/json;base64,ewogICAgIm5hbWUiOiAiRXBpY0xvcmRIYW1idXJnZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LGRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBOGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaTgrQ2lBZ1BIUmxlSFFnZUQwaU5UQWxJaUI1UFNJMU1DVWlJR1J2YldsdVlXNTBMV0poYzJWc2FXNWxQU0p0YVdSa2JHVWlJSFJsZUhRdFlXNWphRzl5UFNKdGFXUmtiR1VpSUhOMGVXeGxQU0ptYVd4c09pTm1abVk3Wm05dWRDMW1ZVzFwYkhrNmMyVnlhV1k3Wm05dWRDMXphWHBsT2pFMGNIZ2lQazFsYldWTWIzSmtQQzkwWlhoMFBnbzhMM04yWno0PSIKfQ==");
        console.log("NFT has been minted to %s..", msg.sender);

        //@notice increment the counter for the next minted nft 
        _tokensId.increment(); 
    }
}