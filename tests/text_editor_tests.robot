*** Settings ***
Resource    ../resources/keywords/text_editor_keywords.resource
Resource    ../resources/keywords/common_keywords.resource
Test Setup    Open Text Editor
Test Teardown    Close Text Editor Application

*** Test Cases ***
Create And Save Document
    Create And Save Document    test_document.txt    This is a test document
    Verify Document Is Saved    test_document.txt    This is a test document
    Clean Up Test Files    test_document.txt

Edit And Save Document
    Create And Save Document    edit_test.txt    Initial content
    Verify Document Is Saved    edit_test.txt    Initial content
    Set Editor Content    Updated content
    Click Save Button
    Verify Document Is Saved    edit_test.txt    Updated content
    Clean Up Test Files    edit_test.txt

Save Document With Special Characters
    Create And Save Document    special_chars.txt    Content with special chars: !@#$%^&*()_+
    Verify Document Is Saved    special_chars.txt    Content with special chars: !@#$%^&*()_+
    Clean Up Test Files    special_chars.txt

Save Document With Long Content
    ${long_content}=    Set Variable    This is a very long content that spans multiple lines.\nLine 2\nLine 3\nLine 4\nLine 5
    Create And Save Document    long_content.txt    ${long_content}
    Verify Document Is Saved    long_content.txt    ${long_content}
    Clean Up Test Files    long_content.txt

Save Document With Empty Content
    Create And Save Document    empty_content.txt    ${EMPTY}
    Verify Document Is Saved    empty_content.txt    ${EMPTY}
    Clean Up Test Files    empty_content.txt

Save Document With Whitespace
    Create And Save Document    whitespace.txt    Content with    multiple    spaces
    Verify Document Is Saved    whitespace.txt    Content with    multiple    spaces
    Clean Up Test Files    whitespace.txt

Save Document With Line Breaks
    Create And Save Document    line_breaks.txt    First line\nSecond line\nThird line
    Verify Document Is Saved    line_breaks.txt    First line\nSecond line\nThird line
    Clean Up Test Files    line_breaks.txt

Save Document With Unicode Characters
    Create And Save Document    unicode.txt    Unicode characters: éèêëñüß
    Verify Document Is Saved    unicode.txt    Unicode characters: éèêëñüß
    Clean Up Test Files    unicode.txt

Save Document With HTML Content
    Create And Save Document    html.txt    <html><body><h1>Test</h1></body></html>
    Verify Document Is Saved    html.txt    <html><body><h1>Test</h1></body></html>
    Clean Up Test Files    html.txt

Save Document With JavaScript Content
    Create And Save Document    script.js    function test() { console.log('test'); }
    Verify Document Is Saved    script.js    function test() { console.log('test'); }
    Clean Up Test Files    script.js

Save Document With SQL Content
    Create And Save Document    query.sql    SELECT * FROM users WHERE id = 1;
    Verify Document Is Saved    query.sql    SELECT * FROM users WHERE id = 1;
    Clean Up Test Files    query.sql

Save Document With Markdown Content
    Create And Save Document    markdown.md    # Heading\n\n- List item 1\n- List item 2
    Verify Document Is Saved    markdown.md    # Heading\n\n- List item 1\n- List item 2
    Clean Up Test Files    markdown.md

Save Document With JSON Content
    Create And Save Document    data.json    {"name": "test", "value": 123}
    Verify Document Is Saved    data.json    {"name": "test", "value": 123}
    Clean Up Test Files    data.json

Save Document With XML Content
    Create And Save Document    config.xml    <config><setting>value</setting></config>
    Verify Document Is Saved    config.xml    <config><setting>value</setting></config>
    Clean Up Test Files    config.xml

Save Document With YAML Content
    Create And Save Document    config.yaml    key: value\nlist:\n  - item1\n  - item2
    Verify Document Is Saved    config.yaml    key: value\nlist:\n  - item1\n  - item2
    Clean Up Test Files    config.yaml

Save Document With CSV Content
    Create And Save Document    data.csv    name,age,email\nJohn,30,john@example.com
    Verify Document Is Saved    data.csv    name,age,email\nJohn,30,john@example.com
    Clean Up Test Files    data.csv

Save Document With Multiple Saves
    Create And Save Document    multiple_saves.txt    First save
    Verify Document Is Saved    multiple_saves.txt    First save
    Set Editor Content    Second save
    Click Save Button
    Verify Document Is Saved    multiple_saves.txt    Second save
    Set Editor Content    Third save
    Click Save Button
    Verify Document Is Saved    multiple_saves.txt    Third save
    Clean Up Test Files    multiple_saves.txt