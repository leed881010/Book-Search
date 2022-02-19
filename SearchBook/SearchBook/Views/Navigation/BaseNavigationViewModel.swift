//
//  BaseNavigationViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

protocol BaseNavigationViewModelProtocol: AnyObject {
    
    var rootViewModel: SearchControllerViewModel { get }
}

final class BaseNavigationViewModel: BaseNavigationViewModelProtocol {
    
    let rootViewModel: SearchControllerViewModel = .init()
    
}
