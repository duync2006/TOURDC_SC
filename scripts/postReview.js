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


    
    //checkin
    // postID: 0x977bf9b413168b9ba6b89beb028b5885f8fec5082da4810709ecd320f3a2e6b0
    const checkIn =  await contractTourDCWith4RMechanism.connect(owner).checkIn("65f2c7e1f60b126cb2487527")
    console.log("checkIn hash::", checkIn.hash)
    let checkInReceipt = await checkIn.wait()
    console.log("checkIn postID:", checkInReceipt.logs[0].topics[1])
    let postID = checkInReceipt.logs[0].topics[1]

    // Post Review
    // nha trang: 65f2c7e1f60b126cb2487527
    const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7e1f60b126cb2487527",postID, "Nice", 30, "Very nice Place");
    await reviewPost1.wait()
    const TouristReview = await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfTourist('0x9E0E58F9052aDc53986eA9ca7cf8389b0EdE364f')
    console.log("All review of tourist: ", TouristReview)

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