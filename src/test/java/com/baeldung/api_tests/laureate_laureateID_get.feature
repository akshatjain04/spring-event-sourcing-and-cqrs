# ********RoostGPT********

# Test generated by RoostGPT for test MiniProjects using AI Type Open AI and AI Model gpt-4-1106-preview
# 
# Feature file generated for /laureate/{laureateID}_get for http method type GET 
# RoostTestHash=3a8d014c99
# 
# 

# ********RoostGPT********
Feature: Nobel Prize Laureate Information Retrieval

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase
    * def authToken = karate.properties['AUTH_TOKEN']

  Scenario Outline: Get information about a specific Nobel Prize Laureate by ID
    Given path '2.1/laureate/', <laureateID>
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 200
    And match response contains { laureate: '#object' }
    And assert response.laureate.id == <laureateID>
    And match response.laureate.laureateIfPerson.knownName.en == '#string'
    And match response.laureate.laureateIfPerson.familyName.en == '#string'
    And match response.laureate.laureateIfPerson.fullName.en == '#string'
    And match response.laureate.laureateIfPerson.birth.date == '#string'
    And match response.laureate.laureateIfPerson.birth.place.city.en == '#string'
    And match response.laureate.laureateIfPerson.birth.place.country.en == '#string'

    Examples:
      | laureateID |
      | 456        |
      | 789        |

  Scenario: Get information about a specific Nobel Prize Laureate with invalid ID
    Given path '2.1/laureate/', 0
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 400
    And match response == { code: '404', message: 'There is not Laureate born that date' }

  Scenario: Get information about a non-existing Nobel Prize Laureate
    Given path '2.1/laureate/', 999999
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 404
    And match response == { code: '404', message: 'There is not Laureate born that date' }

  Scenario: Get information about a specific Nobel Prize Laureate with unprocessable data
    Given path '2.1/laureate/', 'abc'
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 422
    And match response == { code: '404', message: 'There is not Laureate born that date' }
