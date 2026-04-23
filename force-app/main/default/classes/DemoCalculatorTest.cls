@IsTest
private class DemoCalculatorTest {

    @IsTest
    static void testAdd() {
        Integer result = DemoCalculator.add(5, 7);
        System.assertEquals(12, result, 'Add should return correct sum');
    }

    @IsTest
    static void testMultiply() {
        Integer result = DemoCalculator.multiply(3, 4);
        System.assertEquals(12, result, 'Multiply should return correct product');
    }

    @IsTest
    static void testNullInputsThrowException() {
        try {
            DemoCalculator.add(null, 1);
            System.assert(false, 'Expected exception not thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Inputs cannot be null'));
        }
    }
}