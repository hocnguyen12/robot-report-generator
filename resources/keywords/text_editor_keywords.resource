*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Text Editor
    Open Browser    ${app.url}    chrome
    Maximize Browser Window

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
    Wait Until Element Is Visible    ${selectors.text_editor.save_success_message}

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

Clean Up Test Files
    [Arguments]    ${filename}
    # Click delete button if it exists
    ${delete_button_exists}=    Run Keyword And Return Status    Element Should Be Visible    ${selectors.text_editor.delete_button}
    Run Keyword If    ${delete_button_exists}    Click Button    ${selectors.text_editor.delete_button}
    # Wait for confirmation that file is deleted
    Wait Until Element Is Visible    ${selectors.text_editor.delete_success_message}    ${timeouts.element_visible}
    # Verify file is actually deleted from the system
    File Should Not Exist    ${filename}

Close Browser and Stop App
    [Teardown]
    Close Browser
    Log    Closed browser and stopped application
