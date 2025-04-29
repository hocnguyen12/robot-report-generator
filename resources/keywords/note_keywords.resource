*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Notes
    Open Browser    ${app.url}    chrome
    Click Element    ${selectors.header.notes_button}
    Wait Until Page Contains Element    ${selectors.notes.note_title_input}
    Log    Opened notes application


Add Note
    [Arguments]    ${title}    ${content}
    Log    Attempting to add note with title: ${title}
    Input Text    ${selectors.notes.note_title_input}    ${title}
    Input Text    ${selectors.notes.note_content_input}    ${content}
    Click Button    ${selectors.notes.add_note_button}
    Wait Until Page Contains    ${title}    ${timeouts.element_visible}

Edit Note
    [Arguments]    ${old_title}    ${new_title}    ${new_content}
    Click Button    ${selectors.notes.edit_button}
    Input Text    ${selectors.notes.note_title_input}    ${new_title}
    Input Text    ${selectors.notes.note_content_input}    ${new_content}
    Click Button    ${selectors.notes.update_note_button}
    Wait Until Page Contains    ${new_title}    ${timeouts.element_visible}

Delete Note
    [Arguments]    ${title}
    Click Button    ${selectors.notes.delete_button}
    Wait Until Page Does Not Contain    ${title}    ${timeouts.element_visible}