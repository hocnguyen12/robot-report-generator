*** Settings ***
Resource    ../resources/keywords/text_editor_keywords.resource
Variables    ../resources/variables/app_variables.yaml

*** Test Cases ***
Default State
    Open Text Editor
    Verify File Name Is    untitled.txt
    Verify Content Is    ${EMPTY}
    [Teardown]    Close Browser

Change File Name
    Open Text Editor
    Set File Name    test_document.txt
    Verify File Name Is    test_document.txt
    [Teardown]    Close Browser

Enter Content
    Open Text Editor
    Set Editor Content    Hello, World!
    Verify Content Is    Hello, World!
    [Teardown]    Close Browser

Create Document With Content
    Open Text Editor
    Create And Save Document    test.txt    This is a test document
    Verify File Name Is    test.txt
    Verify Content Is    This is a test document
    [Teardown]    Close Browser

Edit Existing Content
    Open Text Editor
    Set Editor Content    Initial content
    Verify Content Is    Initial content
    Set Editor Content    Updated content
    Verify Content Is    Updated content
    [Teardown]    Close Browser

Long Document Content
    Open Text Editor
    ${long_text}=    Set Variable    ${\n}Line 1${\n}Line 2${\n}Line 3${\n}Line 4${\n}Line 5
    Set Editor Content    ${long_text}
    Verify Content Is    ${long_text}
    [Teardown]    Close Browser

Special Characters In Content
    Open Text Editor
    ${special_text}=    Set Variable    Special chars: !@#$%^&*()_+-=[]{}|;:'",./<>?
    Set Editor Content    ${special_text}
    Verify Content Is    ${special_text}
    [Teardown]    Close Browser

File Name With Extension Change
    Open Text Editor
    Set File Name    document.txt
    Verify File Name Is    document.txt
    Set File Name    document.md
    Verify File Name Is    document.md
    [Teardown]    Close Browser 