# voting-dapp

**Using Truffle and Create Eth App**

Create a dapp for voting where all of the votes and candidate registration happens on chain. Allow anyone to start an election with a registration period, voting period, and ending time. Allow anyone to sign up as a candidate during the registration period, and allow anyone to vote once during the voting period. Create a front end where voters can see the results and know how long is left in the election.

## testing snippets

    $ v = await Voting.deployed();
    $ admin = accounts[0]; bobby = accounts[1]; carlos = accounts[2]; susie = accounts[3]; voter1 = accounts[4]; voter2 = accounts[5]; voter3 = accounts[6];

    $ v.createElection("Test", Math.floor(Date.now() / 1000) + 1, Math.floor(Date.now() / 1000) + 60, Math.floor(Date.now() / 1000) + 61, Math.floor(Date.now() / 1000) + 60*2, { from: admin });

    $ v.registerAsCandidate(1, "Bobby Wantsavote", { from: bobby });
    $ v.registerAsCandidate(1, "Corporate Carlos", { from: carlos });

    // verify

    $ v.electionCandidatesList(1, 0)
    Result {
      '0': '0xDE4DFAA2798D31b7884e22762EE7EAeE5d8C46b8',
      '1': 'Bobby Wantsavote',
      owner: '0xDE4DFAA2798D31b7884e22762EE7EAeE5d8C46b8',
      name: 'Bobby Wantsavote'
    }
    $ v.electionCandidatesList(1, 1)
    Result {
      '0': '0x573f1691DC5a8e39e7417a2AC57fF42aB6a3F7f3',
      '1': 'Corporate Carlos',
      owner: '0x573f1691DC5a8e39e7417a2AC57fF42aB6a3F7f3',
      name: 'Corporate Carlos'
    }

    // wait 1 min

    $ v.registerAsCandidate(1, "Tardy Susie", { from: susie }); // error  reason: "can't register after registration has closed",

    $ v.vote(1, bobby, { from: voter1 });
    $ v.vote(1, bobby, { from: voter2 });
    $ v.vote(1, carlos, { from: voter3 });

    // wait 1 min

    $ v.getWinner(1, { from: admin })
