public class GpayAdapter implements PaymentProcessor {
    private GpayPayment gpayPayment;

    public GpayAdapter(GpayPayment gpayPayment) {
        this.gpayPayment = gpayPayment;
    }

    @Override
    public void processPayment(double amount) {
        gpayPayment.payWithGpay(amount);
    }
}