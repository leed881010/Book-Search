//
//  Book.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

struct Book {
    
    let pages: String
    let imageURL: URL
    let rating: String
    let desc: String
    let url: URL
    let subtitle: String
    let isbn13: String
    let price: String
    let year: String
    let title: String
    let publisher: String
    let language: String
    let authors: String
    let isbn10: String
    
    init?(bookResponse: BooksResponse) {
        guard let imageURL = URL(string: bookResponse.image),
                let url = URL(string: bookResponse.url) else { return nil }
        
        self.pages = bookResponse.pages
        self.imageURL = imageURL
        self.rating = bookResponse.rating
        self.desc = bookResponse.desc
        self.url = url
        self.subtitle = bookResponse.subtitle
        self.isbn13 = bookResponse.isbn13
        self.price = bookResponse.price
        self.year = bookResponse.year
        self.title = bookResponse.title
        self.publisher = bookResponse.publisher
        self.language = bookResponse.language
        self.authors = bookResponse.authors
        self.isbn10 = bookResponse.isbn10
    }
    
}
