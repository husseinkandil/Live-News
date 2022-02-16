//
//  TabBar.swift
//  Live News
//
//  Created by jaber on 16/02/2022.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: LiveNewsViewController(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SportNewsViewController(), title: NSLocalizedString("Sports", comment: ""), image: UIImage(systemName: "sportscourt")!),
        ]
    }
}
