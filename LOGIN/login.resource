*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     DateTime
Variables   ../presets.py


*** Keywords ***
Check Image Is Visible
	[Arguments]    ${image_xpath}    ${image_src}
	Page Should Contain Image      ${image_src}
	Element Should Be Visible      ${image_xpath}
	${response}     GET            ${image_src}
	Should Be Equal As Integers    ${response.status_code}  200

Check Error Message
	[Arguments]    ${error_text}
    Wait Until Page Contains Element    xpath://*/div[contains(@class, "container-message")]
	Element Text Should Be              xpath://*/div[contains(@class, "container-message")]    ${error_text}
