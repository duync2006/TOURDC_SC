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
    
    const tourismContract = await hre.ethers.getContractFactory("Tourism",  {libraries: {
      Math:  "0x097718b598DeE6C3a13F24BA0C79f5d924261B6F",
    }});
    const contractTourDCWith4RMechanism = await tourismContract.attach(tourism_address)


    // Set a new message in the contract
    // let transaction = await contractTourDCWith4RMechanism.connect(owner).divideRewardBy4R('0x73507947b34f472b0ff4b9c9649084da6e3190bb0387612ae9876dcb4d116a37');
    // await transaction.wait()
    console.log('Reward List of Owner: ', await contractTourDCWith4RMechanism.connect(owner).seeRewardLists())
    console.log('Reward List of addr1: ', await contractTourDCWith4RMechanism.connect(addr1).seeRewardLists())
    console.log('Reward List of addr2: ', await contractTourDCWith4RMechanism.connect(addr2).seeRewardLists())

    console.log(await contract.balanceOf("0x76E046c0811edDA17E57dB5D2C088DB0F30DcC74"));
    console.log(await contract.balanceOf("0x1a620c351c07763f430897AeaA2883E37cA0aaCD"));
    console.log(await contract.balanceOf("0x9E0E58F9052aDc53986eA9ca7cf8389b0EdE364f"));


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