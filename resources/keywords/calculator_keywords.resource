*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CALCULATOR_INPUT}    css=[data-testid="calculator-input"]
${CALCULATOR_BUTTON}    css=[data-testid="calculate-button"]
${CALCULATOR_RESULT}    css=[data-testid="calculator-result"]

*** Keywords ***
Open Calculator
    Open Browser    ${app.url}    firefox
    Wait Until Element Is Visible    ${CALCULATOR_INPUT}

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

Close Calculator
    Close Browser 