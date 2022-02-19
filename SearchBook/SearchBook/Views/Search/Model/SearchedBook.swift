//
//  BookList.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

class SearchedBook: NSObject {
    
    let imageURL: URL
    let isbn13: String
    let price: String
    let subtitle: String
    let title: String
    let url: URL
    
    init?(searchBook: SearchBook) {
        guard let imageURL = URL(string: searchBook.image),
                let url = URL(string: searchBook.url) else { return nil }
        self.imageURL = imageURL
        self.isbn13 = searchBook.isbn13
        self.price = searchBook.price
        self.subtitle = searchBook.subtitle
        self.title = searchBook.title
        self.url = url
    }
}
