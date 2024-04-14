const hre = require("hardhat");
var {saveFrontendFiles, saveSCFiles} = require('./saveFilePath')
const erc20_address = require('../deploys/ERC20With4RMechanism-address.json').Token
async function main() {

  const [owner, addr1, addr2] = await ethers.getSigners();
  console.log("owner: ", await owner.getAddress());
  console.log("addr1: ", await addr1.getAddress());
  console.log("addr2: ", await addr2.getAddress());

  const library = await ethers.getContractFactory("Math");
  const MathLib = await library.deploy();
  console.log("Lib address: ", await MathLib.getAddress())

  // const contractERC20 = await ethers.deployContract("ERC20With4RMechanism", [1000000], owner)
  const contractTourism = await ethers.getContractFactory("Tourism", {
    libraries: {
      Math:  await MathLib.getAddress(),
    },});
 
  const contractTourDCWith4RMechanism = await contractTourism.deploy(erc20_address)
  console.log("contract Tourism deploy at address: ", await contractTourDCWith4RMechanism.getAddress())
  // await saveFrontendFiles(await contractTourDCWith4RMechanism.getAddress(), "Tourism")
  await saveSCFiles(await contractTourDCWith4RMechanism.getAddress(), "Tourism")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error.message);
    process.exit(1);
  });
