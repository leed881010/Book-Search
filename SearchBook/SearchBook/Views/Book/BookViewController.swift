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
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private unowned let viewModel: BookControllerViewModelProtocol
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    private let pagesLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    private let priceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let descLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let urlLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let isbn13Label: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    private let languageLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    private let isbn10Label: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
}

private extension BookViewController {
    
    @objc func navigationBackButtonAction(_ sender: UIButton) {
        self.viewModel.action(type: .backNavigation)
    }
}

private extension BookViewController {
    
    func bind() {
        self.viewModel.bind(book: self.receive(book:))
        self.viewModel.fetchInitialData()
    }
    
    func receive(book: Book) {
        DispatchQueue.main.async {
            self.imageView.update(imageURL: book.imageURL, placeHolderImage: nil)
            self.titleLabel.text = book.title
            self.subtitleLabel.text = book.subtitle
            self.pagesLabel.text =  "page: \(book.pages)"
            self.ratingLabel.text =  "rating: \(book.rating)"
            self.descLabel.text =  "desc: \(book.desc)"
            self.urlLabel.text =  book.url.absoluteString
            self.isbn13Label.text =  "isbn13: \(book.isbn13)"
            self.priceLabel.text =  "price: \(book.price)"
            self.yearLabel.text =  "year: \(book.year)"
            self.publisherLabel.text =  "publisher: \(book.publisher)"
            self.languageLabel.text =  "language: \(book.language)"
            self.authorsLabel.text =  "authors: \(book.authors)"
            self.isbn10Label.text =  "isbn10: \(book.isbn10)"
             
        }
    }
}

private extension BookViewController {
    
    func setupView() {
        self.view.backgroundColor = .white
        self.setupNavigationViewController()
        self.setupContentView()
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
    
    func setupContentView() {
        [self.imageView, self.stackView, self.descLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })
        
        [self.titleLabel, self.subtitleLabel, self.authorsLabel, self.priceLabel, self.ratingLabel, self.pagesLabel, self.urlLabel, self.isbn13Label, self.yearLabel, self.publisherLabel, self.languageLabel, self.isbn10Label]
            .forEach { self.stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            self.imageView.widthAnchor.constraint(equalToConstant: 200.0),
            self.imageView.heightAnchor.constraint(equalToConstant: 200.0),
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.descLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.descLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


