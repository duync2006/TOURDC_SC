// scripts/migrate_contract.js
const hre = require("hardhat");
const {utils } = require('ethers')
var tourism_address = require('../deploys/Tourism-address.json').Token
var ERC20_address = require('../deploys/ERC20With4RMechanism-address.json').Token

async function main() {
  try {
    const [owner, addr1, addr2, addr3] = await ethers.getSigners();
    console.log("owner: ", await owner.getAddress());
    console.log("addr1: ", await addr1.getAddress());
    console.log("addr2: ", await addr2.getAddress());
    console.log("addr3: ", await addr3.getAddress());
    // Get the ContractFactory of your SimpleContract
    const ERC20 = await hre.ethers.getContractFactory("ERC20With4RMechanism");

    // Connect to the deployed contract
    const contract = await ERC20.attach(ERC20_address);
    console.log(await contract.balanceOf("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"));
    
    const tourismContract = await hre.ethers.getContractFactory("Tourism",  {libraries: {
      Math:  "0x097718b598DeE6C3a13F24BA0C79f5d924261B6F",
    }});
    const contractTourDCWith4RMechanism = await tourismContract.attach(tourism_address)

    // const add_des_1 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7e1f60b126cb2487527", "LightHouse", "Nha Trang, VietNam")
    // const add_des_2 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c838f60b126cb248752d", "Da Lat", "Lam Dong, VietNam")
    // const add_des_3 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c7fcf60b126cb2487529", "Secret Cave", "Qui Nhon, VietNam")
    // const add_des_4 = await contractTourDCWith4RMechanism.connect(owner).addDestination("65f2c80ef60b126cb248752b", "Da Nang", "Da Nang, VietNam")
    
    // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "1")
    // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "2")
    // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "3")
    // await contractTourDCWith4RMechanism.connect(owner).addPlaceTicket("65f2c80ef60b126cb248752b", "4")

    // Set a new message in the contract
    console.log(await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfDestinations('65f2c7e1f60b126cb2487527'))


    let destinationReviews = await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfDestinations('65f2c7e1f60b126cb2487527')
    const result = destinationReviews.map(async (review) => {
      let isVoted = await contractTourDCWith4RMechanism.connect(owner).isVoted('0x1a620c351c07763f430897AeaA2883E37cA0aaCD', review[1])
      return([...review, isVoted])
    })

    // console.log([...destinationReviews[0], false])
    await Promise.all(result).then((resolvedResult) => {
      console.log('result: ', resolvedResult);
    });

    console.log('tourist reviews: ', await contractTourDCWith4RMechanism.connect(owner).getAllReviewsOfTourist('0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74'))
    console.log('tourist REP: ', await contractTourDCWith4RMechanism.connect(owner).touristREP('0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74'))

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