*** Settings ***
Library    SeleniumLibrary
Variables    ../variables/app_variables.yaml

*** Variables ***
${CALCULATOR_INPUT}    css=[data-testid="calculator-input"]
${CALCULATOR_BUTTON}    css=[data-testid="calculate-button"]
${CALCULATOR_RESULT}    css=[data-testid="calculator-result"]
${NUMBER_BUTTON}    css=[data-testid="number-{0}"]
${OPERATOR_BUTTON}    css=[data-testid="operator-{0}"]
${CLEAR_BUTTON}    css=[data-testid="clear-button"]
${EQUALS_BUTTON}    css=[data-testid="equals-button"]
${DISPLAY}    css=[data-testid="display"]

*** Keywords ***
Open Calculator
    Open Browser    ${app.url}    firefox
    Wait Until Element Is Visible    ${DISPLAY}
    Log    Opened calculator application

Close Calculator
    Close Browser
    Log    Closed calculator application

Click Number
    [Arguments]    ${number}
    ${button_locator}=    Format String    ${NUMBER_BUTTON}    ${number}
    Click Element    ${button_locator}
    Log    Clicked number: ${number}

Click Operator
    [Arguments]    ${operator}
    ${button_locator}=    Format String    ${OPERATOR_BUTTON}    ${operator}
    Click Element    ${button_locator}
    Log    Clicked operator: ${operator}

Click Clear
    Click Element    ${CLEAR_BUTTON}
    Log    Clicked clear button

Click Equals
    Click Element    ${EQUALS_BUTTON}
    Log    Clicked equals button

Perform Calculation
    [Arguments]    ${num1}    ${operator}    ${num2}
    Click Number    ${num1}
    Click Operator    ${operator}
    Click Number    ${num2}
    Click Equals
    Log    Performed calculation: ${num1} ${operator} ${num2}

Verify Display Shows
    [Arguments]    ${expected_value}
    Wait Until Element Is Visible    ${DISPLAY}
    ${actual_value}=    Get Text    ${DISPLAY}
    Should Be Equal As Strings    ${actual_value}    ${expected_value}
    Log    Verified display shows: ${expected_value}

Calculate Expression
    [Arguments]    ${expression}
    Input Text    ${CALCULATOR_INPUT}    ${expression}
    Click Button    ${CALCULATOR_BUTTON}
    Wait Until Element Is Visible    ${CALCULATOR_RESULT}
    ${result}=    Get Text    ${CALCULATOR_RESULT}
    RETURN    ${result}

Verify Calculation Result
    [Arguments]    ${expected_result}
    ${actual_result}=    Get Text    ${CALCULATOR_RESULT}
    Should Be Equal As Numbers    ${actual_result}    ${expected_result} 