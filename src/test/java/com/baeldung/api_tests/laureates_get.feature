# ********RoostGPT********

# Test generated by RoostGPT for test MiniProjects using AI Type Open AI and AI Model gpt-4-1106-preview
# 
# Feature file generated for /laureates_get for http method type GET 
# RoostTestHash=bb9ad621b1
# 
# 

# ********RoostGPT********
Feature: Nobel Prize Laureates API Testing

Background:
* def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
* url urlBase
* def authToken = karate.properties['AUTH_TOKEN']
* header Authorization = 'Bearer ' + authToken

Scenario Outline: Get Laureates with valid query parameters
Given path '/2.1/laureates'
And param offset = <offset>
And param limit = <limit>
And param sort = <sort>
And param ID = <ID>
And param name = <name>
And param gender = <gender>
And param motivation = <motivation>
And param affiliation = <affiliation>
And param residence = <residence>
And param birthDate = <birthDate>
When method get
Then status 200
And match response.laureates[*].id == '#number'
And match response.laureates[*].laureateIfPerson.knownName.en == '#string'
And match response.laureates[*].nobelPrizes[*].awardYear == '#number'

Examples:
| offset | limit | sort | ID | name        | gender | motivation | affiliation | residence | birthDate  |
| 1      | 5     | asc  | 1  | 'Einstein'  | male   | 'Physics'  | 'University' | 'Berlin'  | '1879-03-14' |

Scenario Outline: Get Laureates with invalid query parameters resulting in Bad Request
Given path '/2.1/laureates'
And param offset = <offset>
And param limit = <limit>
When method get
Then status 400
And match response.code == '400'
And match response.message == '#string'

Examples:
| offset | limit |
| -1     | 10    |
| 1      | -5    |

Scenario Outline: Get Laureates with non-existing resource resulting in Not Found
Given path '/2.1/laureates'
And param ID = <ID>
When method get
Then status 404
And match response.code == '404'
And match response.message == '#string'

Examples:
| ID |
| 999999 |

Scenario Outline: Get Laureates with unprocessable entity
Given path '/2.1/laureates'
And param birthDate = <birthDate>
When method get
Then status 422
And match response.code == '422'
And match response.message == '#string'

Examples:
| birthDate |
| 'invalid-date' |
