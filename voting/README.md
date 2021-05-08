# voting-dapp

Create a dapp for voting where all of the votes and candidate registration happens on chain. Allow anyone to start an election with a registration period, voting period, and ending time. Allow anyone to sign up as a candidate during the registration period, and allow anyone to vote once during the voting period. Create a front end where voters can see the results and know how long is left in the election.

## testing snippets

    $ v = await Voting.deployed();
    $ v.createElection("Test", Math.floor(Date.now() / 1000) + 1, Math.floor(Date.now() / 1000) + 120, Math.floor(Date.now() / 1000) + 121, Math.floor(Date.now() / 1000) + 120*2);
    $ v.registerAsCandidate(2, "Bobby Wantsavote");

    // verify

    $ v.electionCandidates(1, 0)
    Result {
      '0': '0xDE4DFAA2798D31b7884e22762EE7EAeE5d8C46b8',
      '1': 'Bobby Wantsavote',
      owner: '0xDE4DFAA2798D31b7884e22762EE7EAeE5d8C46b8',
      name: 'Bobby Wantsavote'
    }

    // wait 2 mins

    $ v.registerAsCandidate(2, "Tardy Susie"); // error  reason: "can't register after registration has closed",

    v.elections();
