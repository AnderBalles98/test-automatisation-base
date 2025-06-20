@REQ_HU-003 @marvel @HU003 @Agente2 @E2
Feature: HU-003 Micro Actualizacion de heroes
  Background:
    Given url marvel_base_url
    * header content-type = 'application/json'

  @id:1 @HU-003-actualizacion-heroe-exitosa
  Scenario: HU-003 - Caso 01 - Actualizacion exitosa de heroe - karate

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
    * def new_jsonreq = read('classpath:../data/marvel/create-hero.json')
    And new_jsonreq.name = "Nuevo nombre"
    And new_jsonreq.description = "Nueva descripcion"
    And request new_jsonreq
    When method PUT
    Then status 200
    Given path '/anballes/api/characters/' + heroe_id
    When method GET
    Then status 200
    And match new_jsonreq.name == response.name
    And match new_jsonreq.description == response.description
    Given path '/anballes/api/characters/' + heroe_id
    When method DELETE
    Then status 204

  @id:2 @HU-003-actualizacion-heroe-fallida
  Scenario: HU-003 - Caso 02 - Actualizacion fallida de heroe - karate

    Given path '/anballes/api/characters/999'
    * def new_jsonreq = read('classpath:../data/marvel/create-hero.json')
    And request new_jsonreq
    When method PUT
    Then status 404


