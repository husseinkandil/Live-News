//
//  SearchBar.swift
//  Live News
//
//  Created by jaber on 17/02/2022.
//

import UIKit

protocol SearchViewAnimateble : AnyObject{ }

extension SearchViewAnimateble where Self: UIViewController{

func showSearchBar(searchBar : UISearchBar) {
    searchBar.alpha = 0
    navigationItem.titleView = searchBar
    navigationItem.setRightBarButton(nil, animated: true)

    UIView.animate(withDuration: 0.5, animations: {
        searchBar.alpha = 1
    }, completion: { finished in
        searchBar.becomeFirstResponder()
    })
}

func hideSearchBar( searchBarButtonItem : UIBarButtonItem, title : String) {
    navigationItem.setRightBarButton(searchBarButtonItem, animated: true)

    UIView.animate(withDuration: 0.3, animations: {
        self.navigationItem.title = title
    }, completion: { finished in

    })
 }
}
