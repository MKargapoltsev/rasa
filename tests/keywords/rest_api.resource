*** Settings ***
Resource          ../general.resource

*** Keywords ***
Get Single User by _id
    [Documentation]    
    [Arguments]                 ${ID}
    ${response}=                GET On Session    session    /users/${ID} 
    Status Should Be            OK
    Log                         ${response}
    Set Test Variable           ${response}

Check City
    [Documentation]    
    [Arguments]                 ${CITY}
    Should Be Equal             ${response.json()['address']['city']}    ${CITY}

Check Street Name
    [Documentation]    
    [Arguments]                 ${STREET}
    Should Be Equal             ${response.json()['address']['street']}    ${STREET}

Check Street Number
    [Documentation]    
    [Arguments]                 ${NUMBER}
    Should Be Equal As Strings  ${response.json()['address']['number']}    ${NUMBER}

Check Zipcode
    [Documentation]    
    [Arguments]                 ${ZIP}
    Should Be Equal             ${response.json()['address']['zipcode']}    ${ZIP}

Check Email
    [Documentation]    
    [Arguments]                 ${EMAIL}
    Should Be Equal             ${response.json()['email']}    ${EMAIL}

Check Firstname
    [Documentation]    
    [Arguments]                 ${FNAME}
    Should Be Equal             ${response.json()['name']['firstname']}    ${FNAME}

Check Lastname
    [Documentation]    
    [Arguments]                 ${LNAME}
    Should Be Equal             ${response.json()['name']['lastname']}    ${LNAME}

Check Phone Number
    [Documentation]    
    [Arguments]                 ${PHONE}
    Should Be Equal             ${response.json()['phone']}    ${PHONE}

Get Single Cart by _id
    [Documentation]    
    [Arguments]                 ${ID}
    ${response}=                GET On Session    session    /carts/${ID} 
    Status Should Be            OK
    Log                         ${response}
    Set Test Variable           ${response}

Check unique products count
    [Documentation]    
    [Arguments]                 ${NUMBER}
    ${products_quantity}=       Get Length     ${response.json()['products']}
    Should Be Equal As Strings  ${products_quantity}    ${NUMBER}

Check UserID for the cart
    [Documentation]    
    [Arguments]                 ${ID}
    Should Be Equal As Strings  ${response.json()['userId']}    ${ID}