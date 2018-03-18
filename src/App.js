import React, { Component } from 'react'
import MachineOwnerContract from '../build/contracts/MachineOwner.json'
import getWeb3 from './utils/getWeb3'

import './App.css'
import "../node_modules/uikit/dist/css/uikit.min.css"

import RegisterOwnerForm from './components/form/RegisterOwnerForm'
import RegisterMachineForm from './components/form/RegisterMachineForm'
import MachineList from './components/MachineList'

const contract = require('truffle-contract');


class App extends Component {
    constructor(props) {
        super(props);

        this.state = {
            web3: null,
            forms: {
                registerOwner: {
                    _disabled: false,
                },
                registerMachine: {
                    _disabled: true,
                    model: 'a',
                    make: 'a',
                    vin: 'a'
                },
            },
            contracts: {
                machineOwner: {
                    address: null,
                    machines: []
                }
            }
        };
    }

    componentWillMount() {
        // Get network provider and web3 instance.
        // See utils/getWeb3 for more info.

        getWeb3
            .then(results => {
                this.setState({ web3: results.web3 })
            })
            .catch(() => {
                console.log('Error finding web3.')
            })
    }

    instantiateMachineOwnerContract() {
        const MachineOwner = contract(MachineOwnerContract);
        MachineOwner.setProvider(this.state.web3.currentProvider);

        this.state.web3.eth.getAccounts((error, accounts) => {
            MachineOwner.new({ from: accounts[0], gas: 2000000 })
                .then(instance => {
                    const state = { ...this.state };
                    state.contracts.machineOwner.address = instance.address;
                    state.forms.registerMachine._disabled = false;
                    this.setState(state);
                })
        })
    }

    callCreateMachine() {
        const MachineOwner = contract(MachineOwnerContract);
        MachineOwner.setProvider(this.state.web3.currentProvider);

        const address = this.state.contracts.machineOwner.address;
        let _, model, make, vin;
        ({ _, model, make, vin } = this.state.forms.registerMachine);

        this.state.web3.eth.getAccounts((error, accounts) => {
            MachineOwner.at(address).then((instance) => {
                instance.createNewMachine(model, make, vin, { from: accounts[0] })
                    .then((result) => {
                        const state = { ...this.state };
                        const machine = {
                            model: model,
                            make: make,
                            vin: vin,
                            address: result.logs[0].args.newMachine
                        };
                        state.contracts.machineOwner.machines.push(machine);
                        this.setState(state);
                    });
            })
        })
    };

    machineFormChangedHandler = (e) => {
        const name = e.target.name;
        const value = e.target.value;

        // Update form
        const form = { ...this.state.forms.registerMachine };
        form[name] = value;

        // Validate form input
        const { _disabled, model, make, vin } = form;
        const isValid = make !== '' && model !== '' && vin !== '';
        form._disabled = !isValid;

        // Update state
        const state = { ...this.state };
        state.forms.registerMachine = form;
        this.setState(state);
    };

    machineFormSubmittedHandler = (e) => {
        e.preventDefault();
        if (!this.state.forms.registerMachine._disabled) {
            this.callCreateMachine()
        }
    };

    ownerFormSubmittedHandler = (e) => {
        e.preventDefault();
        if (!this.state.forms.registerOwner._disabled) {
            this.instantiateMachineOwnerContract()
        }
    };

    render() {
        return (
            <div className="App">
                <div className="uk-container uk-container-center uk-margin-top uk-margin-large-bottom">
                    <div className="uk-grid-match" data-uk-grid-margin>
                        <RegisterOwnerForm
                            onSubmit={(e) => this.ownerFormSubmittedHandler(e)}
                            state={this.state.forms.registerOwner}
                        />
                        <RegisterMachineForm
                            onChange={(e) => this.machineFormChangedHandler(e)}
                            onSubmit={(e) => this.machineFormSubmittedHandler(e)}
                            state={this.state.forms.registerMachine}
                        />
                        <MachineList machines={this.state.contracts.machineOwner.machines} />
                    </div>
                </div>
            </div>
        );
    }
}

export default App;
