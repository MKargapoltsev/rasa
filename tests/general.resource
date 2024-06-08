*** Settings ***
Library        RequestsLibrary
Library        Collections
Resource       keywords/rest_api.resource

*** Variables ***
${BASE_URL}                      https://fakestoreapi.com/

${USER_ID}                       1
${CART_ID}                       1

${USER_CITY}                     kilcoole
${USER_STREET_NAME}              new road
${USER_STREET_NUMBER}            7682
${USER_ADDRESS_ZIPCODE}           12926-3874
${USER_EMAIL}                    john@gmail.com
${USER_USERNAME}                 johnd
${USER_FIRSTNAME}                john
${USER_LASTNAME}                 doe
${USER_PHONE_NUMBER}             1-570-236-7033

${UNIQUE_PRODUCTS}               3
${OVERALL_PRODUCTS}              11 