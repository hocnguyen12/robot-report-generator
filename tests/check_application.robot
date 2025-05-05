*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/keywords/common_keywords.resource
Variables    ../resources/variables/app_variables.yaml

*** Test Cases ***
Check Application Is Running
    [Documentation]    Verify that the application is running and accessible
    Open Browser    ${app.url}    chrome
    Login To Application
    Ensure Logged In
    Page Should Contain    ${selectors.header.title}
    Page Should Contain    ${selectors.header.description}
    [Teardown]    Close App