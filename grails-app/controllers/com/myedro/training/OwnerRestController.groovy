package com.myedro.training
import grails.converters.JSON
import groovy.json.JsonBuilder

class OwnerRestController {
    static responseFormats = ["json","xml"]

    def index() {
        def ownerList
        def query = Owner.createCriteria()
        ownerList = query.list(max:10, offset:params.offset){
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

        def queryCount = Owner.createCriteria()
        def ownerCount = queryCount.count(){
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

        def json = new JsonBuilder()
        def root = json {
            "cantItems" ownerCount

            "owner" ownerList.collect {item ->
                ["id":item.id,
                 "dni":item.dni,
                 "lastName":item.lastName,
                 "name":item.name,
                 "nationality":item.nationality
                ]
            }
        }

        respond json;
    }

    def show(Integer id) {
        Owner owner = Owner.findById(id)
        JSON.use('Owner'){
            respond owner
        }
    }

    def save(Owner owner) {
        if (!owner.hasErrors()) {
            owner.save()
            respond owner, status: 201
        }
        else {
            respond owner
        }
    }

    def update(Long id, Owner newOwner) {
        if (!newOwner.hasErrors()) {
            def owner = Owner.get(id)

            if (!owner) {
                respond message: "Not found", status: 404
                return
            }

            owner.properties = newOwner.properties
            owner.validate() && owner.save()


            respond owner
        }
        else {
            respond newOwner
        }
    }

    def delete(Long id) {
        def status
        def message

        if (Owner.exists(id)) {
            Owner.load(id).delete(failOnError: true)
            status = 200
            message="Owner with id ${id} was deleted"
        }
        else {
            message="Not Found"
            status = 404
        }

        respond message: message, status: status
    }
}
