const hre = require("hardhat");

async function main() {
  // console.log("hello")
  // const [deployer] = await ethers.getSigners();
  // console.log("Deploying contracts with the account:", deployer);

  // const metadata_ERC20 = JSON.parse(await remix.getFile('./artifacts/contracts/ERC20With4RMechanism.json'))
    const metadata_Tourism = JSON.parse(await remix.call('./artifacts/contracts/Tourism.json'))
    console.log(metadata_Tourism)
    const accounts = await web3.eth.getAccounts()
  
    console.log(accounts)
    
    const owner = accounts[0];
    const address1 = accounts[1];
    const address2 = accounts[2];

    let contractERC20 = new web3.eth.Contract(metadata_ERC20.abi)
    let contractTourism = new web3.eth.Contract(metadata_Tourism.abi)

    contractERC20 = contractERC20.deploy({
        data: metadata_ERC20.data.bytecode.object,
        arguments: [1000000]
    })

    console.log("Contract address ERC20:",await contractERC20.getAddress());

    const contractTourDCWith4RMechanism = await hre.ethers.deployContract("Tourism", [await contractERC20.getAddress()], owner)

    await contractTourDCWith4RMechanism.waitForDeployment();

    console.log("contract Tourism deploy at address: ", await contractTourDCWith4RMechanism.getAddress())
    

    const firstName = "John";
    const lastName = "Doe";
    const phoneNumber = "123456789";

    const tran_register = await contractTourDCWith4RMechanism.register(firstName, lastName, phoneNumber);
    await tran_register.wait();
    console.log("Transaction mined. Registration successful!: ",tran_register);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error.message);
    process.exit(1);
  });

async function saveFrontendFiles(token) {
  const fs = require("fs");
  const contractsDir = path.join(__dirname, "..", '..', "FE", "src", "contracts");

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, "contract-address.json"),
    JSON.stringify({ Token: await token.getAddress() }, undefined, 2)
  );

  const TokenArtifact = artifacts.readArtifactSync("TouristConTract");

  fs.writeFileSync(
    path.join(contractsDir, "TouristConTract.json"),
    JSON.stringify(TokenArtifact, null, 2)
  );
}