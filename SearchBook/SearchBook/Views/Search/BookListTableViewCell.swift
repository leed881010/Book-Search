//
//  BookListTableViewCell.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

final class BookListTableViewCell: UITableViewCell, NibLoadable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layoutFactor = nil
    }
    
    var layoutFactor: LayoutFactor? {
        didSet {
            self.bookImageView.update(imageURL: self.layoutFactor?.book.imageURL, placeHolderImage: nil)
            self.titleLabel.text = self.layoutFactor?.book.title
            self.subtitleLabel.text = self.layoutFactor?.book.subtitle
            self.priceLabel.text = self.layoutFactor?.book.price
            self.urlLabel.text = self.layoutFactor?.book.url.absoluteString
            self.isbn13Label.text = self.layoutFactor?.book.isbn13
        }
    }
    
    private let bookImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .darkGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .darkGray
        return label
    }()
    
    private let urlLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        return label
    }()
    
    private let isbn13Label: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        return label
    }()
    
}

private extension BookListTableViewCell {
    
    func setupView() {
        let contentView: UIView = .init()
        [self.bookImageView, contentView]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview($0)
            }
        [self.titleLabel, self.subtitleLabel, self.priceLabel, self.urlLabel, self.isbn13Label]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
            }
        
        NSLayoutConstraint.activate([
            self.bookImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            self.bookImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            self.bookImageView.widthAnchor.constraint(equalToConstant: 50.0),
            self.bookImageView.heightAnchor.constraint(equalToConstant: 50.0),
            
            contentView.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 10.0),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            
            self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor),
            self.priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            self.urlLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor),
            self.urlLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.urlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            self.isbn13Label.topAnchor.constraint(equalTo: self.urlLabel.bottomAnchor),
            self.isbn13Label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.isbn13Label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}

extension BookListTableViewCell {
    
    struct LayoutFactor {
        var book: SearchedBook
    }
}
