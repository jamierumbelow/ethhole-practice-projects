pragma solidity >=0.6.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

//import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Ads {
    event SetPurpose(address sender, string purpose);

    uint256 public currentPrice = 1 ether;
    string public ctaUrl = "http://jamierumbelow.net/";
    string public imageUrl = "http://jamierumbelow.net/images/me.png";
    string public text = "Hire your next CTO";

    constructor() {
        // what should we do on deploy?
    }

    function bid() public payable {}
}
