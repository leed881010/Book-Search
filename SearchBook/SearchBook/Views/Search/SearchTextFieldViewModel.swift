//
//  SearchTextFieldViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol SearchTextFieldViewModelProtocol: AnyObject {
    
    func action(_ type: SearchTextFieldViewModel.ActionType)
}

protocol QuerySearchable: AnyObject {
    
    var query: String { get }
    
    var queryHandler: ((String) -> Void)? { get }
    func bind(query handler: @escaping (String) -> Void)
}


final class SearchTextFieldViewModel {
    
    private(set) var query: String = "" {
        didSet {
            self.queryHandler?(self.query)
        }
    }
    private(set) var queryHandler: ((String) -> Void)?
    
}

extension SearchTextFieldViewModel: SearchTextFieldViewModelProtocol {
    
    func action(_ type: SearchTextFieldViewModel.ActionType) {
        switch type {
        case .search(let query): self.query = query
        }
    }
}

extension SearchTextFieldViewModel: QuerySearchable {
    
    func bind(query handler: @escaping (String) -> Void) { self.queryHandler = handler }
    
}

extension SearchTextFieldViewModel {
    
    enum ActionType {
        case search(String)
    }
}
