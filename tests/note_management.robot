*** Settings ***
Resource    ../resources/keywords/note_keywords.resource
Variables    ../resources/variables/app_variables.yaml

*** Test Cases ***
Basic Note Creation
    Open App In Browser
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    [Teardown]    Close Browser and Stop App

Basic Note Editing
    Open App In Browser
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    Edit Note    ${test_data.initial_note.title}    ${test_data.updated_note.title}    ${test_data.updated_note.content}
    [Teardown]    Close Browser and Stop App

Basic Note Deletion
    Open App In Browser
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    Delete Note    ${test_data.initial_note.title}
    [Teardown]    Close Browser and Stop App

Complete Note Lifecycle
    Open App In Browser
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    Edit Note    ${test_data.initial_note.title}    ${test_data.updated_note.title}    ${test_data.updated_note.content}
    Delete Note    ${test_data.updated_note.title}
    [Teardown]    Close Browser and Stop App

Multiple Notes Management
    Open App In Browser
    Add Note    First Note    First Content
    Add Note    Second Note    Second Content
    Edit Note    First Note    Updated First Note    Updated First Content
    Delete Note    Second Note
    [Teardown]    Close Browser and Stop App 