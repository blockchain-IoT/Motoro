<img src="https://secure.meetupstatic.com/photos/event/6/d/d/highres_445201757.jpeg" alt="Toptal" width="233" align="left" />
<img src="https://s3.amazonaws.com/poly-screenshots.angel.co/Project/56/593071/c73b67bbe540a18c37939706bbbe3992-thumb_jpg.jpg" alt="VIKING GARAGE" width="233" align="right" />
<br clear="both" />

# blockchain IoT – core
The core repo for the Blockchain IoT project, including onboarding.

## Our goal
**To deliver open-source tools, which integrate blockchain and IoT ecosystems.**

**The tools combined, make for a modular, End-to-End solution. They will be used to develop _transportation_ and _digital control systems_, and _supply chain networks_.**

**We intend to provide low– and mid-level facilities and integrations, to help engineers and organizations to create blockchain-connected IoT systems and devices.**

## Slack
https://blockchainiot.slack.com/open

If you did not get an invitation, please reach out to [Michal](https://github.com/michalmikolajczyk), michal.mikolajczyk at toptal.com

## Workflow
We strive to follow the [Kanban development method](https://en.wikipedia.org/wiki/Kanban_(development)) in the project. In our practice, those are the requirements:
* The person who takes on a task, pushes it through the sequential stages, until code or design is merged into the `master` branch
* Only one task `In Progress` per person
* Not more then 5 tasks assigned to a single person, ever
* We try to finish the tasks as quickly as possible, as there are no deadlines
* Only take on the tasks from the `To do` column, and not from the `Backlog` column. Tasks marked as `Blocker` or `question` have priority

### Communication
Realtime communication happens on [Slack](https://blockchainiot.slack.com/open)

Task communication happens here, through [Issues](https://github.com/blockchain-IoT/blockchain-IoT-core/issues). We use a Kanban board, available under the [Project](https://github.com/blockchain-IoT/blockchain-IoT-core/projects) tab.

### Github flow
For handling the workflow with git, branching and PRs, we will use [Github flow](https://guides.github.com/introduction/flow/)

### How to actually start working on this project
1. Read through this document, and the articles on Wiki, which this document refers to
2. You are most welcome to [join us on Slack](https://blockchainiot.slack.com/open)
3. Pick a task from the _Issues_ tab
4. [Fork the project](https://help.github.com/articles/working-with-forks/), and resolve the issue on your fork
5. When you are done with your work, please [rebase on the latest `master` branch from this repo](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
6. [Create a Pull Request (PR) from your fork](https://help.github.com/articles/creating-a-pull-request-from-a-fork/).<br /> **Important: please refer to the issue hash in the PR title, e.g. `#1 initial tool set stable and tested`**
7. The PR will be automatically tested on Travis CI
8. The code needs to be reviewed and accepted by another team member
9. After the tests pass, the software will be automatically deployed to a [Heroku Review App](https://devcenter.heroku.com/articles/github-integration-review-apps) with [Heroku Pipelines](https://devcenter.heroku.com/articles/pipelines)
10. The deployed software needs to be pass QA, _Quality Assurance_, which basically means that the review app should be manually tested against the requirements from the Issue, by another team member
11. It is the PR's author responsibility to make sure that the PR gets assigned to available team members, and signed off, in a reasonable time
12. Once the PR passes the automated tests, code review and QA, it will be merged into `master`, and automatically deployed to the `staging` app within our Heroku Pipeline

## Whitepaper draft
https://docs.google.com/document/d/1QtdCi4zABw2B0t4zUHncf1yX2hFsMzpVlKlWgtVJi-w/edit#

## References
### IoT
#### Articles
* https://iot-analytics.com/5-things-know-about-iot-platform/
* https://dzone.com/articles/iot-software-platform-comparison
* https://www.quora.com/What-are-some-of-the-open-source-projects-in-IoT
* https://auth0.com/blog/javascript-for-microcontrollers-and-iot-part-1/
#### Networks
* http://www.iotlandscape.at/ – friends
* http://www.silkroad40.com/ – also friends
* Resources by potential open-source partners
* Enterprise IoT Checklist http://go.pardot.com/e/359721/2eHzlZW/dj28/5085969
* 10 industrial IoT use cases http://go.pardot.com/e/359721/2gNaxAp/4ps6/5538517
#### Testing
* https://devops.com/functional-testing-iot/
* https://github.com/AppSaloon/ecu-can-bus-simulator
#### Software (open)
* https://github.com/rwaldron/johnny-five (JavaScript)
* https://github.com/hybridgroup/cylon/ (JavaScript)
* https://github.com/Samsung/iotjs (JavaScript)
* https://github.com/cesanta
* https://www.mbed.com/en/platform/
* https://macchina.io/
* http://www.sitewhere.org/
* https://thingspeak.com/
* http://www.lelylan.com
* https://www.supla.org/en/
#### Software (proprietary)
* https://cloud.google.com/solutions/iot/
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
