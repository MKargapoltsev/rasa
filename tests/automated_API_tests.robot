*** Settings ***                                                                                       
Library    Collections                                                                                 
Library    RequestsLibrary
                                                                                                       
Suite Setup    Create Session    session    ${BASE_URL}    disable_warnings=True

*** Variables ***
${BASE_URL}    https://fakestoreapi.com/
                                                                                                       
*** Test Cases ***                                                                                     
                                                                                                       
Get a Single Cart
    [Documentation]    Verification of GET response and its JSON content.
    ${response}=     GET On Session  session  /carts/5
    Status Should Be    OK                                     

    # Log To Console    ${response.json()['id']}
    Should Be Equal As Strings     ${response.json()['id']}    5

Get an User Cart
    [Documentation]    
    ${response}=     GET On Session  session    url=/carts?userId=1
    Status Should Be    OK 

    # Log To Console    ${response.json()}