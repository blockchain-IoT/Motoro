/* eslint-disable */
const Web3 = require('web3')
const fs = require('fs')
const solc = require('solc')

const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))
console.log(web3.eth.accounts)
console.log(__dirname);
const code = fs.readFileSync(__dirname + '/contracts/IdentifyMachine.sol').toString()
const compiledCode = solc.compile(code)

console.log(compiledCode)

const abiDefinition = JSON.parse(compiledCode.contracts[':IdentifyMachine'].interface)
const IdentifyMachineContract = web3.eth.contract(abiDefinition)
const byteCode = compiledCode.contracts[':IdentifyMachine'].bytecode
const names = ['KTM','Husaberg','Honda']
const contractConfig = { data: byteCode, from: web3.eth.accounts[0], gas: 4700000 }
const contractCallback = (err, deployedContract) => {
    if (err) throw err
    if(!deployedContract.address) {
        console.log('The hash of the transaction, which deploys the contract:')
        console.log(deployedContract.transactionHash)
    // check address on the second call (contract deployed)
    } else {
        console.log('the contract address:')
        console.log(deployedContract.address) // the contract address
        const contractInstance = IdentifyMachineContract.at(deployedContract.address)
        contractInstance.totalIgnitionsFor.call('Husaberg')
        // { [String: '0'] s: 1, e: 0, c: [ 0 ] }
        contractInstance.igniteMachine('Husaberg', {from: web3.eth.accounts[0]})
        // '0xdedc7ae544c3dde74ab5a0b07422c5a51b5240603d31074f5b75c0ebc786bf53'
        contractInstance.igniteMachine('Husaberg', {from: web3.eth.accounts[0]})
        // '0x02c054d238038d68b65d55770fabfca592a5cf6590229ab91bbe7cd72da46de9'
        contractInstance.igniteMachine('Husaberg', {from: web3.eth.accounts[0]})
        // '0x3da069a09577514f2baaa11bc3015a16edf26aad28dffbcd126bde2e71f2b76f'
        contractInstance.totalIgnitionsFor.call('Husaberg').toLocaleString()
        // '3'

        contractInstance.addMachine('Yamaha', {from: web3.eth.accounts[0]})

        contractInstance.igniteMachine('Yamaha', {from: web3.eth.accounts[0]})

        contractInstance.totalIgnitionsFor.call('Yamaha').toLocaleString()
    }
}

// Error : 48:1  error  Parsing error: 'return' outside of function
// Original Line : return IdentifyMachineContract.new(names, contractConfig, contractCallback)
IdentifyMachineContract.new(names, contractConfig, contractCallback)
