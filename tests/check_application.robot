*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/keywords/text_editor_keywords.resource
Variables    ../resources/variables/app_variables.yaml

*** Test Cases ***
Check Application Is Running
    [Documentation]    Verify that the application is running and accessible
    Open Browser    ${app.url}    chrome
    Page Should Contain    Text Editor
    Page Should Contain Element    ${selectors.text_editor.filename_input}
    Page Should Contain Element    ${selectors.text_editor.content_textarea}
    Page Should Contain Element    ${selectors.text_editor.save_button}
    Page Should Contain Element    ${selectors.text_editor.delete_button}
    [Teardown]    Close Browser 