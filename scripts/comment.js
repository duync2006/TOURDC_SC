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
    let postID = '0x93ff9780601a717502fe88a3f2de9dfc95c179af1d02e48d382a19d60afdfde8'
    console.log('comment on postID: ', postID)
    let transaction1  = await contractTourDCWith4RMechanism.connect(addr1).comment(postID, "i agree with u"); 
    let transaction2  = await contractTourDCWith4RMechanism.connect(addr2).comment(postID, "i dont agree with u"); 
    await transaction2.wait()

    console.log("get comments of postID: ", await contractTourDCWith4RMechanism.getAllCommentOfReviewPost(postID))

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