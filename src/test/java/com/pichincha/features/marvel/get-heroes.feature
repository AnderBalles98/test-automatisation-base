@REQ_HU-001 @marvel @HU001 @Agente2 @E2
Feature: HU-001 Micro consulta heroes
  Background:
    Given url marvel_base_url
    * header content-type = 'application/json'

  @id:1 @HU-001-consulta-todos-heroes-exitosa
  Scenario: HU-001 - Caso 01 - Consulta exitosa de todos los heroes - karate

    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And jsonreq.name = "Hero 1"
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 201
    And def heroe1_id = response.id
    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And jsonreq.name = "Hero 2"
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 201
    And def heroe2_id = response.id
    Given path '/anballes/api/characters'
    When method GET
    Then status 200
    And assert response.length == 2
    Given path '/anballes/api/characters/' + heroe1_id
    When method DELETE
    Then status 204
    Given path '/anballes/api/characters/' + heroe2_id
    When method DELETE
    Then status 204

  @id:2 @HU-001-consulta-exitosa-heroe-especifico
  Scenario: HU-001 - Caso 02 - Consulta exitosa de heroe expecifico - karate

    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 201
    And def created_response = response
    And def heroe_id = response.id
    Given path '/anballes/api/characters/' + heroe_id
    When method GET
    Then status 200
    And match created_response == response
    Given path '/anballes/api/characters/' + heroe_id
    When method DELETE
    Then status 204

  @id:3 @HU-001-consulta-fallida-heroe-especifico
  Scenario: HU-001 - Caso 03 - Consulta fallida de heroe especifico - karate

    Given path '/anballes/api/characters/99999'
    When method GET
    Then status 404