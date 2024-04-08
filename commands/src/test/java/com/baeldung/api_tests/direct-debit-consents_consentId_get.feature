# ********RoostGPT********

# Test generated by RoostGPT for test MiniProjects using AI Type Open AI and AI Model gpt-4-1106-preview
# 
# Feature file generated for /direct-debit-consents/{consentId}_get for http method type GET 
# RoostTestHash=296226bc11
# 
# 

# ********RoostGPT********
Feature: Real-time Direct Debit Consent Setup

Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase
    * def authToken = karate.properties['AUTH_TOKEN']

Scenario Outline: Retrieve direct-debit consent resource with consentId and validate response
    Given path '<consentId>'
    And header Authorization = 'Bearer ' + authToken
    And header x-fapi-auth-date = '<x-fapi-auth-date>'
    And header x-fapi-customer-ip-address = '<x-fapi-customer-ip-address>'
    And header x-fapi-interaction-id = '<x-fapi-interaction-id>'
    And header Accept-Language = '<Accept-Language>'
    When method GET
    Then status 200
    And match response contains { data: '#object' }
    And match response.data contains { consentId: '#string', creationDate: '#string', status: '#string', statusUpdateDate: '#string', permissions: '#array' }
    And match response.data.permissions == <permissions>
    And match response.data.consentId == '<consentId>'
    And match response.headers['x-fapi-interaction-id'] == '<x-fapi-interaction-id>'

    Examples:
        | consentId                              | x-fapi-auth-date              | x-fapi-customer-ip-address | x-fapi-interaction-id | Accept-Language | permissions                                                                                          |
        | '7404e99b-1a4d-4b08-b441-c327661527f0' | 'Sun, 10 Sep 2017 19:43:31 UTC' | '169.254.169.254'          | 'unique-id-12345'     | 'en-HK'         | ['RealTimeDirectDebitSetup', 'RealTimeDirectDebitOtpConfirmation']                                 |
        | '7404e99b-1a4d-4b08-b441-c327661527f0' | 'Sun, 10 Sep 2017 19:43:31 UTC' | '169.254.169.254'          | 'unique-id-67890'     | 'zh-CN'         | ['RealTimeDirectDebitStatusAuthorisations', 'RealTimeDirectDebitInstructions']                     |

Scenario Outline: Retrieve direct-debit consent resource with invalid consentId and validate error response
    Given path '<consentId>'
    And header Authorization = 'Bearer ' + authToken
    And header x-fapi-auth-date = '<x-fapi-auth-date>'
    And header x-fapi-customer-ip-address = '<x-fapi-customer-ip-address>'
    And header x-fapi-interaction-id = '<x-fapi-interaction-id>'
    And header Accept-Language = '<Accept-Language>'
    When method GET
    Then status <expectedStatus>
    And match response.errors[0] contains { code: '<errorCode>', causes: <errorCauses> }

    Examples:
        | consentId | x-fapi-auth-date              | x-fapi-customer-ip-address | x-fapi-interaction-id | Accept-Language | expectedStatus | errorCode           | errorCauses                                   |
        | 'invalid' | 'Sun, 10 Sep 2017 19:43:31 UTC' | '169.254.169.254'          | 'unique-id-99999'     | 'en-HK'         | 400            | 'OB.Field.Invalid'  | 'The provided consentId is invalid.'          |
        | 'invalid' | 'Sun, 10 Sep 2017 19:43:31 UTC' | '169.254.169.254'          | 'unique-id-88888'     | 'zh-CN'         | 401            | 'OB.Unauthorised'   | 'Bearer token is missing or not authorized.'  |
