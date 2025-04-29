*** Settings ***
Resource    ../resources/keywords/todo_keywords.resource
Test Setup    Open Todo Application
Test Teardown    Close Todo Application

*** Test Cases ***
Test Add Todo Functionality
    [Documentation]    Test adding todos
    Add New Todo    Buy groceries
    Verify Todo Exists    Buy groceries
    Add New Todo    Walk the dog
    Verify Todo Exists    Walk the dog
    Add New Todo    Pay bills
    Verify Todo Exists    Pay bills

Test Todo Completion Toggle
    [Documentation]    Test toggling todo completion
    Add New Todo    Exercise
    Verify Todo Not Completed    Exercise
    Toggle Todo    Exercise
    Verify Todo Completed    Exercise
    Toggle Todo    Exercise
    Verify Todo Not Completed    Exercise

Test Delete Todo Functionality
    [Documentation]    Test deleting todos
    Add New Todo    Clean house
    Add New Todo    Do laundry
    Add New Todo    Cook dinner
    Delete Todo    Do laundry
    Verify Todo Does Not Exist    Do laundry
    Verify Todo Exists    Clean house
    Verify Todo Exists    Cook dinner

Test Multiple Operations
    [Documentation]    Test multiple operations
    Add New Todo    Read book
    Add New Todo    Write code
    Toggle Todo    Read book
    Verify Todo Completed    Read book
    Add New Todo    Send email
    Delete Todo    Write code
    Verify Todo Does Not Exist    Write code
    Toggle Todo    Send email
    Verify Todo Completed    Send email

Test Complex Workflow
    [Documentation]    Test complex workflow
    Add New Todo    Meeting prep
    Add New Todo    Client call
    Add New Todo    Report writing
    Toggle Todo    Meeting prep
    Add New Todo    Team sync
    Delete Todo    Client call
    Toggle Todo    Report writing
    Add New Todo    Code review
    Verify Todo Completed    Meeting prep
    Verify Todo Completed    Report writing
    Delete Todo    Team sync
    Toggle Todo    Code review
    Verify Todo Does Not Exist    Client call
    Verify Todo Does Not Exist    Team sync

Test Todo With Special Characters
    [Documentation]    Test todo with special characters
    Add New Todo    Special chars: !@#$%^&*()
    Verify Todo Exists    Special chars: !@#$%^&*()

Test Empty Todo List
    [Documentation]    Test empty todo list
    Verify Todo Is Empty
    Add New Todo    Test item
    Delete Todo    Test item
    Verify Todo Is Empty

Add Single Todo
    Add Todo Item    Buy groceries
    Verify Todo Exists    Buy groceries
    [Teardown]    Close Browser

Add Multiple Todos
    Add Todo Item    First task
    Add Todo Item    Second task
    Add Todo Item    Third task
    ${count}=    Get Todo Count
    Should Be Equal As Numbers    ${count}    3
    [Teardown]    Close Browser

Complete Todo
    Add Todo Item    Complete this task
    Verify Todo Item Is Not Completed    Complete this task
    Toggle Todo Item    Complete this task
    Verify Todo Item Is Completed    Complete this task
    [Teardown]    Close Browser

Delete Todo
    Add Todo Item    Task to delete
    Verify Todo Exists    Task to delete
    Delete Todo Item    Task to delete
    Verify Todo Does Not Exist    Task to delete
    [Teardown]    Close Browser

Toggle Multiple Todos
    Add Todo Item    Task 1
    Add Todo Item    Task 2
    Toggle Todo Item    Task 1
    Toggle Todo Item    Task 2
    Verify Todo Item Is Completed    Task 1
    Verify Todo Item Is Completed    Task 2
    [Teardown]    Close Browser

Complete And Uncomplete Todo
    Add Todo Item    Toggle task
    Toggle Todo Item    Toggle task
    Verify Todo Item Is Completed    Toggle task
    Toggle Todo Item    Toggle task
    Verify Todo Item Is Not Completed    Toggle task
    [Teardown]    Close Browser

Add And Delete Multiple Todos
    Add Todo Item    Task 1
    Add Todo Item    Task 2
    Add Todo Item    Task 3
    Delete Todo Item    Task 2
    Verify Todo Exists    Task 1
    Verify Todo Does Not Exist    Task 2
    Verify Todo Exists    Task 3
    [Teardown]    Close Browser

Add Todo Item
    Add Todo Item    ${test_data.todo_items}[0]
    Verify Todo Exists    ${test_data.todo_items}[0]
    Close Browser and Stop App

Complete Todo Item
    Add Todo Item    ${test_data.todo_items}[1]
    Complete Todo Item    ${test_data.todo_items}[1]
    Verify Todo Completed    ${test_data.todo_items}[1]
    Close Browser and Stop App

Delete Todo Item
    Add Todo Item    ${test_data.todo_items}[2]
    Delete Todo Item    ${test_data.todo_items}[2]
    Verify Todo Not Exists    ${test_data.todo_items}[2]
    Close Browser and Stop App

Multiple Todo Operations
    Add Todo Item    ${test_data.todo_items}[0]
    Add Todo Item    ${test_data.todo_items}[1]
    Add Todo Item    ${test_data.todo_items}[2]
    Complete Todo Item    ${test_data.todo_items}[1]
    Delete Todo Item    ${test_data.todo_items}[0]
    Verify Todo Exists    ${test_data.todo_items}[1]
    Verify Todo Exists    ${test_data.todo_items}[2]
    Verify Todo Completed    ${test_data.todo_items}[1]
    Verify Todo Not Exists    ${test_data.todo_items}[0]
    Close Browser and Stop App

Add Todo Item With Special Characters
    Add Todo Item    ${test_data.todo_items}[3]
    Verify Todo Exists    ${test_data.todo_items}[3]
    Close Browser and Stop App 