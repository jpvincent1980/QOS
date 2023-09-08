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

Check Images have alternative text
    @{images}  Get Webelements  tag:img
	FOR  ${image}  IN  @{images}
		${src}  Get Element Attribute  ${image}  src
		${alt}  Get Element Attribute  ${image}  alt
		Run Keyword And Warn On Failure  Variable Should Exist  ${alt}
        Run Keyword And Warn On Failure  Should Not Be Empty    ${alt}
        ${status_if_exists}  Run Keyword And Return Status   Variable Should Exist    ${alt}
        ${status_if_empty}  Run Keyword And Return Status    Should Not Be Empty    ${alt}
        IF  ${status_if_exists} == False or ${status_if_empty} == False
        	Log To Console    L'image dont le src est '${src}' ne possède pas de texte alternatif.
        END
    END

Check Error Message
	[Arguments]    ${error_text}
    Wait Until Page Contains Element    xpath://*/div[contains(@class, "container-message")]
	Element Text Should Be              xpath://*/div[contains(@class, "container-message")]    ${error_text}
