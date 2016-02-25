package com.myedro.training

class Owner {
    //DNI, Nombre, Apellido, Nacionalidad, y Autos(Ver Link)
    Integer dni
    String name
    String lastName
    String nationality

    static hasMany = [cars : Car]

    static constraints = {
        cars nullable: true
        dni min:0, max:2147483647
        name size: 1..50
        lastName size: 1..50
        nationality size: 1..50
    }
}