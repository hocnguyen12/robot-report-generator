*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Notes App
    Open Notes
    Clear All Notes

Open Notes
    Open Browser    ${app.url}    chrome    #options=add_argument("--headless")
    Click Element    ${selectors.header.notes_button}
    Wait Until Element Is Visible    ${selectors.notes.notes_app}    timeout=10s

Add Note
    [Arguments]    ${title}    ${content}
    Log    Adding note with title: ${title}
    Wait Until Element Is Visible    ${selectors.notes.note_title_input}    timeout=10s
    Input Text    ${selectors.notes.note_title_input}    ${title}
    Input Text    ${selectors.notes.note_content_input}    ${content}
    Click Element    ${selectors.notes.add_note_button}
    Run Keyword If    '${title}' != '${EMPTY}'    Wait Until Element Is Visible    xpath=//h3[contains(text(), '${title}')]    timeout=10s

Edit Note
    [Arguments]    ${old_title}    ${new_title}    ${new_content}
    Log    Editing note from '${old_title}' to '${new_title}'
    Click Element    xpath=//h3[contains(text(), '${old_title}')]/ancestor::div[contains(@data-testid, 'note-')]//button[contains(@data-testid, 'edit-note-button-')]
    Wait Until Element Is Visible    ${selectors.notes.note_title_input}    timeout=10s
    Input Text    ${selectors.notes.note_title_input}    ${new_title}
    Input Text    ${selectors.notes.note_content_input}    ${new_content}
    Click Element    ${selectors.notes.update_note_button}
    Run Keyword If    '${new_title}' != '${EMPTY}'    Wait Until Element Is Visible    xpath=//h3[contains(text(), '${new_title}')]    timeout=10s

Delete Note
    [Arguments]    ${title}
    Log    Deleting note: ${title}
    Click Element    xpath=//h3[contains(text(), '${title}')]/ancestor::div[contains(@data-testid, 'note-')]//button[contains(@data-testid, 'delete-note-button-')]
    Wait Until Element Is Not Visible    xpath=//h3[contains(text(), '${title}')]    timeout=10s

Verify Note Exists
    [Arguments]    ${title}    ${content}
    ${note_selector}=    Set Variable If    '${title}' == '${EMPTY}'    xpath=//div[contains(@data-testid, 'note-')][.//p[contains(@data-testid, 'note-content-') and contains(text(), '${content}')]]    xpath=//h3[contains(text(), '${title}')]/ancestor::div[contains(@data-testid, 'note-')]
    Element Should Be Visible    ${note_selector}
    Run Keyword If    '${content}' != '${EMPTY}'    Element Should Be Visible    ${note_selector}//p[contains(@data-testid, 'note-content-') and contains(text(), '${content}')]

Verify Note Does Not Exist
    [Arguments]    ${title}
    Element Should Not Be Visible    xpath=//h3[contains(text(), '${title}')]

Get Note Count
    ${count}=    Get Element Count    xpath=//div[contains(@data-testid, 'note-') and .//h3]
    RETURN    ${count}

Verify Note Count
    [Arguments]    ${expected_count}
    ${actual_count}=    Get Note Count
    Should Be Equal As Numbers    ${actual_count}    ${expected_count}

Clear All Notes
    ${count}=    Get Note Count
    Run Keyword If    ${count} > 0    Delete All Notes    ${count}

Delete All Notes
    [Arguments]    ${count}
    FOR    ${i}    IN RANGE    ${count}
        Click Element    ${selectors.notes.delete_note_button}
    END
    Verify Note Count    0

Verify Note Date Format
    [Arguments]    ${title}
    ${date_text}=    Get Text    xpath=//h3[contains(text(), '${title}')]/ancestor::div[contains(@data-testid, 'note-')]//p[contains(@data-testid, 'note-date-')]
    Should Match Regexp    ${date_text}    \\d{1,2}/\\d{1,2}/\\d{4}, \\d{1,2}:\\d{2}:\\d{2} [AP]M

Verify Note Persistence
    [Arguments]    ${title}    ${content}
    Reload Notes App
    Wait Until Element Is Visible    ${selectors.notes.notes_app}    timeout=10s
    Verify Note Exists    ${title}    ${content}

Reload Notes App
    Reload Page
    Click Element    ${selectors.header.notes_button}