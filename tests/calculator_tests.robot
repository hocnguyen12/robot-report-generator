*** Settings ***
Resource    ../resources/keywords/calculator_keywords.resource
Test Setup    Open Calculator
Test Teardown    Close Browser

*** Test Cases ***
Basic Addition
    Perform Calculation    2    +    3
    Verify Display Shows    5

Basic Subtraction
    Perform Calculation    8    -    3
    Verify Display Shows    5

Basic Multiplication
    Perform Calculation    4    *    3
    Verify Display Shows    12

Basic Division
    Perform Calculation    15    /    3
    Verify Display Shows    5

Clear Function
    Click Number    1
    Click Number    2
    Click Number    3
    Click Clear
    Verify Display Shows    0

Complex Calculation
    Click Number    1
    Click Number    0
    Click Operator    +
    Click Number    5
    Click Operator    *
    Click Number    2
    Click Equals
    Verify Display Shows    30

Error Handling
    Click Number    1
    Click Operator    /
    Click Number    0
    Click Equals
    Verify Display Shows    Error

Decimal Numbers
    Click Number    1
    Click Number    .
    Click Number    5
    Click Operator    *
    Click Number    2
    Click Equals
    Verify Display Shows    3