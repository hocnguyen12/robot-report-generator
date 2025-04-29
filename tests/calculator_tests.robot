*** Settings ***
Resource    ../resources/keywords/calculator_keywords.resource

*** Test Cases ***
Basic Addition
    Open Calculator
    Perform Calculation    2    +    3
    Verify Display Shows    5
    [Teardown]    Close Browser

Basic Subtraction
    Open Calculator
    Perform Calculation    8    -    3
    Verify Display Shows    5
    [Teardown]    Close Browser

Basic Multiplication
    Open Calculator
    Perform Calculation    4    *    3
    Verify Display Shows    12
    [Teardown]    Close Browser

Basic Division
    Open Calculator
    Perform Calculation    15    /    3
    Verify Display Shows    5
    [Teardown]    Close Browser

Clear Function
    Open Calculator
    Click Number    1
    Click Number    2
    Click Number    3
    Click Clear
    Verify Display Shows    0
    [Teardown]    Close Browser

Complex Calculation
    Open Calculator
    Click Number    1
    Click Number    0
    Click Operator    +
    Click Number    5
    Click Operator    *
    Click Number    2
    Click Equals
    Verify Display Shows    30
    [Teardown]    Close Browser

Error Handling
    Open Calculator
    Click Number    1
    Click Operator    /
    Click Number    0
    Click Equals
    Verify Display Shows    Error
    [Teardown]    Close Browser

Decimal Numbers
    Open Calculator
    Click Number    1
    Click Number    .
    Click Number    5
    Click Operator    *
    Click Number    2
    Click Equals
    Verify Display Shows    3
    [Teardown]    Close Browser 