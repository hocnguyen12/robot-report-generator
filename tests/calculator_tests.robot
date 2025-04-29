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

Multiple Decimal Points Error
    Click Number    1
    Click Decimal
    Click Number    5
    Click Decimal
    Click Number    2
    Click Equals
    Verify Calculator State    Error
    Click Clear
    Click Decimal
    Click Number    3
    Click Decimal
    Click Number    4
    Click Equals
    Verify Calculator State    Error

Large Numbers
    [Template]    Test Basic Operation
    999999    +    1    1000000
    1000000    *    2    2000000
    2000000    /    2    1000000
    999999    -    999998    1

Negative Numbers
    Click Number    5
    Click Operator    -
    Click Number    8
    Click Equals
    Verify Calculator State    -3
    Click Clear
    Click Number    1
    Click Operator    -
    Click Number    1
    Click Operator    -
    Click Number    1
    Click Equals
    Verify Calculator State    -1

Precision Edge Cases
    [Template]    Test Decimal Operation
    0.1    +    0.2    0.30000000000000004
    0.0001    *    10000    1
    0.000001    *    1000000    1
    0.0000001    *    10000000    1

Operator Precedence
    [Template]    Test Complex Calculation
    2    +    3    *    4    14
    10    -    2    *    3    4
    20    /    2    +    3    13
    5    *    3    -    2    13

*** Keywords ***
Test Basic Operation
    [Arguments]    ${num1}    ${operator}    ${num2}    ${expected}
    Click Clear
    Perform Calculation    ${num1}    ${operator}    ${num2}
    Verify Calculator State    ${expected}

Test Complex Calculation
    [Arguments]    ${num1}    ${operator1}    ${num2}    ${operator2}    ${num3}    ${expected}
    Click Clear
    Perform Complex Calculation    ${num1}    ${operator1}    ${num2}    ${operator2}    ${num3}    =
    Verify Calculator State    ${expected}

Test Decimal Operation
    [Arguments]    ${num1}    ${operator}    ${num2}    ${expected}
    Click Clear
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

    log   ${steps}
    
    Perform Complex Calculation    @{steps}
    Verify Calculator State    ${expected_str}

Test Error Case
    [Arguments]    ${num1}    ${operator}    ${num2}    ${expected}
    Click Clear
    Perform Calculation    ${num1}    ${operator}    ${num2}
    Verify Calculator State    ${expected}
