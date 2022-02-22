//
//  ViewController.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit

class SportNewsViewController: UIViewController, NewsManagerDelegate, SearchViewAnimateble, UISearchBarDelegate {
    
    private let manager = NewsManager()
    private var news = [NewsData]()
    private let searchBar = UISearchBar()
    var isSearching = false
    var filteredNews: [NewsData] = []
    
    private lazy var searchBarButtonItem: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchButtonPressed))
        return btn
    }()
    
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
        title = "Sport News"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpView()
        manager.delegate = self
        manager.fetchSportNews()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    @objc private func searchButtonPressed() {
        showSearchBar(searchBar: searchBar)
        searchBar.placeholder = "Search..."
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
extension SportNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredNews.count
        } else {
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        let newsData: NewsData
        if isSearching {
            newsData = filteredNews[indexPath.row]
        } else {
            newsData = news[indexPath.row]
        }
        cell.populate(with: newsData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsData: NewsData
        if isSearching {
            newsData = filteredNews[indexPath.row]
        } else {
            newsData = news[indexPath.row]
        }
        let newViewController = DetailViewController(news: newsData)
        newViewController.hidesBottomBarWhenPushed = true
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
    // MARK: - search delegate
    func updateSearchResults(for searchText: String) {
        filteredNews = news.filter({ data in
            data.title!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        hideSearchBar(searchBarButtonItem: searchBarButtonItem, title: title!)
        navigationItem.titleView = nil
        tableView.reloadData()
    }
}


