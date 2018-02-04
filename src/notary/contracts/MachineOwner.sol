pragma solidity ^0.4.18;

import './Machine.sol';

contract MachineOwner {
  address public owner;
  mapping(bytes32 => address) public machines;

  event NewMachineAdded(address indexed newMachine, uint256 timestamp);

  function MachineOwner() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function createNewMachine(string model, string make, bytes32 vin) public onlyOwner {
    address newMachine = new Machine(model, make, vin);
    machines[vin] = newMachine;
    NewMachineAdded(newMachine, now);
  }
}
