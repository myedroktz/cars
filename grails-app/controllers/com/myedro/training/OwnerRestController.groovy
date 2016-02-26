package com.myedro.training
import grails.converters.JSON

class OwnerRestController {
    static responseFormats = ["json","xml"]

    def index() {
        def ownerList
        def query = Owner.createCriteria()
        ownerList = query.list(){
            and{
                if(params.name){
                    like("name", params.name+'%')
                }
                if(params.lastName){
                    like("lastName", params.lastName+'%')
                }
                if(params.nationality){
                    like("nationality", params.nationality+'%')
                }
                if(params.dni){
                    def dniIni = params.dni.padRight(8,'0').toInteger()
                    def dniEnd = params.dni.padRight(8,'0').toInteger() + 10**(8 - params.dni.length()) - 1
                    between("dni", dniIni, dniEnd)
                }
            }
        }
        JSON.use('Owner') {
            respond ownerList
        }
    }

    def show(Integer id) {
        Owner owner = Owner.findById(id)
        JSON.use('Owner'){
            respond owner
        }
    }

}
