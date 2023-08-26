*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     DateTime
Variables   ../presets.py


*** Keywords ***
Check Logo Is Visible
	[Arguments]    ${logo_xpath}    ${logo_src}
	Page Should Contain Image   ${logo_src}
	Element Should Be Visible    ${logo_xpath}
	${response}     GET    ${logo_src}
	Should Be Equal As Integers    ${response.status_code}  200

Check Error Message
	[Arguments]    ${error_text}
    Wait Until Page Contains Element    xpath://*/div[contains(@class, "container-message")]
	Element Text Should Be              xpath://*/div[contains(@class, "container-message")]    ${error_text}
