const main = async () => {
    const gameContractFactory = await ethers.getContractFactory("MyEpicGame");

    const gameContract = await gameContractFactory.deploy();

    await gameContract.deployed();
    console.log("Contrtact deployed at: ", gameContract.address);
};

const runMain = async () => {
    try {
        await main();
    } catch (error) {
        console.log(error);
    }
};

runMain();