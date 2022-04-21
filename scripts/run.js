const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("MichyNft");
    const contractFactory = await nftContractFactory.deploy();
    await contractFactory.deployed(); 
    console.log("deployed to this address..", contractFactory.address); 

    // @notice call the function 
    let mintNftContract = await contractFactory.getNfts();
    //@notice wait for it to mine 
    await mintNftContract.wait();

    //@notice mint another nft 
    mintNftContract = await contractFactory.getNfts();
  //@notice wait for it to mine 
    await mintNftContract.wait();
};

const runMain = async () => {
    try{
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};
runMain(); 