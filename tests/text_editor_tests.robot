*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/keywords/text_editor_keywords.resource
Test Setup    Open Text Editor
Test Teardown    Close Text Editor Application

*** Test Cases ***
Create And Save New Document
    [Documentation]    Test creating and saving a new document
    Create And Save Document    ${test_data.text_editor.test_document.filename}    ${test_data.text_editor.test_document.content}
    Verify File Name Is    ${test_data.text_editor.test_document.filename}
    Verify Content Is    ${test_data.text_editor.test_document.content}

Edit Existing Document
    [Documentation]    Test editing an existing document
    Create And Save Document    ${test_data.text_editor.editable_document.filename}    ${test_data.text_editor.editable_document.initial_content}
    Set Content    ${test_data.text_editor.editable_document.updated_content}
    Save Document
    Verify Content Is    ${test_data.text_editor.editable_document.updated_content}

Clear Editor Content
    [Documentation]    Test clearing the editor content
    Set Content    Some test content
    Clear Editor
    Verify Editor Is Cleared

Clear Empty Editor
    [Documentation]    Test clearing an empty editor
    Clear Editor
    Verify Editor Is Cleared

Clear And Save Document
    [Documentation]    Test clearing and then saving a document
    Set Content    Initial content
    Clear Editor
    Verify Editor Is Cleared
    Save Document
    Verify Content Is    ${EMPTY}

Save Document With Special Characters
    [Documentation]    Test saving document with special characters
    ${special_content}=    Set Variable    Content with special chars: !@#$%^&*()_+
    Create And Save Document    special_chars.txt    ${special_content}
    Verify Content Is    ${special_content}

Save Document With Long Content
    [Documentation]    Test saving document with long content
    ${long_content}=    Set Variable    This is a very long content that spans multiple lines.\nLine 2\nLine 3\nLine 4\nLine 5
    Create And Save Document    long_content.txt    ${long_content}
    Verify Content Is    ${long_content}

Save Document With Empty Content
    [Documentation]    Test saving document with empty content
    Create And Save Document    empty_content.txt    ${EMPTY}
    Verify Content Is    ${EMPTY}

Save Document With Whitespace
    [Documentation]    Test saving document with whitespace
    ${whitespace_content}=    Set Variable    Content with multiple spaces
    Create And Save Document    whitespace.txt    ${whitespace_content}
    Verify Content Is    ${whitespace_content}

Save Document With Line Breaks
    [Documentation]    Test saving document with line breaks
    ${line_break_content}=    Set Variable    First line\nSecond line\nThird line
    Create And Save Document    line_breaks.txt    ${line_break_content}
    Verify Content Is    ${line_break_content}

Save Document With Unicode Characters
    [Documentation]    Test saving document with unicode characters
    ${unicode_content}=    Set Variable    Unicode characters: éèêëñüß
    Create And Save Document    unicode.txt    ${unicode_content}
    Verify Content Is    ${unicode_content}

Save Document With HTML Content
    [Documentation]    Test saving document with HTML content
    ${html_content}=    Set Variable    <html><body><h1>Test</h1></body></html>
    Create And Save Document    html.txt    ${html_content}
    Verify Content Is    ${html_content}

Save Document With JavaScript Content
    [Documentation]    Test saving document with JavaScript content
    ${js_content}=    Set Variable    function test() { console.log('test'); }
    Create And Save Document    script.js    ${js_content}
    Verify Content Is    ${js_content}

Save Document With SQL Content
    [Documentation]    Test saving document with SQL content
    ${sql_content}=    Set Variable    SELECT * FROM users WHERE id = 1;
    Create And Save Document    query.sql    ${sql_content}
    Verify Content Is    ${sql_content}

Save Document With Markdown Content
    [Documentation]    Test saving document with Markdown content
    ${markdown_content}=    Set Variable    # Heading\n\n- List item 1\n- List item 2
    Create And Save Document    markdown.md    ${markdown_content}
    Verify Content Is    ${markdown_content}

Save Document With JSON Content
    [Documentation]    Test saving document with JSON content
    ${json_content}=    Set Variable    {"name": "test", "value": 123}
    Create And Save Document    data.json    ${json_content}
    Verify Content Is    ${json_content}

Save Document With XML Content
    [Documentation]    Test saving document with XML content
    ${xml_content}=    Set Variable    <config><setting>value</setting></config>
    Create And Save Document    config.xml    ${xml_content}
    Verify Content Is    ${xml_content}

Save Document With YAML Content
    [Documentation]    Test saving document with YAML content
    ${yaml_content}=    Catenate    SEPARATOR=\n
    ...    key: value
    ...    list:
    ...      - item1
    ...      - item2
    Create And Save Document    config.yaml    ${yaml_content}
    Verify Content Is    ${yaml_content}

Save Document With CSV Content
    [Documentation]    Test saving document with CSV content
    ${csv_content}=    Set Variable    name,age,email\nJohn,30,john@example.com
    Create And Save Document    data.csv    ${csv_content}
    Verify Content Is    ${csv_content}

Save Document With Multiple Saves
    [Documentation]    Test saving document multiple times
    Create And Save Document    multiple_saves.txt    First save
    Verify Content Is    First save
    Set Content    Second save
    Save Document
    Verify Content Is    Second save
    Set Content    Third save
    Save Document
    Verify Content Is    Third save