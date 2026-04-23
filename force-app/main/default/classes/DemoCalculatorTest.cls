@IsTest
private class DemoCalculatorTest {

    @IsTest
    static void testAddPositiveNumbers() {
        // Covers normal add path
        Integer result = DemoCalculator.add(5, 7);
        System.assertEquals(12, result, 'Add should return correct sum');
    }

    @IsTest
    static void testAddNegativeNumbers() {
        // Covers add with negative values
        Integer result = DemoCalculator.add(-5, -7);
        System.assertEquals(-12, result, 'Add should work with negatives');
    }

    @IsTest
    static void testMultiplyPositiveNumbers() {
        // Covers normal multiply path
        Integer result = DemoCalculator.multiply(3, 4);
        System.assertEquals(12, result, 'Multiply should return correct product');
    }

    @IsTest
    static void testMultiplyWithZero() {
        // Covers multiply with zero case
        Integer result = DemoCalculator.multiply(10, 0);
        System.assertEquals(0, result, 'Multiply by zero should be zero');
    }

    @IsTest
    static void testAddNullThrowsException() {
        // Covers exception path in add()
        try {
            DemoCalculator.add(null, 1);
            System.assert(false, 'Expected exception not thrown');
        } catch (IllegalArgumentException e) {
            System.assert(
                e.getMessage().contains('Inputs cannot be null'),
                'Exception message should be correct'
            );
        }
    }

    @IsTest
    static void testMultiplyNullThrowsException() {
        // Covers exception path in multiply()
        try {
            DemoCalculator.multiply(1, null);
            System.assert(false, 'Expected exception not thrown');
        } catch (IllegalArgumentException e) {
            System.assert(
                e.getMessage().contains('Inputs cannot be null'),
                'Exception message should be correct'
            );
        }
    }
}
