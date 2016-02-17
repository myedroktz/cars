package com.myedro.training

class Car {
    int year
    String make
    String model

    static constraints = {
    }

    static mapping = {
        table("VehicleModelYear")
        year column: "year"
        make column: "make"
        model column: "model"
    }
}
