*** Settings ***
Documentation   Tests automatisés pour la réinitialisation de son mot de passe
Library         SeleniumLibrary     run_on_failure=NOTHING
Library         Collections
Resource        login.resource
Resource        ../main.resource
Variables       ../presets.py
Variables       reset_variables.py
Variables       reset_xpaths.py
Suite Setup     Open Browser    ${url}  ${browser}  options=add_argument("--start-maximized");add_argument("--headless");add_experimental_option('excludeSwitches', ['enable-logging'])
Suite Teardown  Pause And Close Browser
Test Tags       robot:recursive-continue-on-failure

*** Variables ***
${url}          ${BASE_URL}/app/auth/reset
${browser}      Chrome

*** Test Cases ***
Check Webpage Title
	Title Should Be    ${WEBPAGE_TITLE}

Check Background Image
	Background Image Should Be    ${BACKGROUND_IMAGE_SRC}

Check Logo
	Check Image Is Visible   ${LOGO_XPATH}   ${LOGO_SRC}

Check Webpage Images have alternative text
	[Tags]    RGAA
	Check Images Have Alternative Text

Check Message
	Element Text Should Be      ${MESSAGE_XPATH}    ${MESSAGE}

Check Presence of Input(s)
	[Tags]    Smoke
    Page Should Contain Element    ${EMAIL_FIELD_XPATH}
    Element Should Be Enabled      ${EMAIL_FIELD_XPATH}

Check Placeholder(s)
	Placeholder Should Be   ${EMAIL_FIELD_XPATH}    ${EMAIL_FIELD_PLACEHOLDER}

Check Button(s)
	[Tags]    Smoke
	Page Should Contain Element    xpath://*/button[contains(text(),"${CANCEL_BUTTON_TEXT}")]
	Page Should Contain Element    xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]

Check No Email Error Message
    Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Click Button                        xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Check Error Message                 ${NO_EMAIL_TEXT}

Check Ivalid Email Error Message
	Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Input Text                          ${EMAIL_FIELD_XPATH}    test
	Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Click Button                        xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Check Error Message                 ${INVALID_EMAIL_TEXT}

Check Confirmation Message
	Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Input Text                          ${EMAIL_FIELD_XPATH}    test@test.test
	Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
	Click Button                        xpath://*/button[contains(text(),"${VALIDATE_BUTTON_TEXT}")]
    Wait Until Keyword Succeeds         10  2   Check Error Message   ${CONFIRMATION_TEXT}test@test.test

Check Cancel Button Redirection
	[Tags]    Smoke
    Wait Until Element Is Enabled       xpath://*/button[contains(text(),"${CANCEL_BUTTON_TEXT}")]
    Click Button                        xpath://*/button[contains(text(),"${CANCEL_BUTTON_TEXT}")]
    ${current_url}  Get Location
    Should Be Equal As Strings    ${current_url}    ${BASE_URL}/app/auth
