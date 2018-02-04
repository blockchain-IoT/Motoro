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

### Setting up and running local testnet

We will use [ethereumjs / testrpc](https://github.com/ethereumjs/testrpc). After installing the dependencies from the repo, while still in the root dir of the repo, type the below command to run the testnet:

```
./node_modules/.bin/testrpc
```

or you could install `testrpc` globally, and run it like this:

```
npm install -g ethereumjs-testrpc
testrpc
```

Leave the testnet running in a terminal window.
_Note that we might want to include that script in a single-command setup_

### Install truffle

```
npm i -g truffle
```

### Starting our dapp

The dapp lives in `blockchain-IoT-core/src/alpha-react`. Navigate to that directory, install the dependencies:

```
cd src/alpha-react
npm i
```

compile the contracts:

```
truffle compile
```

migrate them to the testnet:
```
truffle migrate
```

run the Node.js / React front-end:

```
npm start
```

and check that it all works, by accessing the frontend through [http://localhost:3000](http://localhost:3000). That page should open automatically though. 

At the bottom of the page, you should see `Yamaha: _n_`, where `n` is the count of times you refreshed the page :) What is important though, is that the machine – `Yamaha` – is actually added to the Smart Contract the first time the front-end is opened. That is of course very primitive, but working proof of concept and a good starting point. We now need to connect to the Dapp from an IoT device.

## Contributing
Please refer to the [Contributing guidelines for this project](https://github.com/blockchain-IoT/blockchain-IoT-core/blob/master/CONTRIBUTING.md).
### Adding issues
Check out the [Issue Template](https://github.com/blockchain-IoT/blockchain-IoT-core/blob/master/issue_template.md)
### Pull Requests
Check out the [Pull Request Template](https://github.com/blockchain-IoT/blockchain-IoT-core/blob/master/PULL_REQUEST_TEMPLATE.md)

## Communication
Realtime communication happens on [Slack](https://blockchainiot.slack.com/open)

Task communication happens here, through [Issues](https://github.com/blockchain-IoT/blockchain-IoT-core/issues). We use a Kanban board, available under the [Project](https://github.com/blockchain-IoT/blockchain-IoT-core/projects) tab.

## Slack
https://blockchainiot.slack.com/open

If you did not get an invitation, please reach out to [Michal](https://github.com/michalmikolajczyk), michal.mikolajczyk at toptal.com

## Whitepaper draft
https://docs.google.com/document/d/1QtdCi4zABw2B0t4zUHncf1yX2hFsMzpVlKlWgtVJi-w/edit#

## References
### IoT
#### Articles
* https://www.linux.com/news/21-open-source-projects-IoT
* https://iot-analytics.com/5-things-know-about-iot-platform/
* https://dzone.com/articles/iot-software-platform-comparison
* https://www.quora.com/What-are-some-of-the-open-source-projects-in-IoT
* https://auth0.com/blog/javascript-for-microcontrollers-and-iot-part-1/
* https://www.postscapes.com
* http://iotinnovator.com/
#### Proprietary articles
* Enterprise IoT Checklist http://go.pardot.com/e/359721/2eHzlZW/dj28/5085969
* 10 industrial IoT use cases http://go.pardot.com/e/359721/2gNaxAp/4ps6/5538517
#### Networks
* http://www.iotlandscape.at/ – friends
* http://www.silkroad40.com/ – also friends
 Resources by potential open-source partners
#### Testing
* https://devops.com/functional-testing-iot/
* https://github.com/AppSaloon/ecu-can-bus-simulator
#### Software (open)
* https://github.com/rwaldron/johnny-five (JavaScript)
* https://github.com/hybridgroup/cylon/ (JavaScript)
* https://github.com/Samsung/iotjs (JavaScript)
* https://nodered.org/ (IoT network design)
* https://iot.eclipse.org/ (Java) https://iot.eclipse.org/projects/
* https://www.kaaproject.org/ (Java, C, C++)
* https://www.mainflux.com/ https://github.com/mainflux/mainflux (C/C++, JavaScript, Go and Python)
* https://github.com/cesanta
* https://www.mbed.com/en/platform/
* https://github.com/lelylan/lelylan/ (microservices)
* https://macchina.io/ (JavaScript and C++)
* http://www.sitewhere.org/
* https://thingspeak.com/
* http://www.lelylan.com
* https://www.supla.org/en/
* http://www.zettajs.org/ (Node.js, API-first)
* https://github.com/thingsboard/thingsboard (Device management, data collection, processing and visualization)
* https://github.com/google/physical-web (Web of Things)
#### Software (proprietary)
* https://cloud.google.com/solutions/iot/
* https://www.ge.com/digital/predix
#### Apps
* http://www.blynk.cc/
* https://www.stringify.com/
* http://realityeditor.org/
#### End-to-End (OSS + OSH)
* https://tessel.io/
### Blockchain IoT
#### Articles
* https://www.postscapes.com/blockchains-and-the-internet-of-things/
#### Consultants
* https://www.chainofthings.com/
* https://slock.it/ – https://en.wikipedia.org/wiki/The_DAO_(organization)
* https://www.oakeninnovations.com/
#### Software
* https://github.com/iotaledger
* https://github.com/flowchain
#### End-to-End Solutions
* https://filament.com/
* http://www.hyperledger.org/
### Machines
#### ECU tuning
* http://www.motorcyclistonline.com/all-about-tuning-your-bikes-efi-adding-power-commander-or-reflashing-ecu-motorcyclist-mc-garage-tech
* http://www.vortexcdi.com/
* https://thumpertalk.com/forums/topic/1087931-anyone-using-vortex-ecu-on-their-dirtbike/
#### Vehicle Remote Hijacking
* https://www.wired.com/2015/07/hackers-remotely-kill-jeep-highway/
#### Full Stack Hello World Voting Ethereum Dapp Tutorial
* https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-1-40d2d0d807c2
* https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-2-30b3d335aa1f
* https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-3-331c2712c9df
