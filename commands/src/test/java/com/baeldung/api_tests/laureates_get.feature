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
* configure headers = {Authorization: '#(authToken)'}

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
And param birthDateTo = <birthDateTo>
And param deathDate = <deathDate>
And param deathDateTo = <deathDateTo>
And param foundedDate = <foundedDate>
And param birthCity = <birthCity>
And param birthCountry = <birthCountry>
And param birthContinent = <birthContinent>
And param deathCity = <deathCity>
And param deathCountry = <deathCountry>
And param deathContinent = <deathContinent>
And param foundedCity = <foundedCity>
And param foundedCountry = <foundedCountry>
And param foundedContinent = <foundedContinent>
And param HeadquartersCity = <HeadquartersCity>
And param HeadquartersCountry = <HeadquartersCountry>
And param HeadquartersContinent = <HeadquartersContinent>
And param nobelPrizeYear = <nobelPrizeYear>
And param yearTo = <yearTo>
And param nobelPrizeCategory = <nobelPrizeCategory>
And param format = <format>
And param csvLang = <csvLang>
When method get
Then status 200
And match response contains { laureates: '#array' }
And assert response.laureates[*].id != null

Examples:
| offset | limit | sort | ID | name | gender | motivation | affiliation | residence | birthDate | birthDateTo | deathDate | deathDateTo | foundedDate | birthCity | birthCountry | birthContinent | deathCity | deathCountry | deathContinent | foundedCity | foundedCountry | foundedContinent | HeadquartersCity | HeadquartersCountry | HeadquartersContinent | nobelPrizeYear | yearTo | nobelPrizeCategory | format | csvLang |

Scenario: Get Laureates with invalid query parameters resulting in Bad Request
Given path '/2.1/laureates'
And param offset = -1
When method get
Then status 400
And match response.code == '404'
And match response.message == 'There is not Laureate born that date'

Scenario: Get Laureates with nonexistent ID resulting in Not Found
Given path '/2.1/laureates'
And param ID = 999999
When method get
Then status 404
And match response.code == '404'
And match response.message == 'There is not Laureate born that date'

Scenario: Get Laureates with unprocessable entity due to semantic errors
Given path '/2.1/laureates'
And param birthDate = 'invalid-date'
When method get
Then status 422
And match response.code == '404'
And match response.message == 'There is not Laureate born that date'
