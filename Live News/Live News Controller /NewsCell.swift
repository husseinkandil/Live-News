//
//  NewsCell.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell, UITextViewDelegate {
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textAlignment = .center
        return title
    }()
    
    private let authorLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var mainImageView: UIImageView = {
        var img = UIImageView()
        img.backgroundColor = .gray
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "placeholderImage")
        return img
    }()
    
    private lazy var urlButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: 0.27, green: 0.51, blue: 0.71, alpha: 1.00), for: .normal)
        btn.setTitle("Website", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func buttonAction(with sender: UIButton) {
        didTapWebsite?()
    }
    
    var didTapWebsite: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        activateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    func activateConstraints() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mainImageView)
        stackView.setCustomSpacing(10, after: mainImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(10, after: titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addSubview(urlButton)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 230),
            
            urlButton.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            urlButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            urlButton.topAnchor.constraint(equalTo: authorLabel.topAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(with news: NewsData) {
        titleLabel.text = news.title
        containsOnlyLetters(news)
        guard let urlString = news.urlToImage, let url = URL(string: urlString) else {
            mainImageView.image = .placeholderImage
            return
        }
        mainImageView.kf.setImage(with: url, placeholder: UIImage.placeholderImage, options: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self?.mainImageView.image = .placeholderImage
                case .success(let image):
                    self?.mainImageView.image = image.image
                }
            }
        }
    }

    private func containsOnlyLetters(_ news: NewsData) {
        guard let auth = news.author else { return }
        for chr in auth {
           if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
               authorLabel.text = "Author: Unknown"
           } else {
               authorLabel.text = "Author: \(news.author!)"
           }
        }
    }
}
