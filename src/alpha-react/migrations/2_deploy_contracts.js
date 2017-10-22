var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var IdentifyMachine = artifacts.require("./IdentifyMachine.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(IdentifyMachine);
};
