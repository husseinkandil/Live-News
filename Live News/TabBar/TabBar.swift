//
//  TabBar.swift
//  Live News
//
//  Created by jaber on 16/02/2022.
//

import UIKit

protocol ScrollsToTop: UIViewController {
    func scrollToTop()
}

class TabBar: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        self.delegate = self
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
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let rootController = viewController as? UINavigationController,
            let topController = rootController.topViewController,
            let viewController = topController as? ScrollsToTop {
            if rootController.viewControllers.count == 1 {
                viewController.scrollToTop()
            }
        } else if let vc = viewController as? ScrollsToTop {
            vc.scrollToTop()
        }
    }
    
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: LiveNewsViewController(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SportNewsViewController(), title: NSLocalizedString("Sports", comment: ""), image: UIImage(systemName: "sportscourt")!),
        ]
    }
}
