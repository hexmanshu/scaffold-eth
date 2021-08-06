pragma solidity >=0.6.0 <0.7.0;

import "hardhat/console.sol";
//import "./ExampleExternalContract.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Staker {

  //ExampleExternalContract public exampleExternalContract;

  /* constructor(address exampleExternalContractAddress) public {
    exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  } */

  mapping ( address => uint256 ) public balances;
  uint256 public constant threshold = 0.1 ether;
  bool public isActive = false;
  uint public deadline = now + 30 seconds;

  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  //  ( make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
  event Stake(address, uint256);

  receive() external payable { stake(); }

  function stake() public payable {
    balances[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);

    if ( now >= deadline && address(this).balance >= threshold ) {
      isActive = true;
    }

  }


  // After some `deadline` allow anyone to call an `execute()` function
  //  It should either call `exampleExternalContract.complete{value: address(this).balance}()` to send all the value
  function execute() public {
    require(isActive == true);
    //exampleExternalContract.complete{value: address(this).balance}();
  }



  // if the `threshold` was not met, allow everyone to call a `withdraw()` function
  function withdraw(address payable) public {
    require(now > deadline, "deadline hasn't passed");
    require(isActive == false, "Contract is active");
    require(balances[msg.sender] > 0, "You have not deposited");
    uint256 withdraw_balance = balances[msg.sender];
    balances[msg.sender] = 0;
    msg.sender.transfer(withdraw_balance);

  }


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  function timeLeft() public view returns(uint256) {
    if (now >= deadline) {
      return 0;
    }
    else
    {
      return deadline - now;
    }
    
  }

}
