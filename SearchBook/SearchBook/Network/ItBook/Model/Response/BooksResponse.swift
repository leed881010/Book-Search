//
//  BooksResponse.swift
//  NetworkKit
//
//  Created by USER on 2022/02/18.
//

import Foundation

struct BooksResponse: Decodable {
    
    let pages: String
    let image: String
    let rating: String
    let desc: String
    let url: String
    let subtitle: String
    let isbn13: String
    let price: String
    let year: String
    let title: String
    let publisher: String
    let language: String
    let authors: String
    let isbn10: String
}
