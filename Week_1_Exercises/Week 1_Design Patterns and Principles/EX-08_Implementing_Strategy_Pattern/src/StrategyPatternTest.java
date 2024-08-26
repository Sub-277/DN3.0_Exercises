public class StrategyPatternTest {
    public static void main(String[] args) {
        PaymentContext paymentContext = new PaymentContext();

        PaymentStrategy creditCardPayment = new CreditCardPayment("1234567890123456", "John Doe", "12/24", "123");
        paymentContext.setPaymentStrategy(creditCardPayment);
        paymentContext.pay(100.00);

        PaymentStrategy payPalPayment = new PayPalPayment("john.doe@example.com", "password123");
        paymentContext.setPaymentStrategy(payPalPayment);
        paymentContext.pay(150.50);
    }
}
