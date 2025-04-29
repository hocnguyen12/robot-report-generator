*** Settings ***
Resource    ../resources/keywords/note_keywords.resource
Test Setup    Open Notes
Test Teardown    Close Browser

*** Test Cases ***
Basic Note Creation
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}

Basic Note Editing
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    Edit Note    ${test_data.initial_note.title}    ${test_data.updated_note.title}    ${test_data.updated_note.content}

Basic Note Deletion
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    Delete Note    ${test_data.initial_note.title}

Complete Note Lifecycle
    Add Note    ${test_data.initial_note.title}    ${test_data.initial_note.content}
    Edit Note    ${test_data.initial_note.title}    ${test_data.updated_note.title}    ${test_data.updated_note.content}
    Delete Note    ${test_data.updated_note.title}

Multiple Notes Management
    Add Note    First Note    First Content
    Add Note    Second Note    Second Content
    Edit Note    First Note    Updated First Note    Updated First Content
    Delete Note    Second Note