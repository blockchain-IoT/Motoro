<img src="https://secure.meetupstatic.com/photos/event/6/d/d/highres_445201757.jpeg" alt="Toptal" width="233" align="left" />
<img src="http://res.cloudinary.com/hkhuw4b7v/image/upload/v1500318899/VIKINGGARAGE-logo-1200-600.png" alt="VIKING GARAGE" width="233" align="right" />
<br clear="both" />

# blockchain IoT – core

Ethereum Smart Contracts for decentralized rentals of machines and vehicles.

## Our goal

**To research and develop a decentralized protocol for peer-to-peer rentals of motorised machines.**

We combine distributed ledger technologies – blockchain, with the machines we use for transportation and work in the physical world. 

Currently we focus on developing modular Smart Contracts for the Ethereum blockchain. The contracts are building blocks for the decentralized motorised machines and vehicle rental agreements.

The tools combined, make for a modular, End-to-End solution. 

We intend to provide mid– and high-level facilities and integrations, to help engineers and organizations to create relay businesses, which utilise the open and public Smart Contracts.

## Current state

### March 2018
- Merged in the vehicle registration procedure PR by @koscielnik
- Merged in the initial DApp UI interface for Machine Owner registration by @ocet
- Refactore the DApp's structure completely
- Updated Issue and Pull Request templates

### February 2018

Added another Smart Contract, fully tested, which can be used for selling and re-selling products and services. Blockchain IoT workshop in Campus Warsaw, Zabkowska 33C in Warsaw, Poland, on 20 February 2018 at 6.30 pm.

### January 2018 

We have prototypes of two crucial Smart Contracts, for (1) registering owners and new machines and (2) renting out motorcycles.

### November 2017

The current state of the project is that we have an initial Dapp, which includes Smart Contracts, a Node.js build script, a React front-end, and a few tests. The Smart Contract allow for new machines to signup, and assign a counter to every machine. The idea for this prototype is to increment the counter, every time the machine (motorcycle) is started – basically an ignition counter.

## Local development

The Dapp is full-stack, built using [Truffle](http://truffleframework.com/) Dapp Framework and its [React box](http://truffleframework.com/boxes/react).

### Local test blockchain

Please use the new cool tool Ganache by Truffle, which spins up a local Ethereum blockchain for development purposes. The tool has a great graphical user interface and UX. [Click here for Ganache.](https://github.com/trufflesuite/ganache)

### DAPPs 101

To understand more how Ethereum and dapps work, please read those two articles:

* https://medium.com/@mvmurthy/ethereum-for-web-developers-890be23d1d0c
* http://truffleframework.com/tutorials/ethereum-overview

#### UPDATE new tutorial series – Ethereum Development Walkthrough

* [Part 1](https://hackernoon.com/ethereum-development-walkthrough-part-1-smart-contracts-b3979e6e573e)
* [Part 2](https://hackernoon.com/ethereum-development-walkthrough-part-2-truffle-ganache-geth-and-mist-8d6320e12269)
* [Part 3](https://hackernoon.com/ethereum-development-walkthrough-part-3-security-limitations-and-considerations-d482f05278b4)

### Set up local repo

Basically just git clone the repo, and install its dependencies:

```
git clone https://github.com/blockchain-IoT/blockchain-IoT-core.git
cd blockchain-IoT-core
npm install
```

### Setting up and running local Etherum blockchain using Ganache

For development, we will use the personal Ethereum blockchain, with a really handy GUI: Ganache. Please download the app from [Ganache @ Truffle Framework](http://truffleframework.com/ganache/) and then just start it. We use port 7545 for local development.

### Install truffle

```
npm i -g truffle
```

### Compile and migrate the contracts

compile the contracts:

```
truffle compile
```

migrate them to the local Ethereum node:
```
truffle migrate
```

### Start the DApp

run the Node.js / React front-end:

```
npm start
```

and check that it all works, by accessing the frontend through [http://localhost:3000](http://localhost:3000). That page should open automatically though. 

## Contributing
Please refer to the [Contributing guidelines for this project](https://github.com/blockchain-IoT/blockchain-IoT-core/blob/master/CONTRIBUTING.md).

## Communication
Realtime communication happens on [Slack](https://blockchainiot.slack.com/open)

Task communication happens here, through [Issues](https://github.com/blockchain-IoT/blockchain-IoT-core/issues). We use a Kanban board, available under the [Project](https://github.com/blockchain-IoT/blockchain-IoT-core/projects) tab.

## Slack
https://blockchainiot.slack.com/open

If you did not get an invitation, please reach out to [Michal](https://github.com/michalmikolajczyk), michal.mikolajczyk at toptal.com

## Whitepaper draft
https://docs.google.com/document/d/1QtdCi4zABw2B0t4zUHncf1yX2hFsMzpVlKlWgtVJi-w/edit#
