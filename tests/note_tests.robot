*** Settings ***
Resource    ../resources/keywords/note_keywords.resource
Test Setup    Open Notes App
Test Teardown    Close Browser

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
    [Documentation]    Test creating a note with empty title
    Add Note    ${EMPTY}    Content without title
    Verify Note Exists    ${EMPTY}    Content without title
    Verify Note Persistence    ${EMPTY}    Content without title

Empty Note Content
    [Documentation]    Test creating a note with empty content
    Add Note    Empty Content Note    ${EMPTY}
    Verify Note Exists    Empty Content Note    ${EMPTY}
    Verify Note Persistence    Empty Content Note    ${EMPTY}

Note With Line Breaks
    [Documentation]    Test creating a note with line breaks
    ${content_with_breaks}=    Set Variable    Line 1\nLine 2\nLine 3
    Add Note    Multi-line Note    ${content_with_breaks}
    Verify Note Exists    Multi-line Note    ${content_with_breaks}
    Verify Note Persistence    Multi-line Note    ${content_with_breaks}

Note With Unicode Characters
    [Documentation]    Test creating a note with Unicode characters
    Add Note    Unicode Note    This note contains Unicode characters: 你好世界
    Verify Note Exists    Unicode Note    This note contains Unicode characters: 你好世界
    Verify Note Persistence    Unicode Note    This note contains Unicode characters: 你好世界 