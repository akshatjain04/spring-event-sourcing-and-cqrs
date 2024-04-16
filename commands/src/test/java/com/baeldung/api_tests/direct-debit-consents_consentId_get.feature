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
    * def contentTypeJson = 'application/json'
    * header Authorization = 'Bearer ' + authToken
    * header Accept = contentTypeJson
    * header 'Content-Type' = contentTypeJson

  Scenario Outline: Retrieve direct-debit consent by consentId with valid authorization
    Given path 'direct-debit-consents', <consentId>
    And header x-fapi-auth-date = <x_fapi_auth_date>
    And header x-fapi-customer-ip-address = <x_fapi_customer_ip_address>
    And header x-fapi-interaction-id = <x_fapi_interaction_id>
    And header Accept-Language = <Accept_Language>
    When method GET
    Then status 200
    And match response contains { data: '#object' }
    And assert response.data.consentId == <consentId>

    Examples:
      | consentId                              | x_fapi_auth_date                | x_fapi_customer_ip_address | x_fapi_interaction_id | Accept_Language |
      | '7404e99b-1a4d-4b08-b441-c327661527f0' | 'Sun, 10 Sep 2017 19:43:31 UTC' | '169.254.169.254'          | 'unique-id-12345'     | 'en-HK'         |

  Scenario: Retrieve direct-debit consent by consentId with missing authorization
    Given path 'direct-debit-consents', '7404e99b-1a4d-4b08-b441-c327661527f0'
    And header x-fapi-auth-date = 'Sun, 10 Sep 2017 19:43:31 UTC'
    And header x-fapi-customer-ip-address = '169.254.169.254'
    And header x-fapi-interaction-id = 'unique-id-12345'
    And header Accept-Language = 'en-HK'
    And removeHeader 'Authorization'
    When method GET
    Then status 401

  Scenario: Retrieve direct-debit consent by consentId with invalid consentId
    Given path 'direct-debit-consents', 'invalid-consentId'
    And header x-fapi-auth-date = 'Sun, 10 Sep 2017 19:43:31 UTC'
    And header x-fapi-customer-ip-address = '169.254.169.254'
    And header x-fapi-interaction-id = 'unique-id-12345'
    And header Accept-Language = 'en-HK'
    When method GET
    Then status 400
    And match response.errors[*].code contains 'OB.Field.Invalid'

  Scenario: Retrieve direct-debit consent by consentId with unsupported Accept-Language
    Given path 'direct-debit-consents', '7404e99b-1a4d-4b08-b441-c327661527f0'
    And header x-fapi-auth-date = 'Sun, 10 Sep 2017 19:43:31 UTC'
    And header x-fapi-customer-ip-address = '169.254.169.254'
    And header x-fapi-interaction-id = 'unique-id-12345'
    And header Accept-Language = 'unsupported-language'
    When method GET
    Then status 406
