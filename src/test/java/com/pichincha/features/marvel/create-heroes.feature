@REQ_HU-002 @marvel @HU002 @Agente2 @E2
Feature: HU-002 Micro Creacion heroes
  Background:
    Given url marvel_base_url
    * header content-type = 'application/json'

  @id:1 @HU-002-creacion-heroe-exitosa
  Scenario: HU-002 - Caso 01 - Creacion exitosa de heroe - karate

    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 201
    And match jsonreq.name == response.name
    And match jsonreq.alterego == response.alterego
    And match jsonreq.description == response.description
    And assert jsonreq.powers.length == response.powers.length
    And def heroe_id = response.id
    Given path '/anballes/api/characters/' + heroe_id
    When method DELETE
    Then status 204

  @id:2 @HU-002-creacion-heroe-fallida-duplicado
  Scenario: HU-002 - Caso 02 - Creacion fallida de heroe por duplicidad - karate

    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 201
    And match jsonreq.name == response.name
    And match jsonreq.alterego == response.alterego
    And match jsonreq.description == response.description
    And assert jsonreq.powers.length == response.powers.length
    And def heroe_id = response.id
    Given path '/anballes/api/characters'
    And request jsonreq
    When method POST
    Then status 400
    And match response.error == "Character name already exists"
    Given path '/anballes/api/characters/' + heroe_id
    When method DELETE
    Then status 204

  @id:3 @HU-002-creacion-heroe-fallida-datos-imcompletos
  Scenario: HU-002 - Caso 02 - Creacion fallida de heroe por falta de datos - karate

    * def jsonreq = read('classpath:../data/marvel/create-hero.json')
    And jsonreq.name = ""
    And request jsonreq
    Given path '/anballes/api/characters'
    When method POST
    Then status 400
    And match response.name == "Name is required"


