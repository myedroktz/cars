package com.myedro.training


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
        carList = query.list{
            and{
                if(params.make){
                    eq("make", params.make)
                }
                if(params.model){
                    eq("model", params.model)
                }
                if(params.year){
                    eq("year", params.year.toInteger())
                }
            }
        }
        respond carList
    }

    def show(Integer id) {
        respond Car.findById(id)
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
            Car.load(id).delete()
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