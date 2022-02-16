//
//  NewsCell.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
//    private let containerView: UIView = {
//       let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 5
//        view.layer.borderColor = UIColor.gray.cgColor
//        view.layer.borderWidth = 2
//        view.layer.shadowOffset = .init(width: 0, height: 3)
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOpacity = 0.2
//        view.layer.shadowRadius = 2
//        return view
//    }()
    
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
    
    private let image: UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .gray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        activateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    func activateConstraints() {
//        contentView.addSubview(containerView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(image)
        stackView.setCustomSpacing(10, after: image)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(10, after: titleLabel)
        stackView.addArrangedSubview(authorLabel)
        
        
        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(with news: NewsData) {
        titleLabel.text = news.title
        authorLabel.text = "Author: \(news.author ?? "unknown")"
        guard let urlString = news.image, let url = URL(string: urlString) else { return }
        image.kf.indicatorType = .activity
        image.kf.setImage(with: url)
    }
}


