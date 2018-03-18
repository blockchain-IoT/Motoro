var MachineOwner = artifacts.require("./MachineOwner.sol");
var StakeObjects = artifacts.require("./StakeObjects.sol");

module.exports = function(deployer) {
  deployer.deploy(MachineOwner);
  deployer.deploy(StakeObjects);
};
