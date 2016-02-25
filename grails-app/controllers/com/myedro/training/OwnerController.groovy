package com.myedro.training

class OwnerController {
    static scaffold = true

    def searchForm(){
        def ownerList = Owner.list()
        [ownerList : ownerList]
    }
}
