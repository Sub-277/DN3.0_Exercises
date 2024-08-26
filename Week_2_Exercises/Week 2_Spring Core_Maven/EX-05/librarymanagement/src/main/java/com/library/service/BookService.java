package com.library.service;

import com.library.repository.BookRepository;

public class BookService {
    
    @SuppressWarnings("unused")
    private BookRepository bookRepository;

    // Setter method for BookRepository
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void displayService() {
        System.out.println("BookService is working with BookRepository.");
    }
}
