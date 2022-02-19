//
//  BookViewController.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

final class BookViewController: UIViewController {
    
    init(viewModel: BookControllerViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private unowned let viewModel: BookControllerViewModelProtocol
}

private extension BookViewController {
    
    @objc func navigationBackButtonAction(_ sender: UIButton) {
        self.viewModel.action(type: .backNavigation)
    }
}

private extension BookViewController {
    
    func setupView() {
        self.view.backgroundColor = .white
        self.setupNavigationViewController()
    }
    
    func setupNavigationViewController() {
        let backBarButton: UIBarButtonItem = {
            let backButton: UIButton = .init(type: .custom)
            backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(.systemBlue, for: .normal)
            backButton.addTarget(self, action: #selector(self.navigationBackButtonAction(_:)), for: .touchUpInside)
            return UIBarButtonItem(customView: backButton)
        }()
        self.navigationItem.leftBarButtonItem = backBarButton
    }
}
