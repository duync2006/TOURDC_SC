// scripts/migrate_contract.js

const { ethers } = require("hardhat");

async function main() {
  // Lấy trạng thái của smart contract cũ
  const oldContractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"; // Địa chỉ của smart contract cũ
  const OldContract = await ethers.getContractFactory("Tourism");
  const oldContract = await OldContract.attach(oldContractAddress);

  // Lấy dữ liệu từ smart contract cũ

  // Triển khai smart contract mới với dữ liệu từ smart contract cũ
  const NewContract = await ethers.getContractFactory("Tourism");
  const newContract = await oldContract.deploy();

  console.log("New Contract deployed to:", newContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });