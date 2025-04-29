*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Notes App
    Open Notes
    Clear All Notes

Open Notes
    Open Browser    ${app.url}    chrome
    Click Element    ${selectors.header.notes_button}
    Wait Until Element Is Visible    ${selectors.notes.notes_app}

Add Note
    [Arguments]    ${title}    ${content}
    Log    Adding note with title: ${title}
    Input Text    ${selectors.notes.note_title_input}    ${title}
    Input Text    ${selectors.notes.note_content_input}    ${content}
    Click Element    ${selectors.notes.add_note_button}
    Wait Until Element Is Visible    xpath=//h3[contains(text(), '${title}')]

Edit Note
    [Arguments]    ${old_title}    ${new_title}    ${new_content}
    Log    Editing note from '${old_title}' to '${new_title}'
    Click Element    xpath=//h3[contains(text(), '${old_title}')]/ancestor::div[contains(@data-testid, 'note-')]//button[contains(@data-testid, 'edit-note-button-')]
    Input Text    ${selectors.notes.note_title_input}    ${new_title}
    Input Text    ${selectors.notes.note_content_input}    ${new_content}
    Click Element    ${selectors.notes.update_note_button}
    Wait Until Element Is Visible    xpath=//h3[contains(text(), '${new_title}')]

Delete Note
    [Arguments]    ${title}
    Log    Deleting note: ${title}
    Click Element    xpath=//h3[contains(text(), '${title}')]/ancestor::div[contains(@data-testid, 'note-')]//button[contains(@data-testid, 'delete-note-button-')]
    Wait Until Element Is Not Visible    xpath=//h3[contains(text(), '${title}')]

Verify Note Exists
    [Arguments]    ${title}    ${content}
    Element Should Be Visible    xpath=//h3[contains(text(), '${title}')]
    Element Should Be Visible    xpath=//p[contains(text(), '${content}')]

Verify Note Does Not Exist
    [Arguments]    ${title}
    Element Should Not Be Visible    xpath=//h3[contains(text(), '${title}')]

Get Note Count
    ${count}=    Get Element Count    ${selectors.notes.note_item}
    RETURN    ${count}

Verify Note Count
    [Arguments]    ${expected_count}
    ${actual_count}=    Get Note Count
    Should Be Equal As Numbers    ${actual_count}    ${expected_count}

Clear All Notes
    ${count}=    Get Note Count
    FOR    ${i}    IN RANGE    ${count}
        Click Element    ${selectors.notes.delete_note_button}
        Sleep    1s
    END
    Verify Note Count    0

Verify Note Date Format
    [Arguments]    ${title}
    ${date_text}=    Get Text    xpath=//h3[contains(text(), '${title}')]/ancestor::div[contains(@data-testid, 'note-')]//span[contains(@data-testid, 'note-date-')]
    Should Match Regexp    ${date_text}    \\d{1,2}/\\d{1,2}/\\d{4}, \\d{1,2}:\\d{2} [AP]M

Verify Note Persistence
    [Arguments]    ${title}    ${content}
    Reload Page
    Wait Until Element Is Visible    ${selectors.notes.notes_app}
    Verify Note Exists    ${title}    ${content}