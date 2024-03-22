const hre = require("hardhat");
var saveFrontendFiles = require('./saveFilePath')

async function main() {

  const [owner, addr1, addr2] = await ethers.getSigners();
  console.log("owner: ", await owner.getAddress());
  console.log("addr1: ", await addr1.getAddress());
  console.log("addr2: ", await addr2.getAddress());

  // const contractERC20 = await ethers.deployContract("ERC20With4RMechanism", [1000000], owner)
  const contractERC20 = await ethers.getContractFactory("ERC20With4RMechanism");
  // const contractTourism = await ethers.getContractFactory("Tourism");


  const tourDCToken = await contractERC20.deploy(1000000);
  console.log("Contract address ERC20:", await tourDCToken.getAddress());
  await saveFrontendFiles(await tourDCToken.getAddress(), "ERC20With4RMechanism")
  // const contractTourDCWith4RMechanism = await contractTourism.deploy(await tourDCToken.getAddress())
  // console.log("contract Tourism deploy at address: ", await contractTourDCWith4RMechanism.getAddress())
  
  // // Register User

  // const tran_register_1 = await contractTourDCWith4RMechanism.connect(owner).register("Admin", "Super", "999999999");
  // await tran_register_1.wait();
  
  // const tran_register_2 = await contractTourDCWith4RMechanism.connect(addr1).register("Duy", "Nguyen", "0918844446");
  // await tran_register_2.wait();

  // const tran_register_3 = await contractTourDCWith4RMechanism.connect(addr2).register("Phong", "Tran", "01923810923");
  // await tran_register_3.wait();

  // //  Add Place
  // const add_des_1 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7e1f60b126cb2487527", "LightHouse", "Nha Trang, VietNam")
  // const add_des_2 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c838f60b126cb248752d", "Da Lat", "Lam Dong, VietNam")
  // const add_des_3 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7fcf60b126cb2487529", "Secret Cave", "Qui Nhon, VietNam")
  // const add_des_4 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c80ef60b126cb248752b", "Da Nang", "Da Nang, VietNam")

  // // Add Ticket 
  // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65d6ec325ecf27cb3d803d87", "1")
  // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65d6ec325ecf27cb3d803d87", "2")
  // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65d6ec325ecf27cb3d803d87", "3")
  // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65d6ec325ecf27cb3d803d87", "4")

  // // Check In
  // await contractTourDCWith4RMechanism.connect(owner).checkIn("1", "65d6ec325ecf27cb3d803d87")
  // await contractTourDCWith4RMechanism.connect(owner).checkIn("2", "65d6ec325ecf27cb3d803d87")
  // await contractTourDCWith4RMechanism.connect(owner).checkIn("3", "65d6ec325ecf27cb3d803d87")


  // // // Post Review
  // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65d6ec325ecf27cb3d803d87", "Good Place", 40, "Very excited Place");
  // await contractTourDCWith4RMechanism.connect(addr1).reviews("65d6ec325ecf27cb3d803d87", "Excellent Place", 45, "Perfectly!!!");
  // await contractTourDCWith4RMechanism.connect(addr2).reviews("65d6ec325ecf27cb3d803d87", "Dream Place", 50, "Ten Mark No But");

  // // console.log(reviewPost1);
  // // Verify Ticket
  // // get post ID

  // const receipt1 = await reviewPost1.wait();
  // const postID = await receipt1.logs[0].args[1];
  // console.log("PostID: ",postID);

  // await contractTourDCWith4RMechanism.connect(owner).verifyTicket(postID, "1");
  // console.log(await contractTourDCWith4RMechanism.connect(owner).reviewVerify(postID))

  // await contractTourDCWith4RMechanism.connect(addr1).upvote(postID); 
  // await contractTourDCWith4RMechanism.connect(addr2).upvote(postID); 

  // await contractTourDCWith4RMechanism.connect(owner).divideRewardBy4R(postID);
  
  // // await contractTourDCWith4RMechanism.connect(addr1).upvote(postID); 


  // await saveFrontendFiles(await contractTourDCWith4RMechanism.getAddress(), "Tourism")
  // await saveFrontendFiles(await tourDCToken.getAddress(), "ERC20With4RMechanism")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error.message);
    process.exit(1);
  });

