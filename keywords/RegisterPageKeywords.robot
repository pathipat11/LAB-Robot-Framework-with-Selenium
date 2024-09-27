*** Settings ***
Library    SeleniumLibrary
Resource   CommonKeywords.robot

*** Keywords ***
user registers on future skill platform with ${email}, ${firstName}, ${lastName}, ${phoneNumber}, ${newPassword}, and ${confirmPassword}
    Log To Console    --- Starting registration process ---

    # Capture screenshot before starting registration
    Capture Page Screenshot    ${OUTPUTDIR}/registration_page_open.png

    # Get and log the current URL before starting
    ${current_url}=    Get Location
    Log To Console    Current page URL: ${current_url}

    # Click on the register button
    CommonKeywords.Wait until element is ready then click element    xpath=//button[text()="สมัครสมาชิก"]
    Log To Console    --- Register button clicked ---
    
    # Input registration details
    CommonKeywords.Wait until element is ready then input text    name=firstName         ${firstName}
    CommonKeywords.Wait until element is ready then input text    name=lastName          ${lastName}
    CommonKeywords.Wait until element is ready then input text    name=email             ${email}
    CommonKeywords.Wait until element is ready then input text    name=phoneNumber       ${phoneNumber}
    CommonKeywords.Wait until element is ready then input text    name=newPassword       ${newPassword}
    CommonKeywords.Wait until element is ready then input text    name=confirmPassword   ${confirmPassword}
    Log To Console    --- Registration details filled ---

    # Capture screenshot after filling registration details
    Capture Page Screenshot    ${OUTPUTDIR}/registration_form_filled.png

    # Consent checkbox
    CommonKeywords.Wait until element is ready then click element    xpath=//input[@name='consent']
    Log To Console    --- Consent checkbox clicked ---
    
    # Submit the form
    CommonKeywords.Wait until element is ready then click element    xpath=//button[@type="submit" and text()="สมัครสมาชิก"]
    Log To Console    --- Registration form submitted ---
    
verify OTP page and enter code
    [Arguments]    ${otpCode}
    Log To Console    --- Waiting for OTP page ---
    
    # Capture screenshot before entering OTP
    Capture Page Screenshot    ${OUTPUTDIR}/otp_page_open.png
    
    # Verify OTP page is displayed
    Wait Until Element Is Visible    xpath=//input[@name='otpCode']    20s
    Log To Console    --- OTP page is visible ---
    
    # Enter the OTP code
    Input Text    xpath=//input[@name='otpCode']    ${otpCode}
    Log To Console    --- Entered OTP: ${otpCode} ---
    
    # Capture screenshot after entering OTP
    Capture Page Screenshot    ${OUTPUTDIR}/otp_code_entered.png
    
    # Submit OTP
    Wait Until Element Is Visible    xpath=//button[contains(text(), 'ยืนยัน')]    10s
    Click Button    xpath=//button[contains(text(), 'ยืนยัน')]
    Log To Console    --- Submitted OTP ---
    
future skill should display OTP confirmation message as "${expected_message}"
    CommonKeywords.Wait until page contains element then verify text    ${expected_message}
    Log To Console    --- OTP confirmation message verified ---
    
    # Capture screenshot after OTP confirmation
    Capture Page Screenshot    ${OUTPUTDIR}/otp_confirmation_message.png
