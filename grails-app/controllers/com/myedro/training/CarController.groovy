package com.myedro.training

import wslite.rest.ContentType
import wslite.rest.RESTClient

class CarController {
    static scaffold = true

    def restClient = new RESTClient("http://localhost:8080/cars/api")
    def carList

    def searchForm(){
        [carList : carList]
    }

    def searchAjax(){
        if(params.inlineRadioOptions == "JSON"){
            def response = restClient.get(path: "/${params.id ? params.id : ""}", accept: ContentType.JSON, query: [make: params.make, model: params.model, year: params.year, owner: params.owner])
            //Car car = response.json[0]
            render response.json
        }else{
            //def response = restClient.get(path: "/", accept: ContentType.JSON, query: [make: params.make, model: params.model, year: params.year])
            def response = restClient.get(path: "?make=${params.make}&model=${params.model}&year=${params.year}&offset=${params.offset}", accept: ContentType.JSON)
            carList = response.json
            render (template: 'carTableRow', collection : carList, var:"car")
        }
    }

    def bindToPopup(){
        def car = Car.findById(params.id.toInteger())
        render(template: 'formPopup', model:[car : car])
    }
}

