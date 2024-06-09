*** Settings ***
Documentation     For Rest API test automation examples classic KDD approach is selected.
...
...               RequestsLibrary that is wrapper of the well known Python Requests Library
...               is taking care of Rest API interaction handling.
Resource          general.resource

Suite Setup       Create Session    session    ${BASE_URL}    disable_warnings=True

*** Test Cases ***

Check user data by _id
    [Documentation]                     Verification of user data.
    GET single user by _id              ${USER_ID}
    Check city                          ${USER_CITY}
    Check street name                   ${USER_STREET_NAME}
    Check street number                 ${USER_STREET_NUMBER}
    Check zipcode                       ${USER_ADDRESS_ZIPCODE}
    Check email                         ${USER_EMAIL}
    Check firstname                     ${USER_FIRSTNAME}
    Check lastname                      ${USER_LASTNAME}
    Check phone Number                  ${USER_PHONE_NUMBER}

Check user cart by _id
    [Documentation]                     Verification of user cart content.
    GET single cart by _id              ${CART_ID}
    Check unique products count         ${UNIQUE_PRODUCTS}
    Check UserID for the cart           ${USER_ID}

Check unexisted cart by invalid _id
    [Documentation]                     Verification of error handling in cart request with invalid _id.
    GET cart by invalid _id             ${INVALID_CART_ID}
    Check response code is Bad Request  400
    Check response code error status    ${INVALID_ID_STATUS} 
    Check response code error message   ${INVALID_ID_MESSAGE} 