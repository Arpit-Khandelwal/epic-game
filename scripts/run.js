const main = async () => {
    const gameContractFactory = await ethers.getContractFactory("MyEpicGame");

    const gameContract = await gameContractFactory.deploy(
        ["Eren", "Mikasa", "Armin"],
        ["https://imgur.com/lSPLbjE.png", "https://i.imgur.com/5elwz6i.png", "https://i.imgur.com/ZTgfFAL.png"],
        [1000, 500, 250],
        [200,150,100]
    );

    await gameContract.deployed();
    console.log("Contrtact deployed at: ", gameContract.address);

    let txn;
    txn = await gameContract.mintCharacterNFT(0);
    await txn.wait();

    let returnedTokenURI = await gameContract.tokenURI(1);
    console.log("Token URI: ", returnedTokenURI);
};

const runMain = async () => {
    try {
        await main();
    } catch (error) {
        console.log(error);
    }
};

runMain();