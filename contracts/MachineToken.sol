pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/BasicToken.sol";


/**
 * @dev An example token which can be used as a token in Machine
 */


contract MachineToken is BasicToken {

  string private constant NAME = "Machine Token";
  string private constant SYMBOL = "MCT";
  uint256 private constant DECIMAL = 18;
  uint256 private constant TOTAL_SUPPLY = 10 ** (DECIMAL + 10);

  function MachineToken() public {
    totalSupply_ = TOTAL_SUPPLY;
    balances[msg.sender] = TOTAL_SUPPLY;
  }
}
