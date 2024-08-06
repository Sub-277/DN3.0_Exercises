public class CustomerRepositoryImpl implements CustomerRepository {
    @Override
    public Customer findCustomerById(String customerId) {
        return new Customer(customerId, "Subarna Paul", "paulsubarna@gmail.com");
    }
}
