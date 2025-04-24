*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${FILENAME_INPUT}    css=input[placeholder='Enter file name']
${CONTENT_TEXTAREA}    css=textarea[placeholder='Start typing...']
${SAVE_BUTTON}    //button[contains(., 'Save')]

*** Keywords ***
Open Text Editor
    Open Browser    ${app.url}    firefox
    Wait Until Element Is Visible    ${FILENAME_INPUT}

Set File Name
    [Arguments]    ${filename}
    Input Text    ${FILENAME_INPUT}    ${filename}

Set Editor Content
    [Arguments]    ${content}
    Input Text    ${CONTENT_TEXTAREA}    ${content}

Get Editor Content
    ${content}=    Get Value    ${CONTENT_TEXTAREA}
    [Return]    ${content}

Get File Name
    ${filename}=    Get Value    ${FILENAME_INPUT}
    [Return]    ${filename}

Click Save Button
    Click Button    ${SAVE_BUTTON}

Verify File Name Is
    [Arguments]    ${expected}
    ${actual}=    Get File Name
    Should Be Equal    ${actual}    ${expected}

Verify Content Is
    [Arguments]    ${expected}
    ${actual}=    Get Editor Content
    Should Be Equal    ${actual}    ${expected}

Create And Save Document
    [Arguments]    ${filename}    ${content}
    Set File Name    ${filename}
    Set Editor Content    ${content}
    Click Save Button 