*** Settings ***
Resource    ../resources/keywords/todo_keywords.resource
Resource    ../resources/variables/app_variables.yaml

*** Test Cases ***
Add Todo Item
    Open Todo List
    Add Todo Item    Buy groceries
    Verify Todo Exists    Buy groceries

Complete Todo Item
    Open Todo List
    Add Todo Item    Buy groceries
    Complete Todo Item    Buy groceries
    Verify Todo Completed    Buy groceries

Delete Todo Item
    Open Todo List
    Add Todo Item    Buy groceries
    Delete Todo Item    Buy groceries
    Verify Todo Not Exists    Buy groceries

Multiple Todo Items
    Open Todo List
    Add Todo Item    Buy groceries
    Add Todo Item    Walk the dog
    Add Todo Item    Call mom
    ${count}=    Get Todo Count
    Should Be Equal As Numbers    ${count}    3

    [Teardown]    Close Browser 