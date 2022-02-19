//
//  BaseNavigationController.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    init(viewModel: BaseNavigationViewModel) {
        let rootViewController: SearchViewController = .init(viewModel: viewModel.rootViewModel)
        self.rootViewController = rootViewController
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let rootViewController: SearchViewController
}
