public class CustomerService {
    private CustomerRepository customerRepository;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public Customer getCustomerDetails(String customerId) {
        return customerRepository.findCustomerById(customerId);
    }
}
