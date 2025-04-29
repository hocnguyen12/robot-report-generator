*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Text Editor
    Open Browser    ${app.url}    chrome
    Click Element    ${selectors.header.text_editor_button}
    Wait Until Page Contains Element    ${selectors.text_editor.filename_input}    ${timeouts.page_load}
    Log    Opened Text Editor

Close Text Editor Application
    Close Browser

Set File Name
    [Arguments]    ${filename}
    Input Text    ${selectors.text_editor.filename_input}    ${filename}

Set Content
    [Arguments]    ${content}
    Input Text    ${selectors.text_editor.content_textarea}    ${content}

Save Document
    Click Button    ${selectors.text_editor.save_button}
    # Wait for file download to complete
    Sleep    2s

Delete Document
    Click Button    ${selectors.text_editor.delete_button}
    Wait Until Element Is Visible    ${selectors.text_editor.delete_success_message}

Verify Document Is Saved
    Element Should Be Visible    ${selectors.text_editor.save_success_message}

Verify Document Is Deleted
    Element Should Be Visible    ${selectors.text_editor.delete_success_message}

Create And Save Document
    [Arguments]    ${filename}    ${content}
    Set File Name    ${filename}
    Set Content    ${content}
    Save Document

Get Editor Content
    ${content}=    Get Value    ${selectors.text_editor.content_textarea}
    RETURN    ${content}

Get File Name
    ${filename}=    Get Value    ${selectors.text_editor.filename_input}
    RETURN    ${filename}

Verify File Name Is
    [Arguments]    ${expected}
    ${actual}=    Get File Name
    Should Be Equal    ${actual}    ${expected}

Verify Content Is
    [Arguments]    ${expected}
    ${actual}=    Get Editor Content
    Should Be Equal    ${actual}    ${expected}

Close Browser and Stop App
    [Teardown]
    Close Browser
    Log    Closed browser and stopped application
