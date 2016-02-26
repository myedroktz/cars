class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
        
        //UrlMapping to carRestController
        "/api"(resources: "carRest")

        "/api/owner"(resources: "ownerRest")

    }
}
