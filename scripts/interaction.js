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
    
    //checkin
    // postID: 0x977bf9b413168b9ba6b89beb028b5885f8fec5082da4810709ecd320f3a2e6b0
    const checkIn =  await contractTourDCWith4RMechanism.connect(owner).checkIn("65f2c7e1f60b126cb2487527")
    console.log("checkIn hash::", checkIn.hash)
    let checkInReceipt = await checkIn.wait()
    console.log("checkIn postID:", checkInReceipt.logs[0].topics[1])
    let postID = checkInReceipt.logs[0].topics[1]
    // const TouristReview = await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfTourist('0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74')
    // console.log("All review of tourist: ", TouristReview)

    // console.log(await contractTourDCWith4RMechanism.connect(owner).getVoteOfReview('0xd1eb3ddc76b355a05534c1b9284c8139b838f659e7f66747afeea875732ac284'))
    // console.log("string PlaceID: ", utils.parseBytes32String('0x462fb69b67dcea0c861527bc0c3d4ef2d945a6ecde0c6e6250f02b7132161f9f'))
    
    // "0x3e984587159bd3f51b18ef9269138d60fa097c8af2a7544f6e08cfbd8b4efc2b"
    // const TouristReview = await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfTourist(await owner.getAddress())
    // console.log(TouristReview)
    

    
    
    // Post Review
    // nha trang: 65f2c7e1f60b126cb2487527
    // const postID1 = hre.ethers.solidityPackedKeccak256([ "address", "uint", "string" ], [await owner.getAddress(), Date.now(), "65f2c7e1f60b126cb2487527"])
    // console.log(postID1)
    // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7e1f60b126cb2487527",postID, "Good Place", 40, "Very excited Place");
    // console.log(reviewPost1)
    // const postID2 = hre.ethers.solidityPackedKeccak256([ "address", "uint", "string" ], [await owner.getAddress(), Date.now(), "65f2c7e1f60b126cb2487527"])
    await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7e1f60b126cb2487527",postID, "Excellent Place", 45, "Perfectly!!!");
    // await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c7e1f60b126cb2487527", "Dream Place", 50, "Ten Mark No But");

    // Da lat: 65f2c838f60b126cb248752d
    // console.log(await contractTourDCWith4RMechanism.connect(owner).destinationIdentify("65f2c838f60b126cb248752d"))
    // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c838f60b126cb248752d", "My Trip in Dalas", 50, "Love this place very much");
    // await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c838f60b126cb248752d", "Soooo coollll", 45, "Niceeeeeee!!!");
    // await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c838f60b126cb248752d", "Excellent", 50, "You must go to this place!!!");

    // Qui Nhon: 65f2c7fcf60b126cb2487529
    // console.log(await contractTourDCWith4RMechanism.connect(owner).destinationIdentify("65f2c7fcf60b126cb2487529"))
    // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7fcf60b126cb2487529", "Beautiful city", 25, "Love this place very much");
    // await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c7fcf60b126cb2487529", "Nice beach", 30, "goooood!!!");
    // await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c7fcf60b126cb2487529", "Cool", 46, "Niceeee nice nice!!!");

    // Da Nang: 65f2c80ef60b126cb248752b
    // console.log(await contractTourDCWith4RMechanism.connect(owner).destinationIdentify("65f2c80ef60b126cb248752b"))
    // const reviewPost2 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c80ef60b126cb248752b", "Romantic Cityyy <3", 49, "Beautifullll");
    // await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c80ef60b126cb248752b", "Dragon Bridge,  Wow!!!!", 50, "Omg! fire-breathing dragon ");
    // await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c80ef60b126cb248752b", "City of Bridge!", 46, "Niceeee nice nice!!!");


    // Verify Ticket
    // get post ID
    // console.log(await contractTourDCWith4RMechanism.getAllReviewsOfDestinations('65f2c7e1f60b126cb2487527'))
    
    // const postID = '0xa254ca76fb57b0e8c601578afcd9ac7c308a13f6e49998e879fe850f96cac540'
    // console.log("review Post:", await contractTourDCWith4RMechanism.reviewByID(postID))
    // await contractTourDCWith4RMechanism.connect(owner).verifyTicket(postID, "1");
    // console.log(await contractTourDCWith4RMechanism.connect(owner).reviewVerify(postID))

    // await contractTourDCWith4RMechanism.connect(addr1).upvote(postID); 
    // await contractTourDCWith4RMechanism.connect(addr2).upvote(postID); 

    // await contractTourDCWith4RMechanism.connect(owner).divideRewardBy4R(postID);
    
    // await contractTourDCWith4RMechanism.connect(addr1).upvote(postID); 


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