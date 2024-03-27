// scripts/migrate_contract.js
const hre = require("hardhat");
const {utils } = require('ethers')
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

    const tran_register_1 = await contractTourDCWith4RMechanism.connect(owner).register("Admin", "Super", "999999999");
    await tran_register_1.wait();
    
    const tran_register_2 = await contractTourDCWith4RMechanism.connect(addr1).register("Duy", "Nguyen", "0918844446");
    await tran_register_2.wait();

    const tran_register_3 = await contractTourDCWith4RMechanism.connect(addr2).register("Phong", "Tran", "01923810923");
    await tran_register_3.wait();
    

    const add_des_1 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7e1f60b126cb2487527", "LightHouse", "Nha Trang, VietNam")
    const add_des_2 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c838f60b126cb248752d", "Da Lat", "Lam Dong, VietNam")
    const add_des_3 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7fcf60b126cb2487529", "Secret Cave", "Qui Nhon, VietNam")
    const add_des_4 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c80ef60b126cb248752b", "Da Nang", "Da Nang, VietNam")
    



    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "1")
    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "2")
    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "3")
    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "4")

    // Set a new message in the contract
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"))
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x1a620c351c07763f430897AeaA2883E37cA0aaCD"))
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x9E0E58F9052aDc53986eA9ca7cf8389b0EdE364f"))
    
    // //checkin
    
    // // const checkIn =  await contractTourDCWith4RMechanism.connect(owner).checkIn("65f2c7e1f60b126cb2487527")
    // // console.log(checkIn)
    // // "0x3e984587159bd3f51b18ef9269138d60fa097c8af2a7544f6e08cfbd8b4efc2b"
    // // const TouristReview = await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfTourist(await owner.getAddress())
    // // console.log(TouristReview)
    

    
    
    // // Post Review
    // // nha trang: 65f2c7e1f60b126cb2487527
    // const postID1 = hre.ethers.solidityPackedKeccak256([ "address", "uint", "string" ], [await owner.getAddress(), Date.now(), "65f2c7e1f60b126cb2487527"])
    // console.log(postID1)
    // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7e1f60b126cb2487527",postID1, "Good Place", 40, "Very excited Place");
    // console.log(reviewPost1)
    // const postID2 = hre.ethers.solidityPackedKeccak256([ "address", "uint", "string" ], [await owner.getAddress(), Date.now(), "65f2c7e1f60b126cb2487527"])
    // await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c7e1f60b126cb2487527",postID2, "Excellent Place", 45, "Perfectly!!!");
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
    // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c80ef60b126cb248752b", "Romantic Cityyy <3", 49, "Beautifullll");
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