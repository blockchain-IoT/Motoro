pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "zeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";


/**
 * @title Vault
 * @dev Uses to store tokens which should be paid after a machine is returned
 */
contract Vault is Ownable {

  enum Stage {
    closed,
    opened
  }

  using SafeERC20 for ERC20;

  ERC20 internal token;
  Stage internal currentStage;
  uint256 internal currentDeposit;


  modifier atStage(Stage _stage) {
    require(currentStage == _stage);
    _;
  }

  function Vault(ERC20 _token) public {
    currentStage = Stage.closed;
    token = _token;
  }

  function deposit(uint256 _value, address _sender) public onlyOwner atStage(Stage.closed) {
    require(_value > 0);
    require(_sender != address(0));
    currentStage = Stage.opened;
    currentDeposit = _value;

    token.safeTransferFrom(_sender, address(this), _value);
  }

  function withdraw() public onlyOwner atStage(Stage.opened) {
    currentStage = Stage.closed;
    uint256 _valueToTransfer = currentDeposit;
    currentDeposit = 0;

    token.safeTransfer(owner, _valueToTransfer);
  }
}