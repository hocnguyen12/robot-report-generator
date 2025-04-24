*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Todo Application
    Open Todo List

Close Todo Application
    Close Browser and Stop App

Open Todo List
    Open Browser    ${app.url}    firefox
    Wait Until Page Contains Element    ${selectors.todo_input}    ${timeouts.page_load}
    Log    Opened todo list application

Add New Todo
    [Arguments]    ${todo_text}
    Add Todo Item    ${todo_text}

Add Todo Item
    [Arguments]    ${todo_text}
    Log    Adding todo item: ${todo_text}
    Input Text    ${selectors.todo_input}    ${todo_text}
    Click Button    ${selectors.add_todo_button}
    Wait Until Page Contains    ${todo_text}    ${timeouts.element_visible}

Complete Todo Item
    [Arguments]    ${todo_text}
    Log    Completing todo item: ${todo_text}
    ${selector}=    Replace String    ${selectors.todo_checkbox_for_text}    {0}    ${todo_text}
    ${checkbox}=    Get WebElement    ${selector}
    Select Checkbox    ${checkbox}
    Wait Until Element Is Enabled    ${checkbox}    ${timeouts.element_visible}

Delete Todo Item
    [Arguments]    ${todo_text}
    Log    Deleting todo item: ${todo_text}
    ${selector}=    Replace String    ${selectors.todo_delete_for_text}    {0}    ${todo_text}
    ${delete_button}=    Get WebElement    ${selector}
    Click Element    ${delete_button}
    Wait Until Page Does Not Contain    ${todo_text}    ${timeouts.element_visible}

Delete Todo
    [Arguments]    ${todo_text}
    Delete Todo Item    ${todo_text}

Verify Todo Exists
    [Arguments]    ${todo_text}
    Page Should Contain    ${todo_text}
    Log    Verified todo item exists: ${todo_text}

Verify Todo Not Exists
    [Arguments]    ${todo_text}
    Page Should Not Contain    ${todo_text}
    Log    Verified todo item does not exist: ${todo_text}

Verify Todo Does Not Exist
    [Arguments]    ${todo_text}
    Verify Todo Not Exists    ${todo_text}

Verify Todo Is Empty
    ${count}=    Get Element Count    ${selectors.todo_item}
    Should Be Equal As Numbers    ${count}    0
    Log    Verified todo list is empty

Verify Todo Completed
    [Arguments]    ${todo_text}
    ${selector}=    Replace String    ${selectors.todo_checkbox_for_text}    {0}    ${todo_text}
    ${checkbox}=    Get WebElement    ${selector}
    Checkbox Should Be Selected    ${checkbox}
    Log    Verified todo item is completed: ${todo_text}

Verify Todo Not Completed
    [Arguments]    ${todo_text}
    ${selector}=    Replace String    ${selectors.todo_checkbox_for_text}    {0}    ${todo_text}
    ${checkbox}=    Get WebElement    ${selector}
    Checkbox Should Not Be Selected    ${checkbox}
    Log    Verified todo item is not completed: ${todo_text}

Verify Todo Item Is Completed
    [Arguments]    ${todo_text}
    Verify Todo Completed    ${todo_text}

Verify Todo Item Is Not Completed
    [Arguments]    ${todo_text}
    Verify Todo Not Completed    ${todo_text}

Toggle Todo
    [Arguments]    ${todo_text}
    ${selector}=    Replace String    ${selectors.todo_checkbox_for_text}    {0}    ${todo_text}
    ${checkbox}=    Get WebElement    ${selector}
    Click Element    ${checkbox}
    Log    Toggled todo item: ${todo_text}

Toggle Todo Item
    [Arguments]    ${todo_text}
    Toggle Todo    ${todo_text}

Get Todo Count
    ${count}=    Get Element Count    ${selectors.todo_item}
    RETURN    ${count}

Close Browser and Stop App
    [Teardown]
    Close Browser
    Log    Closed browser and stopped application 