pragma solidity ^0.4.18;
import "../node_modules/zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
import "../node_modules/zeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol";


contract StakeObjects {
    using SafeERC20 for ERC20Basic;
    using SafeMath for uint256;
    
    struct Funder {
        address funder;
        bool isValue;
        uint256 cost;
        uint256 stakesTotal;
        mapping (address => Funder) buyers;
    }
    
    struct Asset {
        address beneficiary;
        bool isValue;
        uint256 price;
        uint256 stakesCount;
        uint256 stakesLeft;
        uint256 stakePrice;
        mapping (address => Funder) funders;
    }
    
    uint256 public decimal;
    mapping(address => Asset) public assets;

    event CreateAssetEvent(address owner, uint256 price, uint256 decimal, uint256 stakePrice);
    event BuyStakesEvent(address funder, uint256 cost, uint256 stakesTotal);
    event CheckFunderAccountEvent(address asset, address funder, uint256 stakes);
    event SellStakesEvent();

    function StakeObjects() public {
        decimal = 10**18;
    }

    function createAsset(address owner, uint256 price) public {
        if (!assets[owner].isValue) {
            assets[owner] = Asset({
                beneficiary: owner,
                isValue: true,
                price: price,
                stakesCount: 1000000,
                stakesLeft: 1000000,
                stakePrice: price.mul(decimal).div(1000000)
            });
            CreateAssetEvent(owner, price, decimal, assets[owner].stakePrice);
        }
    }

    function buyStakes(address asset, address funder) public payable {
        // check if there is enough stakes
        uint256 balance = msg.value;
        uint256 stakes = balance.mul(decimal).div(assets[asset].stakePrice);
        require(assets[asset].stakesLeft >= stakes);

        BuyStakesEvent(funder, balance, stakes);
        // check if funder already listed
        if (!assets[asset].funders[funder].isValue) {
            assets[asset].funders[funder] = Funder(funder, true, 0, 0);
        }

        Asset storage assetAccount = assets[asset];
        Funder storage fundersAccount = assets[asset].funders[funder];
        assetAccount.stakesLeft -= stakes;
        fundersAccount.stakesTotal += stakes;
        fundersAccount.cost += balance;

        // send money to beneficiary
        // token.safeTransfer(assetAccount.beneficiary, balance);
        assetAccount.beneficiary.transfer(balance);
    }

    function checkFunderAccount(address asset, address funder) public constant returns(uint256) {
        Funder storage funderAccount = assets[asset].funders[funder];
        return funderAccount.stakesTotal;
        // CheckFunderAccountEvent(asset, funder, funderAccount.stakesTotal);
    }

    modifier onlyFunder(address assetAddress) {
        require(msg.sender == assets[assetAddress].funders[msg.sender].funder);
        _;
    }

    function sellStakes(address assetAddress, address buyer, uint256 stakeAmount, uint256 price) 
    public onlyFunder(assetAddress) {
        Funder storage funderAccount = assets[assetAddress].funders[msg.sender];
        require(funderAccount.stakesTotal >= stakeAmount);
        if (!funderAccount.buyers[buyer].isValue) {
            funderAccount.buyers[buyer] = Funder(buyer, true, price, 0);
        }
        funderAccount.stakesTotal -= stakeAmount;
        funderAccount.buyers[buyer].stakesTotal += stakeAmount;
        SellStakesEvent();
    }

    modifier onlyNewFunder(address assetAddress, address funderAddress) {
        require(msg.sender == assets[assetAddress].funders[funderAddress].buyers[msg.sender].funder);
        _;
    }

    function buyOfferedStakes(address assetAddress, address funderAddress)
    public onlyNewFunder(assetAddress, funderAddress) payable {
        // uint256 balance = token.balanceOf(this);
        uint256 balance = msg.value;
        Funder storage buyerAccount = assets[assetAddress].funders[funderAddress].buyers[msg.sender];
        require(balance >= buyerAccount.cost);
        if (!assets[assetAddress].funders[msg.sender].isValue) {
            assets[assetAddress].funders[msg.sender] = Funder(msg.sender, true, buyerAccount.cost, 0);
        }
        Funder storage newFunderAccount = assets[assetAddress].funders[msg.sender];
        uint stakes = buyerAccount.stakesTotal;
        buyerAccount.stakesTotal = 0;
        newFunderAccount.stakesTotal += stakes;
        // token.safeTransfer(funderAddress, balance);
        funderAddress.transfer(balance);
    }
}
