@IsTest
private class InvoiceCalculatorTest {

    @IsTest
    static void testCalculate_WithTaxAndDiscount() {
        Test.startTest();
        InvoiceCalculator.InvoiceResult res =
            InvoiceCalculator.calculate(200, 10, 18); // subtotal 200, discount 20 => 180, tax 32.4 => total 212.4
        Test.stopTest();

        System.assertEquals(200.00, res.subtotal, 'Subtotal mismatch');
        System.assertEquals(20.00, res.discountAmount, 'Discount mismatch');
        System.assertEquals(32.40, res.taxAmount, 'Tax mismatch');
        System.assertEquals(212.40, res.total, 'Total mismatch');
    }

    @IsTest
    static void testCalculate_TaxZeroBranch() {
        InvoiceCalculator.InvoiceResult res = InvoiceCalculator.calculate(100, 5, 0);

        System.assertEquals(100.00, res.subtotal);
        System.assertEquals(5.00, res.discountAmount);
        System.assertEquals(0.00, res.taxAmount, 'Tax should be 0 when taxPct = 0');
        System.assertEquals(95.00, res.total);
    }

    @IsTest
    static void testCalculate_HandlingFeeBranch() {
        // Make total < 10 to trigger handling fee (+1)
        // subtotal 9, discount 0 => 9, tax 0 => 9 => handling fee => 10
        InvoiceCalculator.InvoiceResult res = InvoiceCalculator.calculate(9, 0, 0);

        System.assertEquals(9.00, res.subtotal);
        System.assertEquals(0.00, res.discountAmount);
        System.assertEquals(0.00, res.taxAmount);
        System.assertEquals(10.00, res.total, 'Handling fee should apply when total is between 0 and 10');
    }

    @IsTest
    static void testValidate_BaseAmountNegative_Throws() {
        try {
            InvoiceCalculator.calculate(-1, 0, 0);
            System.assert(false, 'Expected exception was not thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Base amount must be zero or positive.'));
        }
    }

    @IsTest
    static void testValidate_DiscountOutOfRange_Throws() {
        try {
            InvoiceCalculator.calculate(10, 200, 0);
            System.assert(false, 'Expected exception was not thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Discount percent must be between 0 and 100.'));
        }
    }

    @IsTest
    static void testValidate_TaxOutOfRange_Throws() {
        try {
            InvoiceCalculator.calculate(10, 0, 101);
            System.assert(false, 'Expected exception was not thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Tax percent must be between 0 and 100.'));
        }
    }
}