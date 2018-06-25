pragma solidity 0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "zeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";


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

  using SafeERC20 for ERC20;
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

  event MachineRental(address indexed _machine, address indexed _owner, address indexed _renter, uint256 startTime, uint256 _rentalPrice);
  event RentalClaimed(address indexed _machine, address indexed _renter, uint256 claimedTime);
  event RentalCancelled(address indexed _machine, address indexed _owner, uint256 cancelledTime);
  event MachineReturned(address indexed _machine, address indexed _renter, uint256 returnTime);
  event ReturnConfirmed(address indexed _machine, address indexed _owner, uint256 claimedTime);

  /**
   * @dev The MachineRepresentation constructor sets the original `owner` of the contract to the sender
   * account. It also sets the model, make and id of the machine.
   */
  constructor(ERC20 _token, string _model, string _make, bytes32 _id) public
  {
    token = _token;
    model = _model;
    make = _make;
    id = _validateId(_id);
    rentalCount = 0;
    stage = Stage.free;
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
  function rentMachine(address _pendingRenter, uint256 _price) public onlyOwner atStage(Stage.free)  {
    require(_pendingRenter != address(0));
    rentalPrice = _price;
    pendingRenter = _pendingRenter;
    stage = Stage.pendingRenter;
    
    emit MachineRental(this, owner, _pendingRenter, now, _price);
  }

  /**
   * @dev Allows the pendingRenter address to finalize the transfer and provide a token contract, with the cash to hold
   */
  function claimRental() public onlyPendingRenter atStage(Stage.pendingRenter) {
    renter = pendingRenter;
    pendingRenter = address(0);
    stage = Stage.rented;
    
    emit RentalClaimed(this, renter, now);
    
    token.safeTransferFrom(msg.sender, address(this), rentalPrice);
  }
  
  function cancelRental() public onlyOwner atStage(Stage.pendingRenter) {
    pendingRenter = address(0);
    rentalPrice = 0;
    stage = Stage.free;
    
    emit RentalCancelled(this, owner, now); 
  }

  /**
   * @dev Allows the renter address to return the machine, and transfer the cash from the held contract, to the machine owner
   */
  function returnMachine() public onlyRenter atStage(Stage.rented) {
    stage = Stage.pendingReturn;
    
    emit MachineReturned(this, renter, now);
  }

  /**
   * @dev Allows the owner address to confirm the return of the machine
   */
  function confirmReturn() public onlyOwner atStage(Stage.pendingReturn)  {
    stage = Stage.free;
    renter = address(0);
    rentalPrice = 0;
    rentalCount = rentalCount.add(1);
    
    emit ReturnConfirmed(this, owner, now);
  }
  
  function withdraw() public onlyOwner atStage(Stage.free) {
      uint256 _balance = token.balanceOf(address(this));
      
      token.safeTransfer(owner, _balance);
  }

  /**
   * @dev Can be overridden to create a validation rule for ID
   */
  function _validateId(bytes32 _id) internal pure returns(bytes32) {
    return _id;
  }
}
