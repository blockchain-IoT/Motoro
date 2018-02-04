import React, { Component } from 'react'
import SimpleStorageContract from '../build/contracts/SimpleStorage.json'
import IdentifyMachineContract from '../build/contracts/IdentifyMachine.json'
import MachineContract from '../build/contracts/Machine.json'
import getWeb3 from './utils/getWeb3'

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      storageValue: 0,
      yamaha: 0,
      web3: null
    }
  }

  componentWillMount() {
    // Get network provider and web3 instance.
    // See utils/getWeb3 for more info.

    getWeb3
    .then(results => {
      this.setState({
        web3: results.web3
      })

      // Instantiate contract once web3 provided.
      this.instantiateContract()
    })
    .catch(() => {
      console.log('Error finding web3.')
    })
  }

  instantiateContract() {
    /*
     * SMART CONTRACT EXAMPLE
     *
     * Normally these functions would be called in the context of a
     * state management library, but for convenience I've placed them here.
     */

    const contract = require('truffle-contract')
    const simpleStorage = contract(SimpleStorageContract)
    const identifyMachine = contract(IdentifyMachineContract)
    const machine = contract(MachineContract)
    simpleStorage.setProvider(this.state.web3.currentProvider)
    identifyMachine.setProvider(this.state.web3.currentProvider)

    // Declaring this for later so we can chain functions on SimpleStorage.
    var simpleStorageInstance
    var identifyMachineInstance
    var machineInstance
    
    // Get accounts.
    this.state.web3.eth.getAccounts((error, accounts) => {
      simpleStorage.deployed().then((instance) => {
        simpleStorageInstance = instance

        // Stores a given value, 5 by default.
        return simpleStorageInstance.set(5, {from: accounts[0]})
      }).then((result) => {
        // Get the value from the contract to prove it worked.
        return simpleStorageInstance.get.call(accounts[0])
      }).then((result) => {
        // Update state with the result.
        return this.setState({ storageValue: result.c[0] })
      })
      machineInstance.deployed();
      identifyMachine.deployed().then((instance) => {
        identifyMachineInstance = instance
        return identifyMachineInstance.addMachine('Yamaha', {from: accounts[0]})})
          .catch(err => console.log(err))
          .then(() => identifyMachineInstance.igniteMachine('Yamaha', { from: accounts[0] }))
          .then(result => identifyMachineInstance.totalIgnitionsFor.call('Yamaha'))
          .then(result => this.setState({ yamaha: result.c[0]}))
          .catch(err => console.log(err))
    })
  }

  render() {
    return (
      <div className="App">
        <nav className="navbar pure-menu pure-menu-horizontal">
            <a href="#" className="pure-menu-heading pure-menu-link">Truffle Box</a>
        </nav>

        <main className="container">
          <div className="pure-g">
            <div className="pure-u-1-1">
              <h1>Good to Go!</h1>
              <p>Your Truffle Box is installed and ready.</p>
              <h2>Smart Contract Example</h2>
              <p>If your contracts compiled and migrated successfully, below will show a stored value of 5 (by default).</p>
              <p>Try changing the value stored on <strong>line 59</strong> of App.js.</p>
              <p>The stored value is: {this.state.storageValue}</p>
              <p>Yamaha: {this.state.yamaha}</p>
            </div>
          </div>
        </main>
      </div>
    );
  }
}

export default App
