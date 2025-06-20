@REQ_HU-004 @marvel @HU004 @Agente2 @E2
Feature: HU-004 Micro Eliminacion de heroes
  Background:
    Given url marvel_base_url
    * header content-type = 'application/json'

  @id:1 @HU-004-eliminacion-heroe-exitosa
  Scenario: HU-004 - Caso 01 - Eliminacion exitosa de heroe - karate

    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 201
    And def heroe_id = response.id
    Given path '/anballes/api/characters/' + heroe_id
    When method DELETE
    Then status 204

  @id:2 @HU-004-eliminacion-heroe-fallida
  Scenario: HU-004 - Caso 02 - Eliminacion fallida de heroe - karate

    Given path '/anballes/api/characters/99999'
    * def new_jsonreq = read('classpath:../data/marvel/create-hero.json')
    And request new_jsonreq
    When method DELETE
    Then status 404


