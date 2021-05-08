// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
    // State
    // -------------------------------------------------------------------------

    struct Candidate {
        address owner;
        string name;
    }

    struct Election {
        // - metadata
        string title;
        // - start / end times
        uint256 beginRegistrationAtBlock;
        uint256 endRegistrationAtBlock;
        uint256 beginVotingAtBlock;
        uint256 endVotingAtBlock;
    }

    uint256 internal electionIdCounter = 0;
    mapping(address => uint256[]) public ownerElectionIds;
    mapping(uint256 => Election) public elections;
    mapping(uint256 => Candidate[]) public candidates;
    // electionId => [ voterAddress => candidateAddress ]
    mapping(uint256 => mapping(address => address)) public votes;

    // Public Functions
    // -------------------------------------------------------------------------

    function createElection(
        string memory _title,
        uint256 _beginRegistrationAtBlock,
        uint256 _endRegistrationAtBlock,
        uint256 _beginVotingAtBlock,
        uint256 _endVotingAtBlock
    ) public returns (uint256) {
        require(bytes(_title).length > 0, "title must be non-empty");
        require(
            _beginRegistrationAtBlock > block.timestamp,
            "registration must begin in the future"
        );
        require(
            _endRegistrationAtBlock > _beginRegistrationAtBlock,
            "registration must end after it begins"
        );
        require(
            _beginVotingAtBlock > _endRegistrationAtBlock,
            "voting must begin after registration ends"
        );
        require(
            _endVotingAtBlock > _beginVotingAtBlock,
            "voting must end after it begins"
        );

        return
            _createElection(
                msg.sender,
                _title,
                _beginRegistrationAtBlock,
                _endRegistrationAtBlock,
                _beginVotingAtBlock,
                _endVotingAtBlock
            );
    }

    // Private Functions
    // -------------------------------------------------------------------------

    function _createElection(
        address _owner,
        string memory _title,
        uint256 _beginRegistrationAtBlock,
        uint256 _endRegistrationAtBlock,
        uint256 _beginVotingAtBlock,
        uint256 _endVotingAtBlock
    ) internal returns (uint256) {
        uint256 electionId = _nextElectionId();
        ownerElectionIds[_owner].push(electionId);
        elections[electionId] = Election(
            _title,
            _beginRegistrationAtBlock,
            _endRegistrationAtBlock,
            _beginVotingAtBlock,
            _endVotingAtBlock
        );
        return electionId;
    }

    function _nextElectionId() internal returns (uint256) {
        return electionIdCounter++;
    }
}
