*** Settings ***
Documentation   Tests automatisés pour la réinitialisation de son mot de passe
Library         SeleniumLibrary     run_on_failure=NOTHING
Library         Collections
Library         String
Library         DateTime
Resource        login.resource
Resource        ../main.resource
Variables       ../presets.py
Variables       reset_variables.py
Variables       reset_xpaths.py
Suite Setup     Open Browser And Maximize    ${url}  ${browser}
Suite Teardown  Pause And Close Browser

*** Variables ***
${url}          ${BASE_URL}/app/auth/reset
${browser}      Chrome

*** Test Cases ***
Check Webpage Title
	[Tags]    robot:recursive-continue-on-failure
	Title Should Be    ${WEBPAGE_TITLE}

Check Background Image
	[Tags]    robot:recursive-continue-on-failure
	Background Image Should Be    ${BACKGROUND_IMAGE_SRC}

Check Logo
	[Tags]    robot:recursive-continue-on-failure
	Check Image Is Visible   ${LOGO_XPATH}   ${LOGO_SRC}

Check Message
	[Tags]    robot:recursive-continue-on-failure
	Element Text Should Be      ${MESSAGE_XPATH}    ${MESSAGE}

Check Presence of Input(s)
	[Tags]    robot:recursive-continue-on-failure   Smoke
    Page Should Contain Element    ${EMAIL_FIELD_XPATH}
    Element Should Be Enabled      ${EMAIL_FIELD_XPATH}

Check Placeholder(s)
	[Tags]    robot:recursive-continue-on-failure
	Placeholder Should Be   ${EMAIL_FIELD_XPATH}    ${EMAIL_FIELD_PLACEHOLDER}

Check Button(s)
	[Tags]    robot:recursive-continue-on-failure   Smoke
	Page Should Contain Element    xpath://*/button[contains(text(),"${CANCEL_BUTTON_TEXT}")]
	Page Should Contain Element    xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]

Check No Email Error Message
	[Tags]    robot:recursive-continue-on-failure
    Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Click Button                        xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Check Error Message                 ${NO_EMAIL_TEXT}

Check Ivalid Email Error Message
	[Tags]    robot:recursive-continue-on-failure
	Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Input Text                          ${EMAIL_FIELD_XPATH}    test
	Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Click Button                        xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Check Error Message                 ${INVALID_EMAIL_TEXT}

Check Confirmation Message
	[Tags]    robot:recursive-continue-on-failure
	Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Input Text                          ${EMAIL_FIELD_XPATH}    test@test.test
	Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Click Button                        xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
    Wait Until Keyword Succeeds         10  2   Check Error Message   ${CONFIRMATION_TEXT}test@test.test

Check Cancel Button Redirection
	[Tags]    robot:recursive-continue-on-failure   Smoke
    Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${CANCEL_BUTTON_TEXT}")]
    Click Button                        xpath://*/button[contains(text(),"${CANCEL_BUTTON_TEXT}")]
    ${current_url}  Get Location
    Should Be Equal As Strings    ${current_url}    ${BASE_URL}/app/auth
