public class PhonePeAdapter implements PaymentProcessor {
    private PhonePePayment phonePePayment;

    public PhonePeAdapter(PhonePePayment phonePePayment) {
        this.phonePePayment = phonePePayment;
    }

    @Override
    public void processPayment(double amount) {
        phonePePayment.payWithPhonePe(amount);
    }
}