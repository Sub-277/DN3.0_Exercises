public class DependencyInjectionTest {
    public static void main(String[] args) {
        CustomerRepository customerRepository = new CustomerRepositoryImpl();

        CustomerService customerService = new CustomerService(customerRepository);

        Customer customer = customerService.getCustomerDetails("1");

        System.out.println("Customer ID: " + customer.getId());
        System.out.println("Customer Name: " + customer.getName());
        System.out.println("Customer Email: " + customer.getEmail());
    }
}
