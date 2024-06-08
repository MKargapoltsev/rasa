*** Settings ***
Documentation     For test automation examples I chose the data-driven testing approach.
...               The _data-driven_ style works well when you need to repeat
...               the same workflow multiple times exactly as we have in our case.
...
...               Taskwarrior general form of the syntax:
...               task [<filter>] [<command>] [<modifications>] [<miscellaneous>]
...
...               Also test templates with embedded arguments are used for 
...               task count and complete task tests.
Library    Process

Test Template     Execute

*** Variables ***
${APP}    task

*** Test Cases ***    Command    Filter    Modifications    Output
Create Task 1    add    priority:H    Pay bills    Created task
Create Task 2    add    Pay the rent     due:eom   Created task 
Create Task 3    add    project:Home.Kitchen    Clean the floor    Created task
Create Task 4    add    project:Home.Garden    Plant the bulbs    Created task
Create Task 5    add     project:Home.Kitchen    Replace broken light bulb    Created task
Modify Task 3    3    modify    priority:L    Modified

Task Count
    [Template]    The count of ${filter} should be exactly ${output}
    project:Home.Kitchen    2
    project:Home.Garden    1
    project:Home    3

Complete Tasks
    [Template]    The task number ${filter} should be ${output}
        3    Completed
        4    Completed

*** Keywords ***
Execute
    [Arguments]    ${Command}    ${Filter}    ${modifications}    ${output}
    ${result} =    Run Process    ${APP}    ${Command}    ${Filter}    ${modifications}
    Should Contain    ${result.stdout}    ${output}

The count of ${filter} should be exactly ${output}
    ${result} =    Run Process    ${APP}    ${filter}    count
    Should Be Equal    ${result.stdout}    ${output}

The task number ${filter} should be ${output}
    ${result} =    Run Process    ${APP}    ${Filter}    done
    Should Contain    ${result.stdout}    ${output}