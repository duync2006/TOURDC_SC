const hre = require("hardhat");
var {saveFrontendFiles, saveSCFiles} = require('./saveFilePath')

async function main() {

  const [owner, addr1, addr2] = await ethers.getSigners();
  console.log("owner: ", await owner.getAddress());
  console.log("addr1: ", await addr1.getAddress());
  console.log("addr2: ", await addr2.getAddress());

  const contractERC20 = await ethers.getContractFactory("ERC20With4RMechanism");

  const tourDCToken = await contractERC20.deploy(1000000);
  console.log("Contract address ERC20:", await tourDCToken.getAddress());
  await saveFrontendFiles(await tourDCToken.getAddress(), "ERC20With4RMechanism")
  await saveSCFiles(await tourDCToken.getAddress(), "ERC20With4RMechanism")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error.message);
    process.exit(1);
  });

