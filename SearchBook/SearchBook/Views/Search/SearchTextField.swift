//
//  SearchTextField.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

final class SearchTextField: UIView {
    
    
    init(viewModel: SearchTextFieldViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: SearchTextFieldViewModel
    
    private lazy var textField: UITextField = {
        let textField: UITextField = .init()
        textField.returnKeyType = .search
        textField.delegate = self
        textField.placeholder = "검색어를 입력하세요."
        return textField
    }()
}

private extension SearchTextField {
    
    func setupView() {
        self.backgroundColor = .lightGray
        [self.textField].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0),
        ])
        self.textField.becomeFirstResponder()
    }
    
}

extension SearchTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text.map { self.viewModel.action(.search($0)) }
        return true
    }
    
}
