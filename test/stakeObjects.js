var StakeObjects = artifacts.require("./StakeObjects.sol");

contract('StakeObjects', function(accounts) {

  it("...should work.", function() {
    return StakeObjects.deployed().then(function(instance) {
      soi = instance;
      events = soi.allEvents();
      events.watch(function(error, result) {
        if(error) {
          return console.log("Error");
        }
        else {
          console.log(result.event + ": ");
          for(key in result.args) {
            console.log("- " + key + ": " + result.args[key]);
          }
        }
      });
      return soi.createAsset(accounts[0], 200, { from: accounts[0] });
    })
      // the function below will 
      .then(() => soi.buyStakes(accounts[0], accounts[1], { from: accounts[1], value: web3.toWei(6, 'wei')}))
      // 
      .then(() => soi.buyStakes(accounts[0], accounts[1], { from: accounts[1], value: web3.toWei(6, 'ether')}))
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[1], { from: accounts[0] }))
      .then(result => assert.equal(result, 30000, 'wrong value'))
      .then(() => soi.sellStakes(accounts[0], accounts[2], 3000, 2000000000000000000, { from: accounts[1] }))
      .then(() => soi.buyOfferedStakes(accounts[0], accounts[1], { from: accounts[2], value: web3.toWei(2, 'ether') }))
    // }).then(function(storedData) {
      // assert.equal(storedData, 89, "The value 89 was not stored.");
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[1], { from: accounts[0] }))
      .then(result => assert.equal(result, 27000, 'wrong value'))
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[2], { from: accounts[0] }))
      .then(result => assert.equal(result, 3000, 'wrong value'))
      .then(() => soi.sellStakes(accounts[0], accounts[3], 300, 10000000000000000000, { from: accounts[2] }))
      // new account, not enough ether
      .then(() => soi.buyOfferedStakes(accounts[0], accounts[2], { from: accounts[3], value: web3.toWei(1, 'ether') }))
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[2], { from: accounts[0] }))
      .then(result => assert.equal(result, 2700, 'wrong value'))
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[3], { from: accounts[0] }))
      .then(result => assert.equal(result, 0, 'wrong value'))
      // the right amount of ether and a 10% tip
      .then(() => soi.buyOfferedStakes(accounts[0], accounts[2], { from: accounts[3], value: web3.toWei(11, 'ether') }))
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[2], { from: accounts[0] }))
      .then(result => assert.equal(result, 2700, 'wrong value'))
      .then(() => soi.checkFunderAccount.call(accounts[0], accounts[3], { from: accounts[0] }))
      .then(result => assert.equal(result, 300, 'wrong value'))
      .then(() => setTimeout(() => { events.stopWatching() }, 2000));
  });
});
