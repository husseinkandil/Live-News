//
//  ViewController.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit

class ViewController: UIViewController, NewsManagerDelegate {
    
    private let manager = NewsManager()
    private var news = [NewsData]()
    
    private lazy var tableView: UITableView = {
       let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.rowHeight = UITableView.automaticDimension
        tbl.estimatedRowHeight = 600
        tbl.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Live News"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpView()
        manager.delegate = self
        manager.fetchNews()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
// MARK: - setting up view
    
    private func setUpView() {
        defer {
            setUpConstrians()
        }
        view.addSubview(tableView)
    }
    
    private func setUpConstrians() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - table view delegate and data source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.populate(with: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = news[indexPath.row]
        let newViewController = DetailViewController(news: data)
        navigationController?.pushViewController(newViewController, animated: true)
    }
// MARK: - managerDelegate
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsData]) {
        self.news = news
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

