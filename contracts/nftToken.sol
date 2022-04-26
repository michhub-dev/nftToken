// SPDX-License-Identifier: UNLICENSED
//@notice declare the solidity compiler 
pragma solidity ^0.8.1;

// Import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// import helper functions  
import { Base64 } from "./libraries/Base64.sol";

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
   return uint256(keccak256(abi.encodePacked(input)));
    }

    //@notice declare a function for users to get their NFT.
    function getNfts() public {
        //@notice get the current tokenid 
        uint256 newNft = _tokensId.current();

//@notice randomly grap one word from each of the three array
  string memory firstItem = getRandomFoodItem(newNft);
  string memory secondItem = getRandomFruits(newNft);
  string memory thirdItem = getRandomAnimals(newNft); 
  string memory combineItem = string(abi.encodePacked(firstItem, secondItem,thirdItem));
//@notice combine them all together and close with the tag
  string memory combineItemAndSvg = string(abi.encodePacked(svg, combineItem, "</text></svg>"));

  //@notice get all json metadata 
  //@notice set the title of the nft as the generated word
  //@notice add data:image/svg+xml;base64 and then append base64 encode svg.
  string memory json = Base64.encode(
      bytes(
          string(
              abi.encodePacked(
                  '{"name": "',
                   combineItem, "",
                   "description:" "A highly acclaimed memes.", 
                   "image:" "data:image/svg+xml;base64,'",
                    Base64.encode(bytes(combineItemAndSvg)),
                     '"}'
                )
            )
        )
    );

    //@notice prepend data:application/json;base64, to json
    string memory finalTokenUrl = string(abi.encodePacked("data:application/json;base64,", json));
  console.log("\n--------------------");
 console.log(
    string(
        abi.encodePacked(
            "https://nftpreview.0xdev.codes/?code=",
            finalTokenUrl
        )));
  console.log("--------------------\n");

         //@notice mint the nft to the sender 
       _safeMint(msg.sender, newNft);
        
        
        //@notice set the nft data
        _setTokenURI(newNft, finalTokenUrl);
        console.log("NFT has been minted to %s..", msg.sender);

        //@notice increment the counter for the next minted nft 
        _tokensId.increment(); 
        console.log("An nft has been minted to %s..", newNft, msg.sender);
    }
}