# ********RoostGPT********

# Test generated by RoostGPT for test MiniProjects using AI Type Open AI and AI Model gpt-4-1106-preview
# 
# Feature file generated for /nobelPrizes_get for http method type GET 
# RoostTestHash=4940f5c55b
# 
# 

# ********RoostGPT********
Feature: Nobel Prizes API Feature

Background:
  * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
  * url urlBase
  * def authToken = karate.properties['AUTH_TOKEN']
  * header Authorization = 'Bearer ' + authToken

Scenario Outline: Get Nobel Prizes with various query parameters
  Given path '/2.1/nobelPrizes'
  And param offset = <offset>
  And param limit = <limit>
  And param sort = <sort>
  And param nobelPrizeYear = <nobelPrizeYear>
  And param yearTo = <yearTo>
  And param nobelPrizeCategory = <nobelPrizeCategory>
  And param format = <format>
  And param csvLang = <csvLang>
  When method get
  Then status 200
  And assert response.nobelPrizes != null
  And match each response.nobelPrizes[*].awardYear == '#number'
  And match each response.nobelPrizes[*].categoryFullName.en == '#string'
  And match each response.nobelPrizes[*].prizeAmount == '#number'
  And match each response.nobelPrizes[*].laureates[*].id == '#number'
  And match each response.nobelPrizes[*].laureates[*].name.en == '#string'
  
  Examples:
    | offset | limit | sort  | nobelPrizeYear | yearTo | nobelPrizeCategory | format | csvLang |
    | 1      | 5     | 'asc' | 2001           | 2005   | 'med'              | 'json' | 'en'    |
    | 2      | 10    | 'desc'| 1999           | 2003   | 'che'              | 'json' | 'se'    |

Scenario: Get Nobel Prizes with invalid parameters should return 400 Bad Request
  Given path '/2.1/nobelPrizes'
  And param offset = -1
  When method get
  Then status 400
  And match response.code == '404'
  And match response.message == 'There is not Laureate born that date'

Scenario: Get Nobel Prizes with non-existent year should return 404 Not Found
  Given path '/2.1/nobelPrizes'
  And param nobelPrizeYear = 1800
  When method get
  Then status 404
  And match response.code == '404'
  And match response.message == 'There is not Laureate born that date'

Scenario: Get Nobel Prizes with unprocessable entity should return 422 Unprocessable Entity
  Given path '/2.1/nobelPrizes'
  And param nobelPrizeYear = 'invalidYear'
  When method get
  Then status 422
  And match response.code == '404'
  And match response.message == 'There is not Laureate born that date'
