public class EmployeeManagementSystem {
    private Employee[] employees;
    private int size;
    private int capacity;

    public EmployeeManagementSystem(int capacity) {
        this.capacity = capacity;
        this.employees = new Employee[capacity];
        this.size = 0;
    }

    public void addEmployee(Employee employee) {
        if (size == capacity) {
            System.out.println("Employee array is full");
            return;
        }
        employees[size] = employee;
        size++;
    }

    public Employee searchEmployee(int employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId() == employeeId) {
                return employees[i];
            }
        }
        return null;
    }

    public void traverseEmployees() {
        for (int i = 0; i < size; i++) {
            System.out.println(employees[i]);
        }
    }

    public void deleteEmployee(int employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId() == employeeId) {
                employees[i] = employees[size - 1];
                size--;
                return;
            }
        }
        System.out.println("Employee not found with ID: " + employeeId);
    }

    public static void main(String[] args) {
        EmployeeManagementSystem ems = new EmployeeManagementSystem(10);

        ems.addEmployee(new Employee(1, "Anuraaga", "Manager", 60000));
        ems.addEmployee(new Employee(2, "Snigdha", "Developer", 50000));
        ems.addEmployee(new Employee(3, "Sanghamitra", "Analyst", 45000));


        System.out.println("All Employees:");
        ems.traverseEmployees();

        Employee employee = ems.searchEmployee(2);
        if (employee != null) {
            System.out.println("\nEmployee Found: " + employee);
        } else {
            System.out.println("\nEmployee not found");
        }

    
        ems.deleteEmployee(3);
        System.out.println("\nAfter Deletion:");
        ems.traverseEmployees();
    }
}
