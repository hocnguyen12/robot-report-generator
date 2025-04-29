*** Settings ***
Library    SeleniumLibrary
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Calculator
    Open Browser    ${app.url}    chrome
    Click Element    ${selectors.header.calculator_button}
    Wait Until Element Is Visible    ${selectors.calculator.display}
    Log    Opened calculator application

Close Calculator
    Close Browser
    Log    Closed calculator application

Click Number
    [Arguments]    ${number}
    ${button_locator}=    Format String    ${selectors.calculator.number_button}    ${number}
    Click Element    ${button_locator}
    Log    Clicked number: ${number}

Click Operator
    [Arguments]    ${operator}
    ${button_locator}=    Format String    ${selectors.calculator.operator_button}    ${operator}
    Click Element    ${button_locator}
    Log    Clicked operator: ${operator}

Click Clear
    Click Element    ${selectors.calculator.clear_button}
    Log    Clicked clear button

Click Equals
    Click Element    ${selectors.calculator.equals_button}
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
    Wait Until Element Is Visible    ${selectors.calculator.display}
    ${actual_value}=    Get Text    ${selectors.calculator.display}
    Should Be Equal As Strings    ${actual_value}    ${expected_value}
    Log    Verified display shows: ${expected_value}

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