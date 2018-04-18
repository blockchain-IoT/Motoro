pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
import "zeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Machine is Ownable {
  using SafeERC20 for ERC20Basic;

  address public pendingRenter;
  address public renter;
  string public model;
  string public make;
  bytes32 public id;
  uint256 public rentalPrice;
  uint256 public rentalCount;
  ERC20Basic public token;

  event MachineRental(address indexed _machine, address indexed _owner, address indexed _renter, uint256 startTime, uint256 endTime, uint256 _rentalPrice);
  event RentalClaimed(address indexed _machine, address indexed _renter, uint256 claimedTime);
  event MachineReturned(address indexed _machine, address indexed _renter, uint256 returnTime);
  event ReturnConfirmed(address indexed _machine, address indexed _owner, uint256 claimedTime);

  /**
   * @dev The MachineRepresentation constructor sets the original `owner` of the contract to the sender
   * account. It also sets the model, make and id of the machine.
   */
  function Machine(ERC20Basic _token, string _model, string _make, bytes32 _id) public
  {
    token = _token;
    model = _model;
    make = _make;
    id = _validateId(_id);
    rentalCount = 0;
  }

  /**
   * @dev Throws if called by any account other than the renter.
   */
  modifier onlyRenter() {
    require(msg.sender == renter);
    _;
  }

  /**
   * @dev Throws if called by any account other than the pending renter (temporary role).
   */
  modifier onlyPendingRenter() {
    require(msg.sender == pendingRenter);
    _;
  }

  /**
   * @dev Allows the owner to rent out the machine to the renter, and specify the start and end time
   * and also the price for the rental
   */
  function rentMachine(address _pendingRenter, uint256 _startTime, uint256 _endTime, uint256 _price) public onlyOwner {
    require(_pendingRenter != address(0));
    require(now <= _startTime && now <= _endTime && _startTime <= _endTime);
    rentalPrice = _price;
    pendingRenter = _pendingRenter;
    MachineRental(this, owner, _pendingRenter, _startTime, _endTime, _price);
  }

  /**
   * @dev Allows the pendingRenter address to finalize the transfer and provide a token contract, with the cash to hold
   */
  function claimRental() onlyPendingRenter public {
    require(rentalPrice <= token.balanceOf(pendingRenter));
    renter = pendingRenter;
    pendingRenter = address(0);
    RentalClaimed(this, renter, now);
  }

  /**
   * @dev Allows the renter address to return the machine, and transfer the cash from the held contract, to the machine owner
   */
  function returnMachine() onlyRenter public {
    uint256 amount = token.balanceOf(this);
    require(rentalPrice <= amount);
    token.safeTransfer(owner, amount);
    MachineReturned(this, renter, now);
  }

  /**
   * @dev Allows the owner address to confirm the return of the machine
   */
  function confirmReturn() onlyOwner public {
    renter = address(0);
    rentalPrice = 0;
    rentalCount++;
    ReturnConfirmed(this, owner, now);
  }

  /**
   * @dev Can be overridden to create a validation rule for ID
   */
  function _validateId(bytes32 _id) internal pure returns(bytes32) {
    return _id;
  }
}
