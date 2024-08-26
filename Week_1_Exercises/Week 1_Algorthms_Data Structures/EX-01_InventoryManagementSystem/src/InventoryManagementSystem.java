import java.util.ArrayList;
import java.util.Iterator;
public class InventoryManagementSystem {
    private ArrayList<Product1> inventory;

    public InventoryManagementSystem() {
        this.inventory = new ArrayList<>();
    }

    public void addProduct(Product1 product) {
        inventory.add(product);
    }

    public void updateProduct(int productId, Product1 updatedProduct) {
        for (int i = 0; i < inventory.size(); i++) {
            if (inventory.get(i).getProductId() == productId) {
                inventory.set(i, updatedProduct);
                return;
            }
        }
        System.out.println("Product not found with ID: " + productId);
    }

    public void deleteProduct(int productId) {
        Iterator<Product1> iterator = inventory.iterator();
        while (iterator.hasNext()) {
            Product1 product = iterator.next();
            if (product.getProductId() == productId) {
                iterator.remove();
                return;
            }
        }
        System.out.println("Product not found with ID: " + productId);
    }

    public void displayInventory() {
        for (Product1 product : inventory) {
            System.out.println(product.getProductId() + " | " + product.getProductName() +
                               " | Quantity: " + product.getQuantity() +
                               " | Price: " + product.getPrice()+"/-");
        }
    }

    public static void main(String[] args) {
        InventoryManagementSystem ims = new InventoryManagementSystem();


        ims.addProduct(new Product1(1, "Item1", 10, 10000.00));
        ims.addProduct(new Product1(2, "Item2", 50, 5000.00));
        ims.addProduct(new Product1(3, "Item3", 20, 20000.00));
        ims.addProduct(new Product1(4, "Item4", 05, 75000.00));
        ims.addProduct(new Product1(5, "Item3", 15, 7000.00));

        System.out.println("Initial Inventory:");
        ims.displayInventory();

        ims.updateProduct(2, new Product1(2, "new_item", 45, 45000.00));

        System.out.println("\nInventory after update:");
        ims.displayInventory();

        ims.deleteProduct(3);

        System.out.println("\nInventory after deletion:");
        ims.displayInventory();
    }
}