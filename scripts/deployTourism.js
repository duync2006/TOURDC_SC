const hre = require("hardhat");
var saveFrontendFiles = require('./saveFilePath')

async function main() {

  const [owner, addr1, addr2] = await ethers.getSigners();
  console.log("owner: ", await owner.getAddress());
  console.log("addr1: ", await addr1.getAddress());
  console.log("addr2: ", await addr2.getAddress());

  // const contractERC20 = await ethers.deployContract("ERC20With4RMechanism", [1000000], owner)
  const contractTourism = await ethers.getContractFactory("Tourism");
 
  const contractTourDCWith4RMechanism = await contractTourism.deploy("0xb9cc6F587A7bDAe030E3e51b1f78806bB8c5e9ee")
  console.log("contract Tourism deploy at address: ", await contractTourDCWith4RMechanism.getAddress())
  await saveFrontendFiles(await contractTourDCWith4RMechanism.getAddress(), "Tourism")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error.message);
    process.exit(1);
  });
