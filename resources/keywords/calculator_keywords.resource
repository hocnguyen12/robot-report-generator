*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    common_keywords.resource
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Calculator
    Open Browser    ${app.url}    chrome
    Login To Application
    Ensure Logged In
    Click Element    ${selectors.header.calculator_button}
    Wait Until Page Contains Element    ${selectors.calculator.calculator}
    Log    Opened calculator application

Close Calculator
    Logout From Application
    Ensure Logged Out
    Close Browser
    Log    Closed calculator application

Click Number
    [Arguments]    ${number}
    ${digits}=    Split String To Characters    ${number}
    FOR    ${digit}    IN    @{digits}
        ${button_locator}=    Format String    ${selectors.calculator.number_button}    ${digit}
        Click Element    ${button_locator}
    END
    Log    Clicked number: ${number}

Click Operator
    [Arguments]    ${operator}
    ${operator_map}=    Create Dictionary    +=add    -=subtract    *=multiply    /=divide
    ${operator_key}=    Get From Dictionary    ${operator_map}    ${operator}
    ${button_locator}=    Format String    ${selectors.calculator.operator_button}    ${operator_key}
    Click Element    ${button_locator}
    Log    Clicked operator: ${operator}

Click Clear
    Click Element    ${selectors.calculator.clear_button}
    Log    Clicked clear button

Click Equals
    Click Element    ${selectors.calculator.equals_button}
    Log    Clicked equals button

Click Decimal
    Click Element    ${selectors.calculator.decimal_button}
    Log    Clicked decimal point

Perform Calculation
    [Arguments]    ${num1}    ${operator}    ${num2}
    Click Number    ${num1}
    Click Operator    ${operator}
    Click Number    ${num2}
    Click Equals
    Log    Performed calculation: ${num1} ${operator} ${num2}

Verify Display Shows
    [Arguments]    ${expected_value}
    Wait Until Page Contains Element    ${selectors.calculator.display}
    ${actual_value}=    Get Text    ${selectors.calculator.display}
    Should Be Equal As Strings    ${actual_value}    ${expected_value}
    Log    Verified display shows: ${expected_value}

Verify Equation Shows
    [Arguments]    ${expected_equation}
    Wait Until Page Contains Element    ${selectors.calculator.equation_display}
    ${actual_equation}=    Get Text    ${selectors.calculator.equation_display}
    Should Be Equal As Strings    ${actual_equation}    ${expected_equation}
    Log    Verified equation shows: ${expected_equation}

Perform Complex Calculation
    [Arguments]    @{steps}
    ${step_count}=    Set Variable    0
    FOR    ${step}    IN    @{steps}
        Run Keyword If    '${step}' in ['+', '-', '*', '/']    Click Operator    ${step}
        ...    ELSE IF    '${step}' == '='    Click Equals
        ...    ELSE IF    '${step}' == '.'    Click Decimal
        ...    ELSE    Click Number    ${step}
        ${step_count}=    Evaluate    ${step_count} + 1
    END
    Log    Performed complex calculation: @{steps}

Verify Calculator State
    [Arguments]    ${expected_display}    ${expected_equation}=${EMPTY}
    Verify Display Shows    ${expected_display}
    Run Keyword If    '${expected_equation}' != '${EMPTY}'    Verify Equation Shows    ${expected_equation}
    Log    Verified calculator state - Display: ${expected_display}, Equation: ${expected_equation}

Calculate Expression
    [Arguments]    ${expression}
    Input Text    ${selectors.calculator.calculator_input}    ${expression}
    Click Button    ${selectors.calculator.calculator_button}
    Wait Until Element Is Visible    ${selectors.calculator.calculator_result}
    ${result}=    Get Text    ${selectors.calculator.calculator_result}
    RETURN    ${result}

Verify Calculation Result
    [Arguments]    ${expected_result}
    ${actual_result}=    Get Text    ${selectors.calculator.calculator_result}
    Should Be Equal As Numbers    ${actual_result}    ${expected_result}