package com.myedro.training

import grails.rest.RestfulController

class CarRestController extends RestfulController{
    static responseFormats = ["json","xml"]

    def CarRestController() {
        super(Car)
    }

    def all(){
        respond Car.list()
    }
}
