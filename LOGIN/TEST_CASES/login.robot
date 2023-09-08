*** Settings ***
Documentation   Tests automatisés pour la connexion à l'application Qantum
Library         SeleniumLibrary     run_on_failure=NOTHING
Library         Collections
Resource        ../KEYWORDS/login.resource
Resource        ../../main.resource
Variables       ../../presets.py
Variables       ../VARIABLES/login_variables.py
Variables       ../LOCATORS/login_locators.py
Suite Setup     Open Browser And Maximize    ${url}  ${browser}
Suite Teardown  Pause And Close Browser
Test Tags       robot:recursive-continue-on-failure

*** Variables ***
${url}          ${BASE_URL}/app/auth/
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

Check Welcome Message
	Element Text Should Be      ${WELCOME_XPATH}    ${WELCOME}

Check Presence of Input(s)
	[Tags]    Smoke
    Page Should Contain Element    ${EMAIL_FIELD_XPATH}
    Page Should Contain Element    ${PASSWORD_FIELD_XPATH}
    Element Should Be Enabled      ${EMAIL_FIELD_XPATH}
    Element Should Be Enabled      ${PASSWORD_FIELD_XPATH}

Check Placeholder(s)
	Placeholder Should Be   ${EMAIL_FIELD_XPATH}    ${EMAIL_FIELD_PLACEHOLDER}
	Placeholder Should Be   ${PASSWORD_FIELD_XPATH}    ${PASSWORD_FIELD_PLACEHOLDER}

Check Remain Connected Checkbox And Message
	Page Should Contain Checkbox       name:remember-me
	Checkbox Should Not Be Selected    name:remember-me
	Element Text Should Be             xpath://*[@id="login-form"]/div[4]/label      ${STAY_CONNECTED_TEXT}
	Select Checkbox                    name:remember-me
	Checkbox Should Be Selected        name:remember-me

Check Forgotten Password Link And Message
	[Tags]    Smoke
	Page Should Contain Link    ${FORGOTTEN_PASSWORD_RELATIVE_LINK}
	Element Text Should Be      xpath://*/a[@href="${FORGOTTEN_PASSWORD_RELATIVE_LINK}"]    ${FORGOTTEN_PASSWORD_TEXT}

Check Connection Button
	[Tags]    Smoke
	Page Should Contain Element    xpath://*/button
	Element Text Should Be         xpath://*/button     ${CONNECTION_BUTTON_TEXT}

Check No Email Error Message
    Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Wait Until Element Is Enabled       xpath://*/button
	Click Button                        xpath://*/button
	Check Error Message                 ${NO_EMAIL_TEXT}

Check Ivalid Email Error Message
	Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Input Text                          ${EMAIL_FIELD_XPATH}    test
	Wait Until Element Is Enabled       xpath://*/button
	Click Button                        xpath://*/button
	Check Error Message                 ${INVALID_EMAIL_TEXT}

Check No Password Error Message
    Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
	Input Text                          ${EMAIL_FIELD_XPATH}    test@test.test
    Input Text                          ${PASSWORD_FIELD_XPATH}    ${EMPTY}
	Wait Until Element Is Enabled       xpath://*/button
	Click Button                        xpath://*/button
	Check Error Message                 ${NO_PASSWORD_TEXT}

Check Invalid Password Error Message
    Wait Until Element Is Enabled       ${EMAIL_FIELD_XPATH}
    Press Keys                          ${EMAIL_FIELD_XPATH}   CTRL+A   BACKSPACE
    Input Text                          ${EMAIL_FIELD_XPATH}    test@test.test
    Input Text                          ${PASSWORD_FIELD_XPATH}    test
	Wait Until Element Is Enabled       xpath://*/button
	Click Button                        xpath://*/button
	Wait Until Keyword Succeeds         10  2   Check Error Message   ${INVALID_PASSWORD_TEXT}
