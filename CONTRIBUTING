# blockchain IoT Contributing Guide

## Communication
Realtime communication happens on [Slack](https://blockchainiot.slack.com/open)

Task communication happens here, through [Issues](https://github.com/blockchain-IoT/blockchain-IoT-core/issues). We use a Kanban board, available under the [Project](https://github.com/blockchain-IoT/blockchain-IoT-core/projects) tab.

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
