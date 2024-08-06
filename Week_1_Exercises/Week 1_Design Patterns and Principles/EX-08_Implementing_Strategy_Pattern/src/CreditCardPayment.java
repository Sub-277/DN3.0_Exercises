public class CreditCardPayment implements PaymentStrategy {
    @SuppressWarnings("unused")
    private String cardCVV;

    public CreditCardPayment(String cardNumber, String cardHolderName, String cardExpiry, String cardCVV) {
        this.cardCVV = cardCVV;
    }

    @Override
    public void pay(double amount) {
        System.out.println("Paying Rs." + amount + "/- using Credit Card.");
    }
}
