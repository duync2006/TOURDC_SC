// scripts/migrate_contract.js
const hre = require("hardhat");

// Contract address ERC20: 0x3e20d1E136117F5b3437d8C2458E428D9B27562E
// contract Tourism deploy at address:  0xCdadBec150F4F8f6E2D196FddcC1d12533D5035c
async function main() {
  try {
    const [owner, addr1, addr2] = await ethers.getSigners();
    console.log("owner: ", await owner.getAddress());
    console.log("addr1: ", await addr1.getAddress());
    console.log("addr2: ", await addr2.getAddress());

    // Get the ContractFactory of your SimpleContract
    const SimpleContract = await hre.ethers.getContractFactory("ERC20With4RMechanism");

    // Connect to the deployed contract
    const contractAddress = "0xb9cc6F587A7bDAe030E3e51b1f78806bB8c5e9ee"; // Replace with your deployed contract address
    const contract = await SimpleContract.attach(contractAddress);
    console.log(await contract.balanceOf("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"));
    
    const tourismContract = await hre.ethers.getContractFactory("Tourism");
    const contractTourDCWith4RMechanism = await tourismContract.attach("0x6fdCBc714365fAE22038AA40f6B27E7E1a833230")

    // const tran_register_1 = await contractTourDCWith4RMechanism.connect(owner).register("Admin", "Super", "999999999");
    // await tran_register_1.wait();
    
    // const tran_register_2 = await contractTourDCWith4RMechanism.connect(addr1).register("Duy", "Nguyen", "0918844446");
    // await tran_register_2.wait();

    // const tran_register_3 = await contractTourDCWith4RMechanism.connect(addr2).register("Phong", "Tran", "01923810923");
    // await tran_register_3.wait();
    

    // const add_des_1 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7e1f60b126cb2487527", "LightHouse", "Nha Trang, VietNam")
    // const add_des_2 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c838f60b126cb248752d", "Da Lat", "Lam Dong, VietNam")
    // const add_des_3 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7fcf60b126cb2487529", "Secret Cave", "Qui Nhon, VietNam")
    // const add_des_4 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c80ef60b126cb248752b", "Da Nang", "Da Nang, VietNam")
    



    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "1")
    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "2")
    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "3")
    await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "4")

    // Set a new message in the contract
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"))
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x1a620c351c07763f430897AeaA2883E37cA0aaCD"))
    console.log(await contractTourDCWith4RMechanism.connect(owner).touristIdentify("0x9E0E58F9052aDc53986eA9ca7cf8389b0EdE364f"))
    
    //checkin
    // await contractTourDCWith4RMechanism.connect(owner).checkIn("1", "65f2c7e1f60b126cb2487527")
    // await contractTourDCWith4RMechanism.connect(owner).checkIn("2", "65f2c7e1f60b126cb2487527")
    // await contractTourDCWith4RMechanism.connect(owner).checkIn("3", "65f2c7e1f60b126cb2487527")
    
    // Post Review
    // nha trang: 65f2c7e1f60b126cb2487527
    // const reviewPost1 = await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7e1f60b126cb2487527", "Good Place", 40, "Very excited Place");
    // await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c7e1f60b126cb2487527", "Excellent Place", 45, "Perfectly!!!");
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
    console.log(await contractTourDCWith4RMechanism.getAllReviewsOfDestinations('65f2c80ef60b126cb248752b'))
    
    const postID = '0xa254ca76fb57b0e8c601578afcd9ac7c308a13f6e49998e879fe850f96cac540'
    console.log("review Post:", await contractTourDCWith4RMechanism.reviewByID(postID))
    await contractTourDCWith4RMechanism.connect(owner).verifyTicket(postID, "1");
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