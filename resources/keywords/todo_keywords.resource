*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource    ../variables/app_variables.yaml

*** Keywords ***
Open Todo List
    ${options}=    Create Dictionary    log_level=OFF
    Open Browser    ${url}    firefox    options=${options}
    Wait Until Page Contains Element    ${selectors.todo_input}    ${timeouts.page_load}
    Log    Opened todo list application

Add Todo Item
    [Arguments]    ${todo_text}
    Log    Adding todo item: ${todo_text}
    Input Text    ${selectors.todo_input}    ${todo_text}
    Click Button    ${selectors.add_todo_button}
    Wait Until Page Contains    ${todo_text}    ${timeouts.element_visible}

Complete Todo Item
    [Arguments]    ${todo_text}
    Log    Completing todo item: ${todo_text}
    Click Element    ${selectors.todo_complete_button}    ${todo_text}
    Wait Until Element Contains    ${selectors.todo_completed}    ${todo_text}    ${timeouts.element_visible}

Delete Todo Item
    [Arguments]    ${todo_text}
    Log    Deleting todo item: ${todo_text}
    Click Element    ${selectors.todo_delete_button}    ${todo_text}
    Wait Until Page Does Not Contain    ${todo_text}    ${timeouts.element_visible}

Verify Todo Exists
    [Arguments]    ${todo_text}
    Page Should Contain    ${todo_text}
    Log    Verified todo item exists: ${todo_text}

Verify Todo Not Exists
    [Arguments]    ${todo_text}
    Page Should Not Contain    ${todo_text}
    Log    Verified todo item does not exist: ${todo_text}

Verify Todo Completed
    [Arguments]    ${todo_text}
    Element Should Contain    ${selectors.todo_completed}    ${todo_text}
    Log    Verified todo item is completed: ${todo_text}

Close Browser and Stop App
    Close Browser
    Log    Closed browser and stopped application

Get Todo Count
    ${count}=    Get Element Count    ${selectors.todo_item}
    RETURN    ${count} 