*** Settings ***
Resource    ../resources/keywords/note_keywords.resource
Test Setup    Open Notes App
Test Teardown    Close Notes App

*** Test Cases ***
Create And Save Note
    [Documentation]    Test creating and saving a new note
    Add Note    Test Note    This is a test note
    Verify Note Exists    Test Note    This is a test note
    Verify Note Date Format    Test Note
    Verify Note Persistence    Test Note    This is a test note

Edit Existing Note
    [Documentation]    Test editing an existing note
    Add Note    Original Note    Original content
    Edit Note    Original Note    Updated Note    Updated content
    Verify Note Exists    Updated Note    Updated content
    Verify Note Persistence    Updated Note    Updated content

Delete Note
    [Documentation]    Test deleting a note
    Add Note    To Delete    This note will be deleted
    Delete Note    To Delete
    Verify Note Does Not Exist    To Delete
    Verify Note Count    0

Multiple Notes
    [Documentation]    Test creating and managing multiple notes
    Add Note    Note 1    Content 1
    Add Note    Note 2    Content 2
    Add Note    Note 3    Content 3
    Verify Note Count    3
    Delete Note    Note 2
    Verify Note Count    2
    Verify Note Exists    Note 1    Content 1
    Verify Note Exists    Note 3    Content 3

Note With Special Characters
    [Documentation]    Test creating a note with special characters
    Add Note    Special !@#$%^&*() Note    Content with special characters: !@#$%^&*()
    Verify Note Exists    Special !@#$%^&*() Note    Content with special characters: !@#$%^&*()
    Verify Note Persistence    Special !@#$%^&*() Note    Content with special characters: !@#$%^&*()

Long Note Content
    [Documentation]    Test creating a note with long content
    ${long_content}=    Set Variable    This is a very long note content that spans multiple lines and contains a lot of text. It should be properly saved and displayed in the notes application. The content should be preserved exactly as entered, including all spaces and line breaks.
    Add Note    Long Note    ${long_content}
    Verify Note Exists    Long Note    ${long_content}
    Verify Note Persistence    Long Note    ${long_content}

Empty Note Title
    [Documentation]    Test that note with empty title is not created
    ${initial_count}=    Get Note Count
    Add Note    ${EMPTY}    Content without title
    ${final_count}=    Get Note Count
    Should Be Equal As Numbers    ${initial_count}    ${final_count}

Empty Note Content
    [Documentation]    Test that note with empty content is not created
    ${initial_count}=    Get Note Count
    Add Note    Empty Content Note    ${EMPTY}
    ${final_count}=    Get Note Count
    Should Be Equal As Numbers    ${initial_count}    ${final_count}

Empty Title And Content
    [Documentation]    Test that note with both empty title and content is not created
    ${initial_count}=    Get Note Count
    Add Note    ${EMPTY}    ${EMPTY}
    ${final_count}=    Get Note Count
    Should Be Equal As Numbers    ${initial_count}    ${final_count}

Note With Line Breaks
    [Documentation]    Test creating a note with line breaks
    ${content_with_breaks}=    Catenate    SEPARATOR=\n    Line 1    Line 2    Line 3
    Add Note    Multi-line Note    ${content_with_breaks}
    Verify Note Exists    Multi-line Note    ${content_with_breaks}
    Verify Note Persistence    Multi-line Note    ${content_with_breaks}

Note With Unicode Characters
    [Documentation]    Test creating a note with Unicode characters
    Add Note    Unicode Note    This note contains Unicode characters: 你好世界
    Verify Note Exists    Unicode Note    This note contains Unicode characters: 你好世界
    Verify Note Persistence    Unicode Note    This note contains Unicode characters: 你好世界

Edit With Empty Fields
    [Documentation]    Test that editing a note with empty fields is not allowed
    Add Note    Original Note    Original content
    ${initial_count}=    Get Note Count
    Edit Note    Original Note    ${EMPTY}    Updated content
    ${final_count}=    Get Note Count
    Should Be Equal As Numbers    ${initial_count}    ${final_count}
    Verify Note Exists    Original Note    Original content

Whitespace Only Inputs
    [Documentation]    Test that notes with only whitespace are not created
    ${initial_count}=    Get Note Count
    Add Note    ${SPACE}${SPACE}${SPACE}    ${SPACE}${SPACE}${SPACE}
    ${final_count}=    Get Note Count
    Should Be Equal As Numbers    ${initial_count}    ${final_count}

Note Ordering
    [Documentation]    Test that notes are displayed in chronological order (newest first)
    Add Note    First Note    First content
    Sleep    1s
    Add Note    Second Note    Second content
    ${first_note_date}=    Get Text    xpath=//h3[contains(text(), 'First Note')]/ancestor::div[contains(@data-testid, 'note-')]//p[contains(@data-testid, 'note-date-')]
    ${second_note_date}=    Get Text    xpath=//h3[contains(text(), 'Second Note')]/ancestor::div[contains(@data-testid, 'note-')]//p[contains(@data-testid, 'note-date-')]
    Should Be True    '${second_note_date}' > '${first_note_date}'

Multiple Edits
    [Documentation]    Test multiple edits of the same note
    Add Note    Test Note    Initial content
    Edit Note    Test Note    Test Note    First edit
    Verify Note Exists    Test Note    First edit
    Edit Note    Test Note    Test Note    Second edit
    Verify Note Exists    Test Note    Second edit
    Edit Note    Test Note    Test Note    Final edit
    Verify Note Exists    Test Note    Final edit
    Verify Note Persistence    Test Note    Final edit

Rapid Note Operations
    [Documentation]    Test rapid creation and deletion of notes
    FOR    ${i}    IN RANGE    5
        Add Note    Note ${i}    Content ${i}
        Verify Note Exists    Note ${i}    Content ${i}
        Delete Note    Note ${i}
        Verify Note Does Not Exist    Note ${i}
    END
    Verify Note Count    0

Browser Refresh Behavior
    [Documentation]    Test that notes persist after multiple browser refreshes
    Add Note    Persistence Test    This note should persist
    FOR    ${i}    IN RANGE    3
        Reload Notes App
        Verify Note Exists    Persistence Test    This note should persist
    END 

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