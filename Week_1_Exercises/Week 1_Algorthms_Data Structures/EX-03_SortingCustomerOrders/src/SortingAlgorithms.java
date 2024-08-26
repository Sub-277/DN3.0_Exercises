public class SortingAlgorithms {

    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
                    // Swap orders[j] and orders[j + 1]
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        Order pivot = orders[high];
        int i = (low - 1); 
        for (int j = low; j < high; j++) {
            if (orders[j].getTotalPrice() < pivot.getTotalPrice()) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }
        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;
        return i + 1;
    }

    public static void main(String[] args) {
        Order[] orders = {
            new Order(1, "Alice", 250.50),
            new Order(2, "Bob", 125.75),
            new Order(3, "Charlie", 450.25),
            new Order(4, "David", 300.00),
            new Order(5, "Eve", 200.00)
        };

        System.out.println("Original Orders:");
        printOrders(orders);

        bubbleSort(orders);
        System.out.println("\nOrders sorted by Bubble Sort:");
        printOrders(orders);

        Order[] ordersForQuickSort = {
            new Order(1, "Alice", 250.50),
            new Order(2, "Bob", 125.75),
            new Order(3, "Charlie", 450.25),
            new Order(4, "David", 300.00),
            new Order(5, "Eve", 200.00)
        };
        quickSort(ordersForQuickSort, 0, ordersForQuickSort.length - 1);
        System.out.println("\nOrders sorted by Quick Sort:");
        printOrders(ordersForQuickSort);
    }

    private static void printOrders(Order[] orders) {
        for (Order order : orders) {
            System.out.println(order.getOrderId() + " | " + order.getCustomerName() + " | " + order.getTotalPrice());
        }
    }
}
