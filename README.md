# Rasa tech task implementation
-----------------------
- [Technical task description](https://gist.github.com/sanchariGr/fa0e655ed27f3810e720ac85bbecf31b)

## Table of contents:
  - [Tech task analysis](#tech-task-analysis)
  - [Project structure](#project-structure)
  - [Files description](#files-description)
  - [Installation](#installation)
  - [How to run tests](#how-to-run-tests)
  - [Future Improvements](#future-improvements)

## Tech task analysis
Hello Rasa engineering team!

First of all, thank you for the interesting technical tasks.

I haven't come across Pytest very often in my work, although I have some experience writing tests using Pytest in my [personal project](https://github.com/MKargapoltsev/python-blockchain/tree/main/backend/tests). But to develop this task, I chose the Robot Framework, which is surprisingly good and fits well here since it will be possible to solve 2 diverse tasks (CLI and Rest API test automation) using only 1 external library (RequestsLibrary) to handle HTTP requests.

In this section you can find the results of the brainstorm session and a description of some ideas for test scenarios for automation, which I came to after briefly familiarizing myself with the provided applications.

### Part 1: Automating the CLI application

1. Simple ‘happy path’ test cases for smoke testing to ensure that product is not broken and can be launched with no major issues.
    1. Task add Plan your day // _check that task app returns confirmation that the task has been successfully added_
    2. Task list // _check that just added task is here in the task list_
    3. Task Plan your day done // _check that task app returns confirmation that the task has been successfully completed_
    4. Task list // _check that the just completed task is NOT present in the task list_
2. Expand smoke test cases that affect/touch more functional areas of the product code to check that the product as a whole, at the integration level, runs without major issues.
    1. Extend commands usage by adding following commands to tests - modify, delete, count.
    2. Add filters - project, end, entry.
    3. Add modifications - priority, tags add/delete
    4. Add miscellaneous arguments - show
3. Cover ‘task’ entity life cycle workflows using State Transition test design technique. Possible task states: pending, waiting, recurring, deleted, completed.
4. Add real life end-to-end user scenarios as end-to-end automated tests

### Part 2: Automating REST API endpoints

1. Simple ‘happy path’ test cases for smoke testing to ensure that product is not broken and can be launched with no major issues.
2. As a smoke check of the RestAPI service check that basis routes are accessible, returns status code 200 and all HTTP methods are still supported. 
    1. GET /products
    2. GET /products/1
    3. GET /products/categories
    4. GET /products/category/jewelery
    5. GET /carts?userId=1
    6. GET /products?limit=5
    7. POST /products
    8. PUT /products/1
    9. PATCH /products/1
    10. DELETE /products/1
3. Cover in test automation all 4 main resource types and all Rest API end points with functional tests
    1. Products
        - Get all products
        - Get a single product
        - Limit results
        - Sort results
        - Get all categories
        - Get in category
        - Add new product
        - Update a product
        - Delete a product
    2. Carts
        - Get all
        - Get a single
        - Limit results
        - Sort results
        - get in date range
        - get user cart
        - Add new cart
        - Update a cart
        - Delete a cart
    3. Users
        - Get all
        - Get a single
        - Limit results
        - Sort results
        - Add
        - Update
        - Delete
    4. Login token
        - User login
4. Add real life end-to-end user scenarios as end-to-end test cases
    1. User login
    2. Search for needed products with using category and results sorting
    3. Add products to the shopping cart
    4. Update the shopping cart
    5. And etc.
5. Verify error handling implementation, absense of exceptions, HTTP status codes 2xx, 3xx, 4xx, 5xx implementation
6. Verify valid data ranges for Integers and Floats. Using Equivalence Partitioning and full boundary value analysis test design techniques.
7. Verify required and optional path and queue fields (userId, limit, etc)
8. Validate JSON responses against original JSON schema

Implementation of few tests from this list you can find in this repository.

## Project structure
```bash
rasa
├── .github
│   ├── workflows
│   │   ├── robot-framework.yml
├── tests
│   ├── keywords
│   │   ├── common.resource
│   ├── automated_API_tests.robot
│   ├── automated_CLI_tests.robot
│   ├── general.resource
├── .gitattributes
├── .gitignore
├── README.md
├── requirements.txt
```
### Files description
| file path  | description |
| ------------- | ------------- |
| .github/workflows/robot-framework.yml | Git Actions YAML file for CI |
| keywords/common.resource  | robot framework resource file that contains all keywords implementation that needed to run the tests  |
| tests/automated_API_tests.robot  | robot frework test file that contains automated API tests  |
| tests/automated_CLI_tests.robot  | robot frework test file that contains automated CLI tests  |
| general.resource  | resoruce file that contains libraries, variables and test data   |
| README.md  | document that contains all important information about tech task implementation |
| requirements.txt  | this file contains everything needs to be installed for test execution  |

## Installation
Clone the git repository with tech task locally
```bash
git clone https://github.com/MKargapoltsev/rasa.git
cd rasa
```
> Create and activate the virtual environment
```bash
python3 -m venv rasa-env
source rasa-env/bin/Activate
```
> Install all packages
```bash
pip install -r requirements.txt
```
>  Install Task warrior - on Mac OS
```bash
brew install task
```
>  or on Linux
```bash
apt-get install taskwarrior -y
```
>  If Task warrior app is newly installed - launch it first time manually to init DB and type 'yes' in confirmation field
```bash
task
```
## How to run tests
> test execution of all tests
```bash
python -m robot --outputdir reports tests
```
> test execution of API tests only
```bash
python -m robot --outputdir reports tests/automated_API_tests.robot
```
> test execution of CLI tests only
```bash
python -m robot --outputdir reports tests/automated_CLI_tests.robot
```
> [!NOTE]
> On second execution some CLI tests will fail, because task count will be changed.
> To avoid such cases you use can erase taskwarrior DB on virtual env using:
```bash
rm ~/.task/taskchampion.sqlite3
```
> To run the tests using Git Actions just [go to Actions section](https://github.com/MKargapoltsev/rasa/actions/workflows/robot-framework.yml) and click **Run Workflow** button for main branch.
> After job is completed you can download Robot Framework test report from job Summary > Artifacts fot detailed analysis.
 
## Future Improvements
### CLI part
- Add task deletion helper that handles addition STDIN with confirm/decline to delete
- Add keyword step that accepts any number of arguments that can be useful for E2E tests
- Add STDOUT results parser for more flexible and detailed app response analysis

### API part
- Add keywords for POST, PUT, PATCH and DELETE HTTP methods for test coverage of all supported HTTP methods on current site
- Add advanced helper and keywords for better serialization/deserialization of JSON objects

### Common and CI parts
- Extend data driven approach with CSV/XLS files support on located on cloud storage
- Handle suite/tests Pre- and Post- conditions, e.g. tasks/DB deletion as post steps for CLI app (low priority now, since execution env on CI will be newly recreated for CI job and deleted after test execution )
- Add robot test reports injection for commits used into main branch. Re-enable generate report Git action when current issue (cannot parse "" as "2006") in robotframework-reporter-action action will be fixed. https://github.com/MKargapoltsev/rasa/blob/4ad435909e82b97e785d65a25e8706d90d914a47/.github/workflows/robot-framework.yml#L30
- Improve tests reports quality by integrating Allure test reports https://allurereport.org/docs/robotframework/
