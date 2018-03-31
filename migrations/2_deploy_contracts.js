/* eslint-disable */
const MachineOwner = artifacts.require('./MachineOwner.sol');
const StakeObjects = artifacts.require('./StakeObjects.sol');

module.exports = function (deployer) {
  deployer.deploy(MachineOwner);
  deployer.deploy(StakeObjects);
};
