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
    private var books: [Book] = []
    private(set) var booksHandler: (([Book]) -> Void)?
    private(set) var pushableHandler: ((BaseNavigationViewModel.Pushable) -> Void)?
    private let searchFactorUpdater: SearchFactorUpdater = .init()
}

private extension SearchControllerViewModel {
    
    func update(newBooks: [Book]) {
        self.books.append(contentsOf: newBooks)
        self.booksHandler?(self.books)
    }
    
    func fetch(search request: SearchRequest) {
        DispatchQueue.global(qos: .background).async {
            self.itbookAPIConnector.search(request: request) { [weak self] response, error in
                if let error = error {
                    print("error: \(error.message)")
                } else if let response = response {
                    let books = response.books.compactMap { Book(searchBook: $0) }
                    books.isEmpty ? self?.searchFactorUpdater.update(isLast: true) : self?.update(newBooks: books)
                }
            }
        }
    }
}

private extension SearchControllerViewModel {
    
    func bind() {
        self.bind(searchFactorUpdater: self.searchFactorUpdater)
        self.bind(querySearchable: self.searchTextFieldViewModel)
    }
    
    func bind(querySearchable: QuerySearchable) {
        querySearchable.bind(query: self.receive(query:))
    }
    
    func bind(searchFactorUpdater: SearchFactorUpdaterProtocol) {
        searchFactorUpdater.bind(searchRequest: self.receive(searchRequest:))
    }
    
    func receive(searchRequest: SearchRequest?) {
        searchRequest.map { self.fetch(search: $0) }
    }
    
    func receive(query: String) {
        self.books.removeAll()
        self.searchFactorUpdater.update(query: query)
    }
    
}

extension SearchControllerViewModel: BookListTableViewModel {
    
    var numberOfRows: Int { self.books.count }
    var heightForRow: CGFloat { 120.0 }
    
    func book(for indexPath: IndexPath) -> Book {
        return self.books[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let book = self.book(for: indexPath)
        let viewModel: BookControllerViewModel = .init(initalData: BookControllerViewModel.InitialData(isbn13: book.isbn13))
        self.pushableHandler?(.book(viewModel))
    }
    
    func willDisplay(forRowAt indexPath: IndexPath) {
        guard indexPath.row + 1 == self.books.count else { return }
        self.searchFactorUpdater.next()
    }
}


extension SearchControllerViewModel: SearchControllerViewModelProtocol {
    
    func bind(books handler: @escaping ([Book]) -> Void) { self.booksHandler = handler }
}

extension SearchControllerViewModel: BaseNavigationPushableProtocol {
    
    func bind(pushable handler: @escaping (BaseNavigationViewModel.Pushable) -> Void) { self.pushableHandler = handler }
}
