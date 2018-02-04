pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract IdentifyMachine {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is machine name stored as type bytes32 and value is
  an unsigned integer to store the ignition count
  */
  
  mapping (bytes32 => uint8) public ignites;
  
  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of machines
  */
  
  bytes32[] public machineList;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of machines
  */
  function IdentifyMachine(bytes32[] machines) {
    machineList = machines;
  }

  function addMachine(bytes32 machine) {
    if (machineListed(machine) == true) throw;
    machineList.push(machine);
  }

  // This function returns the total ignitions a candidate has received so far
  function totalIgnitionsFor(bytes32 machine) returns (uint8) {
    if (machineListed(machine) == false) throw;
    return ignites[machine];
  }

  // This function increments the vote count for the specified machine. This
  // is turning the ignition
  function igniteMachine(bytes32 machine) {
    if (machineListed(machine) == false) throw;
    ignites[machine] += 1;
  }

  function machineListed(bytes32 machine) returns (bool) {
    for (uint i = 0; i < machineList.length; i++) {
      if (machineList[i] == machine) {
        return true;
      }
    }
    return false;
  }
}
