*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Text Editor
    Open Browser    ${app.url}    firefox
    Click Element    xpath=//button[contains(text(), 'Text Editor')]
    Wait Until Element Is Visible    ${selectors.FILENAME_INPUT}    ${timeouts.element_visible}

Close Text Editor Application
    Close Browser and Stop App

Set File Name
    [Arguments]    ${filename}
    Input Text    ${selectors.FILENAME_INPUT}    ${filename}

Set Editor Content
    [Arguments]    ${content}
    Input Text    ${selectors.CONTENT_TEXTAREA}    ${content}

Get Editor Content
    ${content}=    Get Value    ${selectors.CONTENT_TEXTAREA}
    RETURN    ${content}

Get File Name
    ${filename}=    Get Value    ${selectors.FILENAME_INPUT}
    RETURN    ${filename}

Click Save Button
    Click Button    ${selectors.SAVE_BUTTON}

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

Verify Document Is Saved
    [Arguments]    ${filename}    ${expected_content}
    # Wait for success message
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'File saved successfully')]    ${timeouts.element_visible}
    # Verify the content is still present in the editor
    Verify Content Is    ${expected_content}
    # Verify the filename is still present
    Verify File Name Is    ${filename}
    # Verify file exists in the system
    File Should Exist    ${filename}
    # Verify file content matches expected content
    ${file_content}=    Get File    ${filename}
    Should Be Equal    ${file_content}    ${expected_content}

Clean Up Test Files
    [Arguments]    ${filename}
    # Click delete button if it exists
    ${delete_button_exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//button[contains(text(), 'Delete')]
    Run Keyword If    ${delete_button_exists}    Click Button    xpath=//button[contains(text(), 'Delete')]
    # Wait for confirmation that file is deleted
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'File deleted successfully')]    ${timeouts.element_visible}
    # Verify file is actually deleted from the system
    File Should Not Exist    ${filename}

Close Browser and Stop App
    [Teardown]
    Close Browser
    Log    Closed browser and stopped application
