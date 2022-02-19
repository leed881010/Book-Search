//
//  BaseNavigationProtocol.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol BaseNavigationPushableProtocol: AnyObject {
    
    var pushableHandler: ((BaseNavigationViewModel.Pushable) -> Void)? { get }
    func bind(pushable handler: @escaping (BaseNavigationViewModel.Pushable) -> Void)
}

protocol BaseNavigationPopableProtocol: AnyObject {
    
    var popableHandler: ((BaseNavigationViewModel.Popable) -> Void)? { get }
    func bind(popable handler: @escaping (BaseNavigationViewModel.Popable) -> Void)
}
