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

   //@notice store my svg
     string svg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string [] foodItem = ["salt", "seasoning-cube", "crayfish", "pepper", "tommatoes", "onion", "fresh-fish", "vegetables", "semo", "pomo", "stock-fish", "palm-oil", "dried-fish", "assorted", "ogiri"];
    string [] fruits = ["cuccumba", "mango", "avocado", "peneapple", "bananas", "blackberry", "strawberry", "kiwi", "lemon", "carrot", "soursop", "pawpaw", "pears", "apple", "orange"];
    string [] animals = ["dog", "monkey", "geraf", "zebra", "chetah", "antelop", "scurrel", "hippopotamus", "pig", "sheep", "cow", "goat", "eliphant", "tiger", "lion"];

    constructor() ERC721 ("MichyToken", "MTK") {
        console.log("Hey, this is Michy's nft");
    }
    
    //@notice a function that will randomly pick word from each array
    function getRandomFoodItem(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("salt", Strings.toString(tokenId))));
        rand = rand % foodItem.length;
        return foodItem[rand]; 
    }

    function getRandomFruits(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("cuccumba", Strings.toString(tokenId))));
        rand = rand % fruits.length; 
        return fruits[rand]; 
    }
    function getRandomAnimals(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("dog", Strings.toString(tokenId))));
        rand = rand % animals.length;
        return animals[rand];
    }


    function random(string memory input) internal pure returns(uint256) {
 
    }
    //@notice declare a function for users to get their NFT.
    function getNfts() public {
        //@notice get the current tokenid 
        uint256 newNft = _tokensId.current();

         //@notice mint the nft to the sender 
       _safeMint(msg.sender, newNft);
        
        
        //@notice set the nft data
        _setTokenURI(newNft, "data:application/json;base64,ewogICAgIm5hbWUiOiAiRXBpY0xvcmRIYW1idXJnZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0TkNpQWdJQ0E4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGcwS0lDQWdJRHh5WldOMElIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SW1Kc1lXTnJJaUF2UGcwS0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUlhCcFkweHZjbVJJWVcxaWRYSm5aWEk4TDNSbGVIUStEUW84TDNOMlp6ND0iCn0=");
        console.log("NFT has been minted to %s..", msg.sender);

        //@notice increment the counter for the next minted nft 
        _tokensId.increment(); 
    }
}