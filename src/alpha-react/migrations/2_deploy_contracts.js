var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var IdentifyMachine = artifacts.require("./IdentifyMachine.sol");
var Machine = artifacts.require("./Machine.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(IdentifyMachine);
  deployer.deploy(Machine);
};
