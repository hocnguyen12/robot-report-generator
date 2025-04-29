*** Settings ***
Resource    ../resources/keywords/calculator_keywords.resource
Test Setup    Open Calculator
Test Teardown    Close Browser

*** Test Cases ***
Basic Arithmetic Operations
    [Template]    Test Basic Operation
    2    +    3    5
    8    -    3    5
    4    *    3    12
    15    /    3    5

Clear Function
    Click Number    1
    Click Number    2
    Click Number    3
    Verify Calculator State    123
    Click Clear
    Verify Calculator State    0

Complex Calculations
    [Template]    Test Complex Calculation
    10    +    5    *    2    20
    20    /    2    +    3    13
    5    *    3    -    2    13
    10    -    2    *    3    4

Decimal Operations
    [Template]    Test Decimal Operation
    1.5    *    2    3
    3.3    +    1.7    5
    5.5    -    2.5    3
    6.6    /    2    3.3

Error Handling
    [Template]    Test Error Case
    1    /    0    Infinity
    0    /    0    NaN

Equation Display
    Click Number    1
    Click Number    2
    Click Operator    +
    Click Number    3
    Verify Calculator State    3    12+

Multiple Operations
    Click Number    1
    Click Operator    +
    Click Number    2
    Click Operator    +
    Click Number    3
    Click Operator    +
    Click Number    4
    Click Equals
    Verify Calculator State    10

Clear During Calculation
    Click Number    1
    Click Operator    +
    Click Number    2
    Click Clear
    Verify Calculator State    0
    Click Number    3
    Click Operator    *
    Click Number    4
    Click Equals
    Verify Calculator State    12

*** Keywords ***
Test Basic Operation
    [Arguments]    ${num1}    ${operator}    ${num2}    ${expected}
    Perform Calculation    ${num1}    ${operator}    ${num2}
    Verify Calculator State    ${expected}
    Click Clear

Test Complex Calculation
    [Arguments]    ${num1}    ${operator1}    ${num2}    ${operator2}    ${num3}    ${expected}
    Perform Complex Calculation    ${num1}    ${operator1}    ${num2}    ${operator2}    ${num3}    =
    Verify Calculator State    ${expected}
    Click Clear

Test Decimal Operation
    [Arguments]    ${num1}    ${operator}    ${num2}    ${expected}
    ${num1_parts}=    Split String    ${num1}    .
    ${num2_parts}=    Split String    ${num2}    .
    ${expected_str}=    Convert To String    ${expected}
    
    ${steps}=    Create List
    Append To List    ${steps}    ${num1_parts[0]}
    ${has_decimal}=    Evaluate    '.' in '${num1}'
    Run Keyword If    ${has_decimal}    Append To List    ${steps}    .
    Run Keyword If    ${has_decimal}    Append To List    ${steps}    ${num1_parts[1]}
    Append To List    ${steps}    ${operator}
    Append To List    ${steps}    ${num2_parts[0]}
    ${has_decimal}=    Evaluate    '.' in '${num2}'
    Run Keyword If    ${has_decimal}    Append To List    ${steps}    .
    Run Keyword If    ${has_decimal}    Append To List    ${steps}    ${num2_parts[1]}
    Append To List    ${steps}    =

    Perform Complex Calculation    @{steps}
    Verify Calculator State    ${expected_str}
    Click Clear

Test Error Case
    [Arguments]    ${num1}    ${operator}    ${num2}    ${expected}
    Perform Calculation    ${num1}    ${operator}    ${num2}
    Verify Calculator State    ${expected}
    Click Clear
