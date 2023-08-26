*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     DateTime
Library     functions.py
Variables   presets.py


*** Keywords ***
Open Browser And Maximize
    [Arguments]    ${url}   ${browser}
    Open Browser    ${url}  ${browser}
    Maximize Browser Window

Pause And Close Browser
    Sleep    2
    Close Browser