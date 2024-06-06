*** Settings ***
Documentation     For test automation examples I chose the data-driven testing approach.
...               The _data-driven_ style works well when you need to repeat
...               the same workflow multiple times as we have in our case.
...
...               Also test templates with embedded arguments are used for 
...               task count and complete task tests.

Test Template     Execute
Library    Process

*** Variables ***
${APP}    task

*** Test Cases ***    Command    Filter    Modifications    Output
Create Task 1    add    priority:H    Pay bills    Created task
Create Task 2    add    Pay the rent     due:eom   Created task 
Create Task 3    add    project:Home.Kitchen    Clean the floor    Created task
Create Task 4    add    project:Home.Garden    Plant the bulbs    Created task
Modify Task    3    modify    priority:L    Modified

Task Count
    [Template]    The count of ${filter} should be exactly ${output}
    project:Home.Kitchen    1
    project:Home    2

Complete Tasks
    [Template]    The task number ${filter} should be ${output}
        3    Completed
        4    Completed

*** Keywords ***
Execute
    [Arguments]    ${Command}    ${Filter}    ${modifications}    ${output}
    ${result} =    Run Process    ${APP}    ${Command}    ${Filter}    ${modifications}    stdout=stdout.txt
    Should Contain    ${result.stdout}    ${output}

The count of ${filter} should be exactly ${output}
    ${result} =    Run Process    ${APP}    ${filter}    count   stdout=stdout.txt
    Should Be Equal    ${result.stdout}    ${output}

The task number ${filter} should be ${output}
    ${result} =    Run Process    ${APP}    ${Filter}    done    stdout=stdout.txt
    Should Contain    ${result.stdout}    ${output}