// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

struct Election {
    // - start / end times
    uint256 beginRegistrationAtBlock;
    uint256 endRegistrationAtBlock;
    uint256 beginVotingAtBlock;
    uint256 endVotingAtBlock;
    // - voting mechanics
    address[] candidates;
    mapping(address => address) votes;
}

contract Voting {
    // - owner address => Election
    mapping(address => Election) elections;
}
