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
        _setTokenURI(newNft, "https://jsonkeeper.com/b/NPDP");
        console.log("NFT has been minted to %s..", msg.sender);

        //@notice increment the counter for the next minted nft 
        _tokensId.increment(); 
    }
}