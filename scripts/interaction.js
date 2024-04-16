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
    console.log("Register ....")
    const tran_register_1 = await contractTourDCWith4RMechanism.connect(owner).register();
    const tran_register_2 = await contractTourDCWith4RMechanism.connect(addr1).register();
    const tran_register_3 = await contractTourDCWith4RMechanism.connect(addr2).register()
    await tran_register_1.wait();

    console.log("add destination ....")
    
    const add_des_1 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7e1f60b126cb2487527", "LightHouse", "Nha Trang, VietNam")
    const add_des_2 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c838f60b126cb248752d", "Da Lat", "Lam Dong, VietNam")
    const add_des_3 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7fcf60b126cb2487529", "Secret Cave", "Qui Nhon, VietNam")
    const add_des_4 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c80ef60b126cb248752b", "Da Nang", "Da Nang, VietNam")
    // Set a new message in the contract
    // Post Review
    // nha trang: 65f2c7e1f60b126cb2487527
    //checkin
    console.log('Check In Nha Trang...')
    const checkIn =  await contractTourDCWith4RMechanism.connect(owner).checkIn("65f2c7e1f60b126cb2487527")
    console.log("checkIn hash::", checkIn.hash)
    let checkInReceipt = await checkIn.wait()
    console.log("checkIn postID:", checkInReceipt.logs[0].topics[1])
    let postID = checkInReceipt.logs[0].topics[1]
    console.log('Reviews In Nha Trang...')
    await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7e1f60b126cb2487527",postID, "Excellent Place", 45, "Perfectly!!!");
    await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c7e1f60b126cb2487527", "0x0000000000000000000000000000000000000000000000000000000000000000", "Soooo coollll", 45, "Niceeeeeee!!!");
    await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c7e1f60b126cb2487527", "0x0000000000000000000000000000000000000000000000000000000000000000", "Excellent", 50, "You must go to this place!!!");
    
    console.log('Done')

    // await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c7e1f60b126cb2487527", "Dream Place", 50, "Ten Mark No But");

    // Da lat: 65f2c838f60b126cb248752d
    console.log("Reviews in Da Lat...")
    await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c838f60b126cb248752d","0x0000000000000000000000000000000000000000000000000000000000000000", "My Trip in Dalas", 50, "Love this place very much");
    await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c838f60b126cb248752d", "0x0000000000000000000000000000000000000000000000000000000000000000", "Soooo coollll", 45, "Niceeeeeee!!!");
    await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c838f60b126cb248752d", "0x0000000000000000000000000000000000000000000000000000000000000000", "Excellent", 50, "You must go to this place!!!");
    console.log("Done")

    // Qui Nhon: 65f2c7fcf60b126cb2487529
    console.log("Reviews in Qui Nhon...")
    await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c7fcf60b126cb2487529","0x0000000000000000000000000000000000000000000000000000000000000000", "Beautiful city", 25, "Love this place very much");
    await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c7fcf60b126cb2487529","0x0000000000000000000000000000000000000000000000000000000000000000", "Nice beach", 30, "goooood!!!");
    await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c7fcf60b126cb2487529","0x0000000000000000000000000000000000000000000000000000000000000000", "Cool", 46, "Niceeee nice nice!!!");
    console.log("Done")

    // Da Nang: 65f2c80ef60b126cb248752b
    console.log("Reviews in Da Nang...")
    await contractTourDCWith4RMechanism.connect(owner).reviews("65f2c80ef60b126cb248752b","0x0000000000000000000000000000000000000000000000000000000000000000", "Romantic Cityyy <3", 49, "Beautifullll");
    await contractTourDCWith4RMechanism.connect(addr1).reviews("65f2c80ef60b126cb248752b","0x0000000000000000000000000000000000000000000000000000000000000000", "Dragon Bridge,  Wow!!!!", 50, "Omg! fire-breathing dragon ");
    await contractTourDCWith4RMechanism.connect(addr2).reviews("65f2c80ef60b126cb248752b","0x0000000000000000000000000000000000000000000000000000000000000000", "City of Bridge!", 46, "Niceeee nice nice!!!");
    console.log("Done")

    console.log('upvoting ...')
    await contractTourDCWith4RMechanism.connect(addr1).upvote(postID); 
    await contractTourDCWith4RMechanism.connect(addr2).upvote(postID); 
    console.log('Done')
    console.log('Divide Reward By 4R')
    let transaction = await contractTourDCWith4RMechanism.connect(owner).divideRewardBy4R(postID);
    await transaction.wait()
    console.log('Done')
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