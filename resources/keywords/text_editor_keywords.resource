*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    ../variables/app_variables.yaml

*** Keywords ***
Open Text Editor
    # Variable passed from `run_tests.sh`
    Log       Download Directory : ${DOWNLOAD_DIR}

    # Change default download directory
    VAR    &{browser_prefs}    download.default_directory=${DOWNLOAD_DIR}    plugins.always_open_pdf_externally=${True}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${browser_prefs}

    Open Browser    ${app.url}    chrome    options=${chrome_options} 
    Click Element    ${selectors.header.text_editor_button}
    Wait Until Page Contains Element    ${selectors.text_editor.filename_input}    ${timeouts.page_load}
    Log    Opened Text Editor

Close Text Editor Application
    Close Browser

Set File Name
    [Arguments]    ${filename}
    Input Text    ${selectors.text_editor.filename_input}    ${filename}

Set Content
    [Arguments]    ${content}
    Input Text    ${selectors.text_editor.content_textarea}    ${content}

Save Document
    [Documentation]    Saves the document and verifies the download was triggered
    # Get the current content and filename
    ${content}=    Get Editor Content
    ${filename}=    Get File Name
    
    # Click the save button
    Click Button    ${selectors.text_editor.save_button}
    
    # Wait for success message
    Wait Until Element Is Visible    ${selectors.text_editor.save_success_message}    ${timeouts.element_visible}
    
    # Wait for file download to complete
    Wait Until Created    ${DOWNLOAD_DIR}/${filename}    timeout=5s
    Log    File downloaded to ${DOWNLOAD_DIR}/${filename}

Clear Editor
    [Documentation]    Clears the editor content
    Click Button    ${selectors.text_editor.clear_button}
    Wait Until Element Is Visible    ${selectors.text_editor.clear_success_message}    ${timeouts.element_visible}

Verify Editor Is Cleared
    ${content}=    Get Editor Content
    Should Be Empty    ${content}    Editor content should be empty
    Element Should Be Visible    ${selectors.text_editor.clear_success_message}

Create And Save Document
    [Arguments]    ${filename}    ${content}
    Set File Name    ${filename}
    Set Content    ${content}
    Save Document

Get Editor Content
    ${content}=    Get Value    ${selectors.text_editor.content_textarea}
    RETURN    ${content}

Get File Name
    ${filename}=    Get Value    ${selectors.text_editor.filename_input}
    RETURN    ${filename}

Verify File Name Is
    [Arguments]    ${expected}
    ${actual}=    Get File Name
    Should Be Equal    ${actual}    ${expected}

Verify Content Is
    [Arguments]    ${expected}
    ${actual}=    Get Editor Content
    Should Be Equal    ${actual}    ${expected}

Close Browser and Stop App
    [Teardown]
    Close Browser
    Log    Closed browser and stopped application
