public class AdapterPatternTest {
    public static void main(String[] args) {
        GpayPayment gpay = new GpayPayment();
        PhonePePayment phonePe = new PhonePePayment();

        PaymentProcessor gpayAdapter = new GpayAdapter(gpay);
        PaymentProcessor phonePeAdapter = new PhonePeAdapter(phonePe);

        System.out.println("Using Gpay Adapter:");
        gpayAdapter.processPayment(150.0);

        System.out.println("Using PhonePe Adapter:");
        phonePeAdapter.processPayment(250.0);
    }
}
