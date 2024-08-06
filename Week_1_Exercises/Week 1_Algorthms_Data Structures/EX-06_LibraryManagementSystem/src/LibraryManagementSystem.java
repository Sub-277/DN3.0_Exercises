import java.util.Arrays;

public class LibraryManagementSystem {
    private Book[] books;
    private int size;

    public LibraryManagementSystem(int capacity) {
        this.books = new Book[capacity];
        this.size = 0;
    }

    public void addBook(Book book) {
        if (size == books.length) {
            System.out.println("Library is full");
            return;
        }
        books[size] = book;
        size++;
    }

    public Book linearSearchByTitle(String title) {
        for (int i = 0; i < size; i++) {
            if (books[i].getTitle().equalsIgnoreCase(title)) {
                return books[i];
            }
        }
        return null;
    }

    public Book binarySearchByTitle(String title) {
        int low = 0, high = size - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            int compare = books[mid].getTitle().compareToIgnoreCase(title);
            if (compare == 0) {
                return books[mid];
            } else if (compare < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }

    public void sortBooksByTitle() {
        Arrays.sort(books, 0, size, (b1, b2) -> b1.getTitle().compareToIgnoreCase(b2.getTitle()));
    }

    public static void main(String[] args) {
        LibraryManagementSystem library = new LibraryManagementSystem(10);

        library.addBook(new Book(1, "The Catcher in the Rye", "J.D. Salinger"));
        library.addBook(new Book(2, "To Kill a Mockingbird", "Harper Lee"));
        library.addBook(new Book(3, "1984", "George Orwell"));
        library.addBook(new Book(4, "The Great Gatsby", "F. Scott Fitzgerald"));

        System.out.println("Linear Search:");
        Book book = library.linearSearchByTitle("1984");
        if (book != null) {
            System.out.println("Book found: " + book);
        } else {
            System.out.println("Book not found");
        }

        library.sortBooksByTitle();
        System.out.println("\nBinary Search:");
        book = library.binarySearchByTitle("1984");
        if (book != null) {
            System.out.println("Book found: " + book);
        } else {
            System.out.println("Book not found");
        }
    }
}