//
//  DetailViewController.swift
//  Live News
//
//  Created by jaber on 15/02/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let news: News
    
    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let mainImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .gray
//        img.contentMode = .scaleAspectFill
//        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .systemBackground
        title = "\(authorLabel.text ?? "Live News")"
        populate()
    }

    private func containsOnlyLetters(_ news: News) {
        guard let author = news.author else { return }
        for chr in author {
            if (!(chr >= "a" && chr <= "z" ) && !(chr >= "A" && chr <= "z")) {
                authorLabel.text = "Author: Unknown"
            } else {
                authorLabel.text = "Author: \(news.author!)"
            }
        }
    }

    private func setUpView() {
        defer {
            setUpConstrians()
        }
        view.addSubview(stackView)
        stackView.addArrangedSubview(mainImageView)
        stackView.setCustomSpacing(20, after: mainImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(20, after: titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setCustomSpacing(20, after: descriptionLabel)
        stackView.addArrangedSubview(authorLabel)
    }
    
    private func setUpConstrians() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    func populate() {
        titleLabel.text = news.title
        containsOnlyLetters(news)
        descriptionLabel.text = news.description
        guard let urlString = news.imageURL, let url = URL(string: urlString) else {
            mainImageView.image = .placeholderImage
            return
        }
        mainImageView.kf.indicatorType = .activity
        mainImageView.kf.setImage(with: url)
    }
}
