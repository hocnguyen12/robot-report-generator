*** Settings ***
Library    SeleniumLibrary
Variables    ../resources/variables/app_variables.yaml

*** Test Cases ***
Check Application Is Running
    [Documentation]    Verify that the application is running and accessible
    Open Browser    ${app.url}    chrome
    Page Should Contain    ${selectors.header.title}
    Page Should Contain    ${selectors.header.description}
    [Teardown]    Close Browser 