public class PayPalPayment implements PaymentStrategy {
    public PayPalPayment(String email, String password) {
    }

    @Override
    public void pay(double amount) {
        System.out.println("Paying Rs." + amount + "/- using PayPal.");
    }
}
