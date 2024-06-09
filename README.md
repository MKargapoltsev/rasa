# Rasa tech task implementation
-----------------------
- [Technical task description](https://gist.github.com/sanchariGr/fa0e655ed27f3810e720ac85bbecf31b)

## Context table
> Index `README`.
  - [Tech task analysis](#tech-task-analysis)
  - [Project structure](#project-structure)
  - [Installation](#installation)
  - [How to test](#how-to-test)
  - [Future Improvements](#future-improvements)

## Tech task analysis
Here you can find the results of the brainstorm session and a description of some ideas for test scenarios for automation, which I came to after briefly familiarizing myself with the provided applications.

### Part 1: Automating the CLI application

1. Simple ‘happy path’ test cases for smoke testing to ensure that product not broken and launches with no major issues.
    1. Task add Plan your day // check that task app returned confirmation that the task has been successfully added
    2. Task list // _check that just added task is here in the task list_
    3. Task Plan your day done // _check that task app returned confirmation that the task has been successfully completed_
    4. Task list // _check that just completed task is NOT present in the task list_
2. Expand smoke test cases that affect/touch more functional areas of the product code to check that the product as a whole, at the integration level, runs without major issues.
    1. Extend commands usage by adding following commands to tests - modify, delete, count.
    2. Add filters - project, end, entry.
    3. Add modifications - priority, tags add/delete
    4. Add miscellaneous arguments - show
3. Cover ‘task’ entity life cycle workflows using State Transition test design technic. Possible task states: pending, waiting, recurring, deleted, completed.
4. Add real life end-to-end user scenarios as end-to-end test cases

### Part 2: Automating REST API endpoints

1. Simple ‘happy path’ test cases for smoke testing to ensure that product not broken and launches with no major issues.
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
        1. Get all products
        2. Get a single product
        3. Limit results
        4. Sort results
        5. Get all categories
        6. Get in category
        7. Add new product
        8. Update a product
        9. Delete a product
    2. Carts
        1. Get all
        2. Get a single
        3. Limit results
        4. Sort results
        5. get in date range
        6. get user cart
        7. Add new cart
        8. Update a cart
        9. Delete a cart
    3. Users
        1. Get all
        2. Get a single
        3. Limit results
        4. Sort results
        5. Add
        6. Update
        7. Delete
    4. Login token
        1. User login
4. Add real life end-to-end user scenarios as end-to-end test cases
    1. User login
    2. Search for needed product with using category and results sorting
    3. Add products to the shopping cart
    4. Update the shopping cart
    5. And etc.
5. Verify error handling implementation, absense of exceptions, HTTP status codes 2xx, 3xx, 4xx, 5xx implementation
6. Verify valid data ranges for Integers and Floats. Using Equivalence Partitioning and full boundary value analysis test design technics.
7. Verify required and optional path and queue fields (userId, limit, etc)
8. Validate JSON responses against original JSON schema 

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
## Installation
> Activate the virtual environment
```
source rasa-env/bin/Activate
```

> Install all packages
```
pip3 install -r requirements.txt
```
>  Install Task warrior
```
brew install task
```
## How to test
> test execution
```
python -m robot --outputdir reports tests
```
## Future Improvements
- Extend data driven approach with CSV/XLS files suport on located on cloud storage
- Add task deletion helper that handles addition STDIN with conformation/decline to delete
- Handle tests Pre- and Post- conditions, e.g. tasks/DB deletion as post steps (low priority since execution env on CI will be newly created and deleted after test execution )
- Add robot test reports injection for commits used into main branch. Re-enable generate report Git action when current issue (cannot parse "" as "2006") in robotframework-reporter-action action will be fixed.
- Improve tests reports quality by adding Allure report https://allurereport.org/docs/robotframework/
