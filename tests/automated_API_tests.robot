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
Resource          general.resource

Suite Setup    Create Session    session    ${BASE_URL}    disable_warnings=True

*** Test Cases ***

Check User data by _id
    [Documentation]    Verification of user data.
    Get Single User by _id          ${USER_ID}
    Check City                      ${USER_CITY}
    Check Street name               ${USER_STREET_NAME}
    Check Street number             ${USER_STREET_NUMBER}
    Check Zipcode                   ${USER_ADDRESS_ZIPCODE}
    Check Email                     ${USER_EMAIL}
    Check Firstname                 ${USER_FIRSTNAME}
    Check Lastname                  ${USER_LASTNAME}
    Check Phone Number              ${USER_PHONE_NUMBER}

Check User cart by _id
    [Documentation]    Verification of user cart content.
    Get Single Cart by _id          ${CART_ID}
    Check unique products count     ${UNIQUE_PRODUCTS}
    Check UserID for the cart       ${USER_ID}