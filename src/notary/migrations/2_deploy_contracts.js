var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var IdentifyMachine = artifacts.require("./IdentifyMachine.sol");
var Machine = artifacts.require("./Machine.sol");
var MachineOwner = artifacts.require("./MachineOwner.sol");
var StakeObjects = artifacts.require("./StakeObjects.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(IdentifyMachine);
  deployer.deploy(Machine);
  deployer.deploy(MachineOwner);
  deployer.deploy(StakeObjects);
};
