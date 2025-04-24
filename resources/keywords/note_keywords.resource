*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
Open App In Browser
    Log    Opening browser to URL: ${app.url}
    Open Browser    ${app.url}    firefox
    Set Selenium Timeout    ${timeouts.selenium_timeout}
    
    # Log the page title for debugging
    ${title}=    Get Title
    Log    Page title: ${title}
    
    # Try to find the element and log its presence
    ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    ${selectors.note_title_input}
    Log    Element present: ${element_present}
    
    # If element is not found, log the page source
    Run Keyword If    not ${element_present}    Log Source
    
    Wait Until Page Contains Element    ${selectors.note_title_input}    ${timeouts.selenium_timeout}

Add Note
    [Arguments]    ${title}    ${content}
    Log    Attempting to add note with title: ${title}
    Input Text    ${selectors.note_title_input}    ${title}
    Input Text    ${selectors.note_content_textarea}    ${content}
    Click Button    ${selectors.add_note_button}
    Wait Until Page Contains    ${title}    ${timeouts.element_wait}

Edit Note
    [Arguments]    ${old_title}    ${new_title}    ${new_content}
    Click Button    ${selectors.edit_button}
    Input Text    ${selectors.note_title_input}    ${new_title}
    Input Text    ${selectors.note_content_textarea}    ${new_content}
    Click Button    ${selectors.update_note_button}
    Wait Until Page Contains    ${new_title}    ${timeouts.element_wait}

Delete Note
    [Arguments]    ${title}
    Click Button    ${selectors.delete_button}
    Wait Until Page Does Not Contain    ${title}    ${timeouts.element_wait}

Close Browser and Stop App
    Close Browser 