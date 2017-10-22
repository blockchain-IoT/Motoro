web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
abi = JSON.parse('[{"constant":true,"inputs":[{"name":"","type":"bytes32"}],"name":"ignites","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"machineList","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"machine","type":"bytes32"}],"name":"totalIgnitionsFor","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"machine","type":"bytes32"}],"name":"addMachine","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"machine","type":"bytes32"}],"name":"igniteMachine","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"machine","type":"bytes32"}],"name":"machineListed","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"machines","type":"bytes32[]"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]')
IdentifyMachine = web3.eth.contract(abi);
// In your nodejs console, execute contractInstance.address to get the address at which the contract is deployed and change the line below to use your deployed address
contractInstance = IdentifyMachine.at('0xd5376788de32500f2ca9ae5e1d4e9d527844eea0');
machines = {"KTM": "machine-1", "Husaberg": "machine-2", "Honda": "machine-3", "Yamaha": "machine-4"}

function igniteMachine() {
  machine = $("#machine").val();
  contractInstance.igniteMachine(machine, {from: web3.eth.accounts[0]}, function() {
    let div_id = machines[machine];
    $("#" + div_id).html(contractInstance.totalIgnitionsFor.call(machine).toString());
  });
}

$(document).ready(function() {
  machineNames = Object.keys(machines);
  for (var i = 0; i < machineNames.length; i++) {
    let name = machineNames[i];
    let val = contractInstance.totalIgnitionsFor.call(name).toString()
    $("#" + machines[name]).html(val);
  }
});
