package com.myedro.training

class CarController {
    static scaffold = true


    def searchForm(){

    }

    def search(){
        if(params.id){
            redirect(controller: "CarRest", action: "show", params: [id: params.id])
        }else{
            redirect(controller: "CarRest", action: "index", params: [make: params.make, model: params.model, year: params.year])
        }
    }
}
