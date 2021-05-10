const Voting = artifacts.require("Voting");

const assertReverted = (fn, errMessage) =>
  fn.then(
    () => assert.fail(`expected call to fail with message: ${errMessage}`),
    (e) => assert.equal(e.message.includes(errMessage), true, e.message)
  );

contract("Voting", async (accounts) => {
  // helpers
  admin = accounts[0];
  bobby = accounts[1];
  carlos = accounts[2];
  susie = accounts[3];
  voter1 = accounts[4];
  voter2 = accounts[5];
  voter3 = accounts[6];

  // create election
  // ---------------------------------------------------------------------------

  it("should require a non-empty title", async () => {
    const v = await Voting.deployed();

    await assertReverted(
      v.createElection("", 0, 0, 0, 0, { from: admin }),
      "title must be non-empty"
    );
  });

  it("should validate registration and voting times", async () => {
    const v = await Voting.deployed();

    await assertReverted(
      v.createElection("Test", Math.floor(Date.now() / 1000) - 1, 0, 0, 0, {
        from: admin,
      }),
      "registration must begin in the future"
    );

    const now = Math.floor(Date.now() / 1000) + 1;

    await assertReverted(
      v.createElection("Test", now + 1, 0, 0, 0, { from: admin }),
      "registration must end after it begins"
    );
    await assertReverted(
      v.createElection("Test", now + 1, now + 2, 0, 0, { from: admin }),
      "voting must begin after registration ends"
    );
    await assertReverted(
      v.createElection("Test", now + 1, now + 2, now + 3, 0, { from: admin }),
      "voting must end after it begins"
    );
  });

  it("should successfully create elections", async () => {
    const v = await Voting.deployed();
    const now = Math.floor(Date.now() / 1000) + 1;

    const len = await v.getAllElectionsLength();

    await v.createElection("Test", now + 1, now + 2, now + 3, now + 4, {
      from: admin,
    });

    assert.equal((await v.getAllElectionsLength()).gt(len), true);
  });

  // register candidates
  // ---------------------------------------------------------------------------

  // it("rejects unknown elections", async () => {
  //   const v = await Voting.deployed();

  //   await assertReverted(
  //     v.createElection("", 0, 0, 0, 0, { from: admin }),
  //     "title must be non-empty"
  //   );
  // });
});
