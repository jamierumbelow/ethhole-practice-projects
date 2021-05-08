// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
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

    // - owner address => Election
    mapping(address => Election) public elections;
}
