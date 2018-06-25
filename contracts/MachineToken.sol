pragma solidity 0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";


/**
 * @dev An example token which can be used as a token in Machine
 */


contract MachineToken is StandardToken {

  string private constant NAME = "Machine Token";
  string private constant SYMBOL = "MCT";
  uint256 private constant DECIMAL = 18;
  uint256 private constant TOTAL_SUPPLY = 10 ** (DECIMAL + 10);

  constructor() public {
    totalSupply_ = TOTAL_SUPPLY;
    balances[msg.sender] = TOTAL_SUPPLY;
  }
}
