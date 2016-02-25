package com.myedro.training

class Car {
    int year
    String make
    String model
    String carPlate

    static belongsTo = [owner : Owner] // Points to the owning object

    static constraints = {
        model size: 1..50, blank: false
        make size: 1..50, blank: false
        year min: 0, max: 9999, blank: false
        carPlate size: 6..6, blank: false
        owner nullable: true
    }

    static mapping = {
        table("VehicleModelYear")
        year column: "year"
        make column: "make"
        model column: "model"
        //owner table: "owner", column: "owner_id"
    }
}
