public class FinancialForecasting {
    public static double calculateFutureValue(double presentValue, double growthRate, int years) {
        if (years == 0) {
            return presentValue;
        }
        return calculateFutureValue(presentValue * (1 + growthRate), growthRate, years - 1);
    }

    public static void main(String[] args) {
        double presentValue = 1000.0;
        double annualGrowthRate = 0.05;
        int years = 10;

        double futureValue = calculateFutureValue(presentValue, annualGrowthRate, years);
        System.out.println("Future Value after " + years + " years: " + futureValue);
    }
}