const hre = require("hardhat");
const fs = require("fs");
// const { ethers } = require("hardhat");
var path = require('path');
async function main() {

  const [owner, addr1, addr2] = await ethers.getSigners();
  console.log("owner: ", await owner.getAddress());
  console.log("addr1: ", await addr1.getAddress());
  console.log("addr2: ", await addr2.getAddress());

  // const contractERC20 = await ethers.deployContract("ERC20With4RMechanism", [1000000], owner)
  const contractERC20 = await ethers.getContractFactory("ERC20With4RMechanism");
  const contractTourism = await ethers.getContractFactory("Tourism");


  const tourDCToken = await contractERC20.deploy(1000000);
  const ownerBalance = await tourDCToken.balanceOf(await owner.getAddress());
  console.log("ownerBalance: ", ownerBalance)
  console.log("Contract address ERC20:", await tourDCToken.getAddress());

  const contractTourDCWith4RMechanism = await contractTourism.deploy(await tourDCToken.getAddress())
  console.log("contract Tourism deploy at address: ", await contractTourDCWith4RMechanism.getAddress())
  
  // const firstName = "John";
  // const lastName = "Doe";
  // const phoneNumber = "123456789";

  // const tran_register = await contractTourDCWith4RMechanism.register(firstName, lastName, phoneNumber);
  // await tran_register.wait();
  // console.log("Transaction mined. Registration successful!: ",tran_register);
  await saveFrontendFiles(await contractTourDCWith4RMechanism.getAddress(), "Tourism")
  await saveFrontendFiles(await tourDCToken.getAddress(), "ERC20With4RMechanism")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error.message);
    process.exit(1);
  });

async function saveFrontendFiles(address, name) {

  const contractsDir = path.join(__dirname, "..", '..', "TourDC_FE", "TourDC-FE", "contracts");
  // console.log(contractsDir)
  const contractsDirTokenAddress = path.join(__dirname, "..", '..', "TourDC_FE", "TourDC-FE", "contracts", `${name}-address.json`);
  const contractsDirABI = path.join(__dirname, "..", '..', "TourDC_FE", "TourDC-FE", "contracts", `${name}-address.json`);
  if (!fs.existsSync(contractsDir)) {
    console.log("hello")
    fs.mkdirSync(contractsDir);
  }
  // console.log("hello2")
  // if (!fs.existsSync(contractsDirTokenAddress)) {
  //   fs.mkdirSync(contractsDirTokenAddress);
  // }

  // if (!fs.existsSync(contractsDirABI)) {
  //   fs.mkdirSync(contractsDirABI);
  // }

  fs.writeFileSync(
    path.join(contractsDir, `${name}-address.json`),
    JSON.stringify({ Token: address }, undefined, 2)
  );

  const TokenArtifact = artifacts.readArtifactSync(`${name}`);

  fs.writeFileSync(
    path.join(contractsDir, `${name}.json`),
    JSON.stringify(TokenArtifact, null, 2)
  );
}