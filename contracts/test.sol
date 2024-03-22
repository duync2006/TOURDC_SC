// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract DUYToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("VBC_ERC20", "VBC_ERC20") {
        _mint(msg.sender, initialSupply);
    }
}