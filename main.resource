*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     DateTime
Library     functions.py
Variables   presets.py


*** Keywords ***
Open Browser And Maximize
    [Arguments]    ${url}   ${browser}
    Open Browser    ${url}  ${browser}  options=add_argument("--start-maximized");add_argument("--headless");add_experimental_option('excludeSwitches', ['enable-logging'])

Pause And Close Browser
    Sleep    2
    Close Browser