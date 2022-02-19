//
//  SearchControllerViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

protocol BookListTableViewModel: AnyObject {
    
    var numberOfRows: Int { get }
    var heightForRow: CGFloat { get }
    
    func book(for indexPath: IndexPath) -> Book
    func didSelectRow(at indexPath: IndexPath)
    func willDisplay(forRowAt indexPath: IndexPath)
}

protocol SearchControllerViewModelProtocol: AnyObject {
    
    var booksHandler: (([Book]) -> Void)? { get }
    func bind(books handler: @escaping ([Book]) -> Void)
}

final class SearchControllerViewModel {
    
    let searchTextFieldViewModel: SearchTextFieldViewModel = .init()
    
    init() {
        self.bind()
    }
    
    private var itbookAPIConnector: ItBookAPIConnectorProtocol { NetworkDispatcher.shared.itbookAPIConnector }
    private var searchFactor: SearchFactor? {
        didSet {
            self.searchFactor.map { self.didUpdate(searchFactor: $0) }
        }
    }
    
    
    private var books: [Book] = []
    private(set) var booksHandler: (([Book]) -> Void)?
}

private extension SearchControllerViewModel {
    
    func didUpdate(searchFactor: SearchFactor) {
        if searchFactor.isNew {
            self.books.removeAll()
        }
        self.search(factor: searchFactor)
    }
    
    func search(factor: SearchFactor) {
        let searchRequest: SearchRequest = .init(searchFactor: factor)
        DispatchQueue.global(qos: .background).async {
            self.itbookAPIConnector.search(request: searchRequest) { [weak self] response, error in
                if let error = error {
                    
                } else if let response = response {
                    let books = response.books.compactMap { Book(searchBook: $0) }
                    self?.books.append(contentsOf: books)
                    self?.booksHandler?(books)
                }
            }
        }
    }
}

private extension SearchControllerViewModel {
    
    func bind() {
        self.bind(querySearchable: self.searchTextFieldViewModel)
    }
    
    func bind(querySearchable: QuerySearchable) {
        querySearchable.bind(query: self.receive(query:))
    }
    
    func receive(query: String) {
        self.searchFactor = SearchFactor(query: query)
    }
    
}

extension SearchControllerViewModel: BookListTableViewModel {
    
    var numberOfRows: Int { self.books.count }
    var heightForRow: CGFloat { 120.0 }
    
    func book(for indexPath: IndexPath) -> Book {
        return self.books[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
    }
    
    func willDisplay(forRowAt indexPath: IndexPath) {
        guard indexPath.row + 1 == self.books.count,
              let searchFactor = self.searchFactor else { return }
        
        searchFactor.next()
        self.didUpdate(searchFactor: searchFactor)
    }
}


extension SearchControllerViewModel: SearchControllerViewModelProtocol {
    
    func bind(books handler: @escaping ([Book]) -> Void) { self.booksHandler = handler }
}

extension SearchControllerViewModel {
    
    class SearchFactor {
        
        let query: String
        var page: Int
        var isNew: Bool { return self.page == 1}
        
        init(query: String) {
            self.query = query
            self.page = 1
        }
        
        func next() {
            self.page += 1
        }
    }
}
