pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "zeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./Vault.sol";


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Machine is Ownable {
  enum Stage {
    free,
    pendingRenter,
    rented,
    pendingReturn
  }

  using SafeMath for uint256;

  address public pendingRenter;
  address public renter;
  string public model;
  string public make;
  bytes32 public id;
  uint256 public rentalPrice;
  uint256 public rentalCount;
  ERC20 public token;
  Stage public stage;
  Vault public vault;

  event MachineRental(address indexed _machine, address indexed _owner, address indexed _renter, uint256 startTime, uint256 endTime, uint256 _rentalPrice);
  event RentalClaimed(address indexed _machine, address indexed _renter, uint256 claimedTime);
  event MachineReturned(address indexed _machine, address indexed _renter, uint256 returnTime);
  event ReturnConfirmed(address indexed _machine, address indexed _owner, uint256 claimedTime);

  /**
   * @dev The MachineRepresentation constructor sets the original `owner` of the contract to the sender
   * account. It also sets the model, make and id of the machine.
   */
  function Machine(ERC20 _token, string _model, string _make, bytes32 _id) public
  {
    token = _token;
    model = _model;
    make = _make;
    id = _validateId(_id);
    rentalCount = 0;
    stage = Stage.free;
    vault = new Vault(_token);
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

  modifier atStage(Stage _stage) {
    require(stage == _stage);
    _;
  }

  /**
   * @dev Allows the owner to rent out the machine to the renter, and specify the start and end time
   * and also the price for the rental
   */
  function rentMachine(address _pendingRenter, uint256 _startTime, uint256 _endTime, uint256 _price) public onlyOwner atStage(Stage.free) {
    require(_pendingRenter != address(0));
    require(now <= _startTime && now <= _endTime && _startTime <= _endTime);
    rentalPrice = _price;
    pendingRenter = _pendingRenter;
    stage = Stage.pendingRenter;
    MachineRental(this, owner, _pendingRenter, _startTime, _endTime, _price);
  }

  /**
   * @dev Allows the pendingRenter address to finalize the transfer and provide a token contract, with the cash to hold
   */
  function claimRental() public onlyPendingRenter atStage(Stage.pendingRenter) {
    renter = pendingRenter;
    pendingRenter = address(0);
    stage = Stage.rented;
    RentalClaimed(this, renter, now);

    vault.deposit(rentalPrice, renter);
  }

  /**
   * @dev Allows the renter address to return the machine, and transfer the cash from the held contract,
   * to the machine owner
   */
  function returnMachine() public onlyRenter atStage(Stage.rented) {
    stage = Stage.pendingReturn;
    MachineReturned(this, renter, now);
  }

  /**
   * @dev Allows the owner address to confirm the return of the machine
   */
  function confirmReturn() public onlyOwner atStage(Stage.pendingReturn) {
    stage = Stage.free;
    renter = address(0);
    rentalPrice = 0;
    rentalCount = rentalCount.add(1);
    ReturnConfirmed(this, owner, now);

    vault.withdraw();
  }

  /**
   * @dev Can be overridden to create a validation rule for ID
   */
  function _validateId(bytes32 _id) internal pure returns(bytes32) {
    return _id;
  }
}
