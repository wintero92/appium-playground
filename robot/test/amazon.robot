*** Settings ***
Library     AppiumLibrary
Library     ../.venv/lib64/python3.11/site-packages/robot/libraries/XML.py


*** Variables ***
${PRODUCT_NAME}                 Samsung
# Connect to Emulator
${APPIUM_SERVER}                http://localhost:4723/wd/hub
${PACKAGE_NAME}                 com.amazon.mShop.android.shopping
${APP_MAIN_ACTIVITY}            com.amazon.mShop.home.HomeActivity
${RESET_OFF}                    false
${RESET_ON}                     true
${FULL_RESET_ON}                true
${FULL_RESET_OFF}               false
${NEW_COMMAND_TIMEOUT}          0
${LANDSCAPE}                    LANDSCAPE
${platformVersion}              11
${deviceName}                   Pixel 4 API 30
${automationName}               UiAutomator2
${unicodeKeyboard}              true
${resetKeyboard}                true
${udid}                         emulator-5554
${APP_MAIN_2nd_ACTIVITY}        com.amazon.mShop.navigation.MainActivity
${skipDeviceInitialization}     true
${skipServerInstallation}       true
${PLATFORM}                     Android
${ROOT}                         ${CURDIR}
${APP_LOCATION}                 ${ROOT}${/}..${/}
${APK_NAME}                     amazon-shopping.apk


*** Test Cases ***
Verify Home Page
    [Tags]    tc1
    Connect To Emulator And Start Application
    Skip Login
    Search Input Is Visible

Search Product
    [Tags]    tc2
    Connect To Emulator And Start Application
    Skip Login
    Search Input Is Visible
    Search For    ${PRODUCT_NAME}

Add Product To Cart
    [Tags]    tc3
    Connect To Emulator And Start Application
    Skip Login
    Search Input Is Visible
    Search For    ${PRODUCT_NAME}
    Open First    ${PRODUCT_NAME}
    Swipe Until Element Is Visible And Click By Class And Text    class=android.widget.Button    Add to Cart
    Assert Non Empty Cart

Remove Product From Cart
    [Tags]    tc4
    Connect To Emulator And Start Application
    Skip Login
    Search Input Is Visible
    Search For    ${PRODUCT_NAME}
    Open First    ${PRODUCT_NAME}
    Swipe Until Element Is Visible And Click By Class And Text    class=android.widget.Button    Add to Cart
    Assert Non Empty Cart
    Delete First From Cart

Verify Login Page
    [Tags]    tc5
    Connect To Emulator And Start Application
    Open Login


*** Keywords ***
Connect To Emulator And Start Application
    Open Application    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM}
    ...    app=${APP_LOCATION}${APK_NAME}
    ...    appPackage=${PACKAGE_NAME}
    ...    appActivity=${APP_MAIN_ACTIVITY}
    ...    fullReset=${FULL_RESET_ON}
    ...    noReset=${RESET_OFF}
    ...    newCommandTimeout=${NEW_COMMAND_TIMEOUT}
    ...    platformVersion=${platformVersion}
    ...    deviceName=${deviceName}
    ...    automationName=${automationName}
    ...    unicodeKeyboard=${unicodeKeyboard}
    ...    resetKeyboard=${resetKeyboard}
    ...    udid=${udid}
    Log To Console    \nConnected to Emulator\n

Skip Login
    Wait Until Element Is Visible    com.amazon.mShop.android.shopping:id/skip_sign_in_button
    Element Should Be Visible    com.amazon.mShop.android.shopping:id/skip_sign_in_button
    Click Element    com.amazon.mShop.android.shopping:id/skip_sign_in_button
    Log To Console    \nClick on Skip Login\n

Search Input Is Visible
    Wait Until Element Is Visible    com.amazon.mShop.android.shopping:id/chrome_search_hint_view
    Element Should Be Visible    com.amazon.mShop.android.shopping:id/chrome_search_hint_view
    Log To Console    \nSearch Input is visible\n

