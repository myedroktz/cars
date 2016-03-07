package com.myedro.training

import spock.lang.Shared
import spock.lang.Specification
import wslite.rest.ContentType
import wslite.rest.RESTClient

class CarRestControllerFunctionalSpec extends Specification {
    @Shared def restClient = new RESTClient("http://localhost:8080/cars/api")

    def setup() {

    }

    void "GET a list of car with no filters"() {
        given: "A rest client"
            restClient

        when:"Asking for a car list"
        def response = restClient.get(
                path: "/",
                accept: ContentType.JSON
        )

        then: "Return status code 200 and first 10 objects"
            response.statusCode == 200
            response.json.size() == 10
    }

    void "Testing a Post"() {
        given: "A rest client"
        restClient

        when:"Posting a new car"
        def response = restClient.post(accept: ContentType.JSON){
                path: "/save"
                type: ContentType.JSON
                charset "UTF-8"
                urlenc make: "Chevrolet", model: "Classic", year: "2023", carPlate: "NZT605", owner: 1
        }

        then: "Return status code 201 and id != null"
        response.statusCode == 201
        response.json.id != null
    }
}