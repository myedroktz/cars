package com.myedro.training

class Car {
    int year
    String make
    String model
    String carPlate // 'carPlate' es redundante, si 'plate' está dentro de car, se sobreentiende que es del auto.

    static belongsTo = [owner : Owner] // Points to the owning object

    static constraints = {
        model size: 1..50, blank: false
        make size: 1..50, blank: false
        year min: 0, max: 9999, blank: false
        carPlate size: 6..6, blank: false, matches: /^[A-Z]{3}[0-9]{3}$/
        owner nullable: true
    }

    static mapping = {
        table("VehicleModelYear")
        carPlate column: "plate"
    }
}
