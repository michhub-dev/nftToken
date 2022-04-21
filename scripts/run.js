const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("MichyNft");
    const contractFactory = await nftContractFactory.deploy();
    await contractFactory.deployed(); 
    console.log("deployed to this address..", contractFactory.address); 
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