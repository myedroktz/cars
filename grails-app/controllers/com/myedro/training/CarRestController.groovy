package com.myedro.training

import grails.converters.JSON
import net.sf.ehcache.transaction.xa.commands.Command


class CarRestController {
    static responseFormats = ["json","xml"]

    /***
     *  Example urls
     *  http://localhost:8080/cars/api?make=Ford&model=Mustang&year=2000
     *  http://localhost:8080/cars/api?make=Ford&model=Mustang
     *  http://localhost:8080/cars/api?make=Ford
     */
    def index() {
        def carList
        def query = Car.createCriteria()
        carList = query.list(max:10, offset:params.offset){
            and{
                if(params.make){
                    like("make", params.make+'%')
                }
                if(params.model){
                    like("model", params.model+'%')
                }
                if(params.year){
                    //like("year", params.year.toInteger())
                    def yearIni = params.year.padRight(4,'0').toInteger()
                    def yearEnd = params.year.padRight(4,'0').toInteger() + 10**(4 - params.year.length()) - 1
                    between("year", yearIni, yearEnd)
                }
            }
        }
        JSON.use('Car') {
            respond carList
        }
    }

    def show(Integer id) {
        Car car = Car.findById(id,[fetch:[owner:"eager"]])
        JSON.use('Car'){
            respond car
        }
    }

    def save(Car car) {
        if (!car.hasErrors()) {
            car.save()
            respond car, status: 201
        }
        else {
            respond car
        }
    }

    def update(Long id, Car newCar) {
//        request.getParameter("make")
        if (!newCar.hasErrors()) {
            def car = Car.get(id)

            if (!car) {
                respond message: "Not found", status: 404
                return
            }

            car.properties = newCar.properties
            car.validate() && car.save()


            respond car
        }
        else {
            respond newCar
        }
    }

    def delete(Long id) {
        def status
        def message

        if (Car.exists(id)) {
            Car.load(id).delete(failOnError: true)
            status = 200
            message="Car with id ${id} was deleted"
        }
        else {
            message="Not Found"
            status = 404
        }

        respond message: message, status: status
    }
}