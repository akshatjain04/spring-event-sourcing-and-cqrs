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
  * def urlBase = karate.properties['url.base'] || 'http://localhost:8080'

Scenario Outline: Get information about a specific Nobel Prize Laureate by ID
  Given url urlBase + '/2.1/laureate/' + <laureateID>
  And header Authorization = 'Bearer ' + karate.properties['AUTH_TOKEN']
  When method get
  Then status 200
  And match response contains
    """
    {
      "laureate": {
        "id": "#number",
        "laureateIfPerson": {
          "knownName": {
            "en": "#string",
            "se": "#string"
          },
          "givenName": {
            "en": "#string",
            "se": "#string"
          },
          "familyName": {
            "en": "#string",
            "se": "#string"
          },
          "fullName": {
            "en": "#string",
            "se": "#string"
          },
          "filename": "#string",
          "gender": "#string",
          "birth": {
            "date": "#string",
            "place": {
              "city": {
                "en": "#string",
                "se": "#string"
              },
              "country": {
                "en": "#string",
                "se": "#string"
              }
            }
          }
        }
      }
    }
    """

Examples:
  | laureateID |
  | 456        |

Scenario: Get information about a Nobel Prize Laureate with a non-existing ID
  Given url urlBase + '/2.1/laureate/999999'
  And header Authorization = 'Bearer ' + karate.properties['AUTH_TOKEN']
  When method get
  Then status 404
  And match response == { "code": "404", "message": "There is not Laureate born that date" }

Scenario: Get information about a Nobel Prize Laureate with an invalid ID format
  Given url urlBase + '/2.1/laureate/invalid'
  And header Authorization = 'Bearer ' + karate.properties['AUTH_TOKEN']
  When method get
  Then status 400
  And match response == { "code": "400", "message": "Invalid ID format" }

Scenario: Get information about a Nobel Prize Laureate with an ID that causes semantic errors
  Given url urlBase + '/2.1/laureate/0'
  And header Authorization = 'Bearer ' + karate.properties['AUTH_TOKEN']
  When method get
  Then status 422
  And match response == { "code": "422", "message": "Semantic error with ID" }
