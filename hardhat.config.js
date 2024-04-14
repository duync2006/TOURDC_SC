require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ethers");
// require("@nomiclabs/hardhat-waffle");
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.4",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    // hardhat: {
    //   chainId: 1337,
    //   // accounts: [{privateKey: "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80", balance: "1000000000000000000000"}],
    // },
    vibi: {
      chainId: 306,
      url: "https://vibi.vbchain.vn/",
      accounts: [
       "0xe11f5c9977c82fe752f84caeb9ba0c50feabd0ce90088cb26e61ee0fce5950c2",
       "0x40cf31902207cedc9a262552fb975403ecbd907d3407140d389922189594a553",
       "0x5a4b53f1f3acc7b381f5159399deab7f579f9cefafe8e31b36a4822feb3c3703",
       "0x71630cd12b7c5e53829f0b83cef4e45fd22ef80f9f8b4072ba3bca06604d6c55"
      ]
    },
    agd: {
      chainId: 8888,
      url: " https://agd-seed-3.vbchain.vn/",
      accounts: ["0xe11f5c9977c82fe752f84caeb9ba0c50feabd0ce90088cb26e61ee0fce5950c2", "0x40cf31902207cedc9a262552fb975403ecbd907d3407140d389922189594a553", "0x5a4b53f1f3acc7b381f5159399deab7f579f9cefafe8e31b36a4822feb3c3703"]
    },
    sepolia: {
      chainId: 11155111,
      url: "https://sepolia.infura.io/v3/c6b95d3b003e40cda8dcf76f7ba58be8",
      accounts: ["0xe11f5c9977c82fe752f84caeb9ba0c50feabd0ce90088cb26e61ee0fce5950c2", "0x40cf31902207cedc9a262552fb975403ecbd907d3407140d389922189594a553", "0x5a4b53f1f3acc7b381f5159399deab7f579f9cefafe8e31b36a4822feb3c3703"]
    }, 
    ganache: {
      chainId: 1337,
      url: "HTTP://192.168.1.39:7545",
      gasPrice: 20000000000,
      accounts: ["0x8b8e5a72f06b31f9b507661a22ab0d03783d6238c0b2b724d724bb97b21e1d16", "0x8cc19abad6ecf08bb09b4f0db72a9d9510ed75c3e6b60055f3425f8df838131e", "0x6113dd34a066f267708ca258c393661518128af04e67abed0d09a17761cff4c5"]
    
    }
  }
};
