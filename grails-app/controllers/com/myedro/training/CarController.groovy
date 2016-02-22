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
            def response = restClient.get(path: "/${params.id ? params.id : ""}", accept: ContentType.JSON, query: [make: params.make, model: params.model, year: params.year])
            //Car car = response.json[0]
            render response.json

            /*  Using API /
            if(params.id){
                redirect(controller: "CarRest", action: "show", params: [id: params.id])
            }else{
                redirect(controller: "CarRest", action: "index", params: [make: params.make, model: params.model, year: params.year])
            }
            */
        }else{
            def response = restClient.get(path: "/", accept: ContentType.JSON, query: [make: params.make, model: params.model, year: params.year])
            carList = response.json
            render (template: 'carSearchResult', collection : carList, var:"car")
            //[carList : carList]
        }
    }
}