Search For
    [Arguments]    ${search_pattern}
    Click Element    com.amazon.mShop.android.shopping:id/chrome_search_hint_view
    Input Text    com.amazon.mShop.android.shopping:id/rs_search_src_text    ${search_pattern}
    Press Keycode    66
    Log To Console    \nWaiting for 10s\n
    Sleep    10s
    Click Element    com.amazon.mShop.android.shopping:id/chrome_search_hint_view
    Input Text    com.amazon.mShop.android.shopping:id/rs_search_src_text    ${search_pattern}
    Press Keycode    66
    Wait Until Page Contains Element
    ...    xpath=//android.view.View[contains(@content-desc, "${search_pattern}")]
    ...    timeout=60s
    Element Should Be Visible    xpath=//android.view.View[contains(@content-desc, "${search_pattern}")]
    Log To Console    \nPage Should Contains ${search_pattern}\n

Open First
    [Arguments]    ${search_pattern}
    Click Element    xpath=//android.view.View[contains(@content-desc, "${search_pattern}")]

Swipe Until Element Is Visible And Click By Class And Text
    [Arguments]    ${locator}    ${text}
    FOR    ${counter}    IN RANGE    ${0}    ${10}
        Sleep    5s
        ${elements_founded}    Run Keyword And Return Status    Get Webelements    ${locator}
        IF    ${elements_founded}==${TRUE}
            @{elements}    Get Webelements    ${locator}
            FOR    ${element}    IN    @{elements}
                ${element_text}    Get Text    ${element}
                ${element_founded}    Run Keyword And Return Status
                ...    Should Be Equal As Strings
                ...    ${element_text}
                ...    ${text}
                IF    ${element_founded}==${TRUE}
                    Click Element    ${element}
                    BREAK
                END
            END
        ELSE
            Set Test Variable    ${element_founded}    ${FALSE}
        END
        IF    ${element_founded}==${TRUE}            BREAK
        Swipe By Percent    50    80    50    30
    END
    Sleep    5s
    Log To Console    Swiped to and Clicked on ${locator} with ${text}

Assert Non Empty Cart
    Click Element    com.amazon.mShop.android.shopping:id/cart_count
    Sleep    5s
    @{elements}    Get Webelements    class=android.widget.Button
    FOR    ${element}    IN    @{elements}
        ${element_text}    Get Text    ${element}
        ${element_founded}    Run Keyword And Return Status    Should Contain    ${element_text}    Proceed to checkout
        IF    ${element_founded}==${TRUE}            BREAK
    END
    IF    ${element_founded}!=${TRUE}    Fail    msg=Cart is empty

Delete First From Cart
    Sleep    5s
    @{elements}    Get Webelements    class=android.widget.Button
    FOR    ${element}    IN    @{elements}
        ${element_text}    Get Text    ${element}
        ${element_founded}    Run Keyword And Return Status    Should Contain    ${element_text}    Delete
        IF    ${element_founded}==${TRUE}    Click Element    ${element}
    END
    Sleep    5s
    @{elements}    Get Webelements    class=android.widget.TextView
    FOR    ${element}    IN    @{elements}
        ${element_text}    Get Text    ${element}
        ${element_founded}    Run Keyword And Return Status
        ...    Should Contain
        ...    ${element_text}
        ...    was removed from Shopping Cart
        IF    ${element_founded}==${TRUE}            BREAK
    END
    IF    ${element_founded}!=${TRUE}
        Fail    msg=Any product was not delete from cart
    END

Open Login
    Wait Until Element Is Visible    com.amazon.mShop.android.shopping:id/sign_in_button
    Click Element    com.amazon.mShop.android.shopping:id/sign_in_button
    Wait Until Element Is Visible    class=android.widget.EditText
    Input Text    class=android.widget.EditText    giveme99sale@ordie.com
