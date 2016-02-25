import com.myedro.training.*
import org.apache.commons.lang.RandomStringUtils

class BootStrap {

    def init = { servletContext ->
        //assignRandomCarPlatesToCars()

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
