public with sharing class InvoiceCalculator {

    public class InvoiceResult {
        @AuraEnabled public Decimal subtotal;
        @AuraEnabled public Decimal discountAmount;
        @AuraEnabled public Decimal taxAmount;
        @AuraEnabled public Decimal total;

        public InvoiceResult(Decimal subtotal, Decimal discountAmount, Decimal taxAmount, Decimal total) {
            this.subtotal = subtotal;
            this.discountAmount = discountAmount;
            this.taxAmount = taxAmount;
            this.total = total;
        }
    }

    /**
     * Calculates final invoice total.
     * @param baseAmount  - Must be >= 0
     * @param discountPct - 0 to 100
     * @param taxPct      - 0 to 100
     */
    public static InvoiceResult calculate(Decimal baseAmount, Decimal discountPct, Decimal taxPct) {
        validate(baseAmount, discountPct, taxPct);

        Decimal subtotal = baseAmount.setScale(2);
        Decimal discountAmount = (subtotal * (discountPct / 100)).setScale(2);
        Decimal afterDiscount = (subtotal - discountAmount).setScale(2);

        // Branch 1: If taxPct is 0, taxAmount stays 0
        Decimal taxAmount = 0;
        if (taxPct > 0) {
            taxAmount = (afterDiscount * (taxPct / 100)).setScale(2);
        }

        // Branch 2: apply small handling fee when total is very small (example rule)
        Decimal total = (afterDiscount + taxAmount).setScale(2);
        if (total > 0 && total < 10) {
            total = (total + 1).setScale(2); // handling fee
        }

        return new InvoiceResult(subtotal, discountAmount, taxAmount, total);
    }

    private static void validate(Decimal baseAmount, Decimal discountPct, Decimal taxPct) {
        if (baseAmount == null || baseAmount < 0) {
            throw new IllegalArgumentException('Base amount must be zero or positive.');
        }
        if (discountPct == null || discountPct < 0 || discountPct > 100) {
            throw new IllegalArgumentException('Discount percent must be between 0 and 100.');
        }
        if (taxPct == null || taxPct < 0 || taxPct > 100) {
            throw new IllegalArgumentException('Tax percent must be between 0 and 100.');
        }
    }
}