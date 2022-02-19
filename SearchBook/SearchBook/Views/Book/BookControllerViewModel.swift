//
//  BookControllerViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol BookControllerViewModelProtocol: AnyObject {
    
    func action(type: BookControllerViewModel.ActionType)
}

final class BookControllerViewModel {
    
    init(initalData: InitialData) {
        self.initialData = initalData
    }
    
    let initialData: InitialData
    private(set) var popableHandler: ((BaseNavigationViewModel.Popable) -> Void)?
}

extension BookControllerViewModel: BookControllerViewModelProtocol {
    
    func action(type: ActionType) {
        switch type {
        case .backNavigation:   self.popableHandler?(.book)
        }
    }
    
}

extension BookControllerViewModel: BaseNavigationPopableProtocol {
    
    func bind(popable handler: @escaping (BaseNavigationViewModel.Popable) -> Void) { self.popableHandler = handler }
}

extension BookControllerViewModel {
    
    struct InitialData {
        let isbn13: String
    }
    
    enum ActionType {
        case backNavigation
    }
}
