import java.util.Arrays;

public class SearchAlgorithms {
    
    public static Product linearSearch(Product[] products, int productId) {
        for (Product product : products) {
            if (product.getProductId() == productId) {
                return product;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int productId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (products[mid].getProductId() == productId) {
                return products[mid];
            } else if (products[mid].getProductId() < productId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Mouse", "Electronics"),
            new Product(3, "Keyboard", "Electronics"),
            new Product(4, "Monitor", "Electronics"),
            new Product(5, "Phone", "Electronics")
        };
        
        Arrays.sort(products, (a, b) -> Integer.compare(a.getProductId(), b.getProductId()));

        Product foundProduct = linearSearch(products, 3);
        if (foundProduct != null) {
            System.out.println("Linear Search Found: " + foundProduct.getProductName());
        } else {
            System.out.println("Linear Search: Product not found");
        }

        foundProduct = binarySearch(products, 3);
        if (foundProduct != null) {
            System.out.println("Binary Search Found: " + foundProduct.getProductName());
        } else {
            System.out.println("Binary Search: Product not found");
        }
    }
}