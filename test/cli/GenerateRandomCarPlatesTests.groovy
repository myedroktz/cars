import grails.test.AbstractCliTestCase

class GenerateRandomCarPlatesTests extends AbstractCliTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateRandomCarPlates() {

        execute(["generate-random-car-plates"])

        assertEquals 0, waitForProcess()
        verifyHeader()
    }
}
