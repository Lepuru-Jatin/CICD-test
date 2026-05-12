//1
public with sharing class DemoCalculator {
    


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