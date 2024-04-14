// scripts/migrate_contract.js
const hre = require("hardhat");
const {utils} = require('ethers')
var tourism_address = require('../deploys/Tourism-address.json').Token
var ERC20_address = require('../deploys/ERC20With4RMechanism-address.json').Token

async function main() {
  try {
    const [owner, addr1, addr2] = await ethers.getSigners();
    console.log("owner: ", await owner.getAddress());
    console.log("addr1: ", await addr1.getAddress());
    console.log("addr2: ", await addr2.getAddress());
    // Get the ContractFactory of your SimpleContract
    const ERC20 = await hre.ethers.getContractFactory("ERC20With4RMechanism");

    // Connect to the deployed contract
    const contract = await ERC20.attach(ERC20_address);
    console.log(await contract.balanceOf("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"));
    
    const tourismContract = await hre.ethers.getContractFactory("Tourism",  {libraries: {
      Math:  "0x097718b598DeE6C3a13F24BA0C79f5d924261B6F",
    }});
    const contractTourDCWith4RMechanism = await tourismContract.attach(tourism_address)


    // Set a new message in the contract
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"))
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x1a620c351c07763f430897AeaA2883E37cA0aaCD"))
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x9E0E58F9052aDc53986eA9ca7cf8389b0EdE364f"))
    
    let postID = '0xadf02da66b991433dc4d4c2dd47c2cda0c692634cd3ecb82191891ab746b5336'
    await contractTourDCWith4RMechanism.connect(addr1).upvote(postID); 
    let transaction1 = await contractTourDCWith4RMechanism.connect(addr2).upvote(postID); 
    await transaction1.wait()

    

    // Retrieve the updated message
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });