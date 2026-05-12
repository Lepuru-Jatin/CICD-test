// v1-initial comments
public with sharing class DemoCalculator {
    
public static void basicDependency() {
        Account acc = new Account();
        acc.Deploy_Check_Number__c = 10;
    }

    // Simple method to demo deployments + tests
    public static Integer add(Integer a, Integer b) {
        if (a == null || b == null) {
            throw new IllegalArgumentException('Inputs cannot be null');
        }
        return a + b;
    }

    public static Integer multiply(Integer a, Integer b) {
        if (a == null || b == null) {
            throw new IllegalArgumentException('Inputs cannot be null');
        }
        return a * b;
    }
}