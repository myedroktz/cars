package com.myedro.training

import wslite.rest.ContentType
import wslite.rest.RESTClient

class OwnerController {
    static scaffold = true

    def restClient = new RESTClient("http://localhost:8080/cars/api/owner")
    def ownerList

    def searchForm(){
        ownerList = Owner.list()
        [ownerList : ownerList]
    }

    def searchAjax(){
        if(params.inlineRadioOptions == "JSON"){
            def response = restClient.get(path: "/${params.id ? params.id : ""}", accept: ContentType.JSON, query: [make: params.make, model: params.model, year: params.year])
            render response.json
        }else{
            def response = restClient.get(path: "?name=${params.name}&lastName=${params.lastName}&nationality=${params.nationality}&dni=${params.dni}", accept: ContentType.JSON)
            //ownerList = response.json
            ownerList = Owner.list()
            render(template: 'ownerTableRow', collection: ownerList, var:'owner')
        }
    }

    def bindToPopup(){
        def owner = Owner.findById(params.id.toInteger())
        render(template: 'formPopup', model:[owner : owner])
    }
}