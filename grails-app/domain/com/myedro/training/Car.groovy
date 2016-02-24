package com.myedro.training

class Car {
    int year
    String make
    String model

    static constraints = {
        model size: 1..50, blank: false
        make size: 1..50, blank: false
        year min: 0, max: 9999, blank: false
    }

    static mapping = {
        table("VehicleModelYear")
        year column: "year"
        make column: "make"
        model column: "model"
    }
}
