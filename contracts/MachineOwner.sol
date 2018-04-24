pragma solidity ^0.4.18;

import "./Machine.sol";


contract MachineOwner is Ownable {

  mapping(bytes32 => address) public machines;

  event NewMachineAdded(address indexed newMachine, uint256 timestamp);

  function createNewMachine(ERC20Basic _token, string _model, string _make, bytes32 _id) public onlyOwner {
    Machine newMachine = new Machine(_token, _model, _make, _id);
    newMachine.transferOwnership(owner); // the contract should not be a owner of a new machine
    machines[_id] = newMachine;
    NewMachineAdded(newMachine, now);
  }
}