*** Settings ***
Documentation     Common keywords for the application
Variables         ../variables/app_variables.yaml
Library           SeleniumLibrary

*** Keywords ***
Login To Application
    [Documentation]    Logs in to the application using test credentials
    [Arguments]    ${email}=${credentials.email}    ${password}=${credentials.password}
    
    # Navigate to login page
    Go To    ${app.url}/login
    
    # Wait for and fill in login form
    Wait Until Element Is Visible    ${auth.email_input}
    Input Text    ${auth.email_input}    ${email}
    Input Text    ${auth.password_input}    ${password}
    
    # Submit login form
    Click Element    ${auth.submit_button}
    
    # Check for error messages
    
    ${has_console_error}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    ${auth.console_error}    timeout=1s
    
    
    IF    ${has_console_error}
        ${console_error_text}=    Get Text    ${auth.console_error}
        Fail    Console error occurred: ${console_error_text}
    END
    
    # Wait for successful login
    Wait Until Element Is Visible    ${auth.user_email}    timeout=10s
    Element Should Contain    ${auth.user_email}    ${email}

Logout From Application
    [Documentation]    Logs out from the application
    
    # Click logout button
    Click Element    ${auth.logout_button}
    
    # Wait for successful logout (redirected to login page)
    Wait Until Element Is Visible    ${auth.email_input}

Ensure Logged In
    [Documentation]    Ensures user is logged in, logs in if not
    [Arguments]    ${email}=${credentials.email}    ${password}=${credentials.password}
    
    ${is_logged_in}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    ${auth.user_email}    timeout=1s
    
    IF    not ${is_logged_in}
        Login To Application    ${email}    ${password}
    END

Ensure Logged Out
    [Documentation]    Ensures user is logged out, logs out if not
    
    ${is_logged_in}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    ${auth.user_email}    timeout=1s
    
    IF    ${is_logged_in}
        Logout From Application
    END

Close App
    Logout From Application
    Ensure Logged Out
    Close Browser