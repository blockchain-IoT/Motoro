pragma solidity ^0.4.18;
import "../node_modules/zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
import "../node_modules/zeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Machine {
  using SafeERC20 for ERC20Basic;

  address public owner;
  address public pendingRenter;
  address public renter;
  string public model;
  string public make;
  bytes32 public vin;
  uint256 public rentalPrice;
  uint256 public rentalCount;
    // ERC20 basic token contract being held
  ERC20Basic public token;

  event MachineRental(address indexed _machine, address indexed _owner, address indexed _renter, uint256 startTime, uint256 endTime, uint256 _rentalPrice);
  event RentalClaimed(address indexed _machine, address indexed _renter, uint256 claimedTime);
  event MachineReturned(address indexed _machine, address indexed _renter, uint256 returnTime);
  event ReturnConfirmed(address indexed _machine, address indexed _owner, uint256 claimedTime);

  /**
   * @dev The MachineRepresentation constructor sets the original `owner` of the contract to the sender
   * account. It also sets the model, make and VIN of the machine.
   */
  function Machine(string _model, string _make, bytes32 _vin) public {
    owner = msg.sender;
    model = _model;
    make = _make;
    vin = _vin;
    rentalCount = 0;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
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
  function rentMachine(address _pendingRenter, uint256 startTime, uint256 endTime, uint256 price) public onlyOwner {
    require(_pendingRenter != address(0));
    rentalPrice = price;
    MachineRental(this, owner, _pendingRenter, startTime, endTime, price);
    pendingRenter = _pendingRenter;
  }

  /**
   * @dev Allows the pendingRenter address to finalize the transfer and provide a token contract, with the cash to hold
   */
  function claimRental(ERC20Basic _token) onlyPendingRenter public {
    require(rentalPrice <= _token.balanceOf(this));
    token = _token;
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
}
