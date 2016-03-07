/**
 * Created by amonetta on 07/03/16.
 */
package com.myedro.training

import spock.lang.*
import wslite.rest.ContentType
import wslite.rest.RESTClient

/**
 *
 */
class CarRestFunctionalSpec extends Specification {

    @Shared def restClient = new RESTClient("http://localhost:8080/cars/api")

    //@Shared def car

    def setup() {
        //car = new Car(year: 2015, model: 'TestFakeModel', make: 'TestFakeMake', carPlate:'AAA000').save(failOnError: true)
        //car = Car.load(1)
    }

    def cleanup() {
//        if (car)
//            car.delete()
    }

    void "test GET"() {
        when:
        def response = restClient.get(path: '/2', accept: ContentType.JSON)
        def status = response.statusCode
        def car = response.json

        then:
        status      == 200
        car.id         == 2
        car.year       == 1926
        car.model      == 'Imperial'
        car.make       == 'Chrysler'
    }

    void "test PUT"() {
        when:
        def response = restClient.put(path: '/1', accept: ContentType.JSON) {
            type: ContentType.JSON
            charset "UTF-8"
            urlenc year: 2016, model: 'TestFakeModelMod', make: 'TestFakeMakeMod', carPlate: 'BBB111'
        }
        def status = response.statusCode
        def car = response.json

        then:
        status      == 200
        car.year       == 2016
        car.model      == 'TestFakeModelMod'
        car.make       == 'TestFakeMakeMod'
        car.carPlate   == 'BBB111'
    }

    void "test POST"() {
        when:
        def response = restClient.post(path: '/', accept: ContentType.JSON) {
            type: ContentType.JSON
            charset "UTF-8"
            urlenc year: 2016, model: 'TestFakeModelNew', make: 'TestFakeMakeNew', carPlate: 'AAA001'
        }
        def status = response.statusCode
        def car = response.json

        then:
        status      == 201
        car.year       == 2016
        car.model      == 'TestFakeModelNew'
        car.make       == 'TestFakeMakeNew'
        car.carPlate   == 'AAA001'
    }
}
