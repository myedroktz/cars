import com.myedro.training.*
import org.apache.commons.lang.RandomStringUtils
import grails.converters.*
class BootStrap {

    def init = { servletContext ->
        //assignRandomCarPlatesToCars()
        /**
         * Creates a JSON config for Car that retrieves the Owner (but excludes his owned cars)
         */
        JSON.createNamedConfig("Car") { cfg ->
            cfg.registerObjectMarshaller(Car) { Car car ->
                return [ class: Car.name,//'com.myedro.training.Car',
                         id: car.id,
                         make: car.make,
                         model: car.model,
                         year: car.year,
                         carPlate: car.carPlate,
                         owner:[
                             class: Owner.name, //'com.myedro.training.Owner',
                             id: car.owner.id,
                             name: car.owner.name,
                             lastName: car.owner.lastName,
                             dni: car.owner.dni,
                             nationality: car.owner.nationality
                         ]
                ]
            }
        }

        JSON.createNamedConfig("Owner") { cfg ->
            cfg.registerObjectMarshaller(Owner) { Owner owner ->
                return [ class: Owner.name, //'com.myedro.training.Owner',
                         id: owner.id,
                         name: owner.name,
                         lastName: owner.lastName,
                         dni: owner.dni,
                         nationality: owner.nationality
                 ]
            }
        }
    }
    def destroy = {
    }



    /**
     * Update all cars in database with a new random car plate
     */
    def assignRandomCarPlatesToCars(){
        Car.list().each{
            it.carPlate = generateRandomCarPlate()
            it.save(failOnError: true)
            println(it.id + " " + it.carPlate)
        }
    }

    /**
     * @return a random argentinian car plate
     */
    def generateRandomCarPlate(){
        int randomStringLength = 3
        String charsetLetters = ('A'..'Z').join()
        String charsetNumbers = ('0'..'9').join()
        String randomStringLetters = RandomStringUtils.random(randomStringLength, charsetLetters.toCharArray())
        String randomStringNumbers = RandomStringUtils.random(randomStringLength, charsetNumbers.toCharArray())

        return (randomStringLetters + randomStringNumbers)
    }
}
