package com.library.service;

import com.library.repository.BookRepository;

public class BookService {
    
    private BookRepository bookRepository;

    // Setter for bookRepository
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    // Business logic methods can be added here
    public void displayService() {
        System.out.println("BookService is up and running.");
        if (bookRepository != null) {
            bookRepository.displayRepository();
        } else {
            System.out.println("BookRepository is not injected.");
        }
    }
}