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
        uint256 beginRegistrationAt;
        uint256 endRegistrationAt;
        uint256 beginVotingAt;
        uint256 endVotingAt;
    }

    uint256 internal electionIdCounter = 1;
    mapping(address => uint256[]) public ownerElectionIds;
    mapping(uint256 => Election) public elections;

    mapping(uint256 => Candidate[]) public electionCandidates;
    mapping(address => uint256[]) public candidatesElections;

    // electionId => [ voterAddress => candidateAddress ]
    mapping(uint256 => mapping(address => address)) public votes;

    // Public Functions
    // -------------------------------------------------------------------------

    function createElection(
        string memory _title,
        uint256 _beginRegistrationAt,
        uint256 _endRegistrationAt,
        uint256 _beginVotingAt,
        uint256 _endVotingAt
    ) public returns (uint256) {
        require(bytes(_title).length > 0, "title must be non-empty");
        require(
            _beginRegistrationAt > block.timestamp,
            "registration must begin in the future"
        );
        require(
            _endRegistrationAt > _beginRegistrationAt,
            "registration must end after it begins"
        );
        require(
            _beginVotingAt > _endRegistrationAt,
            "voting must begin after registration ends"
        );
        require(
            _endVotingAt > _beginVotingAt,
            "voting must end after it begins"
        );

        return
            _createElection(
                msg.sender,
                _title,
                _beginRegistrationAt,
                _endRegistrationAt,
                _beginVotingAt,
                _endVotingAt
            );
    }

    function registerAsCandidate(uint256 _electionId, string memory _name)
        public
    {
        require(
            elections[_electionId].beginRegistrationAt != 0,
            "unknown _electionId"
        );
        require(
            block.timestamp > elections[_electionId].beginRegistrationAt,
            "can't register until registration opens"
        );
        require(
            block.timestamp < elections[_electionId].endRegistrationAt,
            "can't register after registration has closed"
        );

        electionCandidates[_electionId].push(Candidate(msg.sender, _name));
        candidatesElections[msg.sender].push(_electionId);
    }

    // Private Functions
    // -------------------------------------------------------------------------

    function _createElection(
        address _owner,
        string memory _title,
        uint256 _beginRegistrationAt,
        uint256 _endRegistrationAt,
        uint256 _beginVotingAt,
        uint256 _endVotingAt
    ) internal returns (uint256) {
        uint256 _electionId = _nextElectionId();
        ownerElectionIds[_owner].push(_electionId);
        elections[_electionId] = Election(
            _title,
            _beginRegistrationAt,
            _endRegistrationAt,
            _beginVotingAt,
            _endVotingAt
        );
        return _electionId;
    }

    function _nextElectionId() internal returns (uint256) {
        return electionIdCounter++;
    }
}
