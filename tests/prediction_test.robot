*** Settings ***
Resource    ../resources/keywords/note_keywords.resource
Test Setup    Open Notes App
Test Teardown    Close Notes App


*** Test Cases ***
Test If Predictions Work
    [Documentation]    This is a test to see if predictions are correct with basic classification
    Add Note    Test Note    This is a test note
    Verify Note Exists    Test Note    This is a test note
    Verify Note Date Format    Test Note
    Verify Note Persistence    Test Note    This is a test note
    Verify Note Count    1