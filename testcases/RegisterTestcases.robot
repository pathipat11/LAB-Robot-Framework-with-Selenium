*** Settings ***
Library         SeleniumLibrary
Resource        ../keywords/RegisterPageKeywords.robot
Variables       ../resources/config/config.yaml
Variables       ../resources/testdata/testdata.yaml
Suite Setup     Open Browser    ${baseUrl}    chrome
Suite Teardown  Close Browser

*** Test Cases ***
As a user, I want to register successfully on the FutureSkill platform
    [Documentation]    Register and verify OTP on the FutureSkill platform.
    
    # Step 1: Register on FutureSkill platform
    user registers on future skill platform with ${register_email}, ${firstName}, ${lastName}, ${phoneNumber}, ${newPassword}, and ${confirmPassword}
    
    # Step 2: Verify OTP page and enter code (e.g., '123456')
    verify OTP page and enter code    123456
    
    # Step 3: Verify the OTP success message
    future skill should display OTP confirmation message as "ระบบได้ส่งรหัส OTP ไปยังเบอร์โทรศัพท์"
