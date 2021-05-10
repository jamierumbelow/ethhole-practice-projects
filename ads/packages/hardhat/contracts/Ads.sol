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

    function buy(
        string memory _newCtaUrl,
        string memory _newImageUrl,
        string memory _newText
    ) public payable {
        require(
            msg.value > currentPrice,
            "you must buy for higher than the currentPrice"
        );

        ctaUrl = _newCtaUrl;
        imageUrl = _newImageUrl;
        text = _newText;
        currentPrice = msg.value;
    }
}
