*** Settings ***
Resource                        ../general.resource

*** Keywords ***
#CLI tests keywords section
Execute
    [Documentation]             Executing CLI app with provided arguments and checking output
    [Arguments]                 ${Command}    ${Filter}  ${modifications}  ${output}
    ${result} =                 Run Process   ${APP}     ${Command}        ${Filter}    ${modifications}
    Should Contain              ${result.stdout}         ${output}

The count of ${filter} should be exactly ${output}
    [Documentation]             Comparing task count results
    ${result} =                 Run Process   ${APP}     ${filter}         count
    Should Be Equal             ${result.stdout}         ${output}

The task number ${filter} should be ${output}
    [Documentation]             Checking completed tasks
    ${result} =                 Run Process    ${APP}    ${Filter}         done
    Should Contain              ${result.stdout}         ${output}

#API tests keywords section
Get Single User by _id
    [Documentation]             Get data about a specific user by his ID
    [Arguments]                 ${ID}
    ${response}=                GET On Session    session                  /users/${ID} 
    Status Should Be            OK
    Log                         ${response}
    Set Test Variable           ${response}

Check City
    [Documentation]             Comparing the contents of JSON with the expected value
    [Arguments]                 ${CITY}
    Should Be Equal             ${response.json()['address']['city']}      ${CITY}

Check Street Name
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${STREET}
    Should Be Equal             ${response.json()['address']['street']}    ${STREET}

Check Street Number
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${NUMBER}
    Should Be Equal As Strings  ${response.json()['address']['number']}    ${NUMBER}

Check Zipcode
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${ZIP}
    Should Be Equal             ${response.json()['address']['zipcode']}   ${ZIP}

Check Email
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${EMAIL}
    Should Be Equal             ${response.json()['email']}                ${EMAIL}

Check Firstname
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${FNAME}
    Should Be Equal             ${response.json()['name']['firstname']}    ${FNAME}

Check Lastname
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${LNAME}
    Should Be Equal             ${response.json()['name']['lastname']}     ${LNAME}

Check Phone Number
    [Documentation]             Comparing the contents of JSON with the expected value    
    [Arguments]                 ${PHONE}
    Should Be Equal             ${response.json()['phone']}                ${PHONE}

Get Single Cart by _id
    [Documentation]             Get data about a specific cart by its ID    
    [Arguments]                 ${ID}
    ${response}=                GET On Session    session                  /carts/${ID} 
    Status Should Be            OK
    Log                         ${response}
    Set Test Variable           ${response}

Check unique products count
    [Documentation]             Comparing the number of unique products in JSON with the expected value   
    [Arguments]                 ${NUMBER}
    ${products_quantity}=       Get Length                                 ${response.json()['products']}
    Should Be Equal As Strings  ${products_quantity}                       ${NUMBER}

Check UserID for the cart
    [Documentation]             Comparing the contents of JSON with the expected value
    [Arguments]                 ${ID}
    Should Be Equal As Strings  ${response.json()['userId']}               ${ID}

GET cart by invalid _id
    [Documentation]             Get response for an invalid cart request
    [Arguments]                 ${ID}
    ${response}=                GET On Session    session                  /carts/${ID}    expected_status=anything 
    Log                         ${response}
    Set Test Variable           ${response}

Check response code is Bad Request
    [Documentation]             Checking that response status code is 400
    [Arguments]                 ${CODE}
    Status Should Be            ${CODE}                                    ${response}

Check response code error status
    [Documentation]             Comparing the contents of JSON with the expected value of error status
    [Arguments]                 ${STATUS}
    Should Be Equal             ${response.json()['status']}              ${STATUS}


Check response code error message
    [Documentation]             Comparing the contents of JSON with the expected value of error message
    [Arguments]                 ${MESSAGE}
    Should Be Equal             ${response.json()['message']}              ${MESSAGE}