public class Main {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        System.out.println("Are logger1 and logger2 the same instance? " + (logger1 == logger2));

        logger1.log("Logging information message 1");
        logger2.log("Logging information message 2");
    }
}