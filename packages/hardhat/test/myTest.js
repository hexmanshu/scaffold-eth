const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("My Dapp", function () {
  let myContract;

  describe("Staker", function () {
    it("Should deploy Staker", async function () {
      const Staker = await ethers.getContractFactory("Staker");

      myContract = await Staker.deploy();
    });

    /* describe("setPurpose()", function () {
      it("Should be able to set a new purpose", async function () {
        const newPurpose = "Test Purpose";

        await myContract.setPurpose(newPurpose);
        expect(await myContract.purpose()).to.equal(newPurpose);
      }); 
    });*/
  });
});
