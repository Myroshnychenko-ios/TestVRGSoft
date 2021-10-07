//
//  Router.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func pushFilmViewController()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let loadViewController = assemblyBuilder?.createLoadModule(router: self) else { return }
            navigationController.viewControllers = [loadViewController]
        }
    }
    
    func pushFilmViewController() {
        if let navigationController = navigationController {
            guard let filmViewController = assemblyBuilder?.createFilmModule(router: self) else { return }
            guard let favoritesViewController = assemblyBuilder?.createFavoritesModule(router: self) else { return }
            let tabBarController = UITabBarController()
            filmViewController.title = "New films"
            filmViewController.tabBarItem.image = UIImage(named: "ic_watch_tv")
            favoritesViewController.title = "Favorites"
            favoritesViewController.tabBarItem.image = UIImage(named: "ic_favorites")
            tabBarController.setViewControllers([filmViewController, favoritesViewController], animated: false)
            tabBarController.modalPresentationStyle = .fullScreen
            tabBarController.tabBar.backgroundColor = .rVGGreen
            tabBarController.tabBar.tintColor = .rVGBlue
            navigationController.present(tabBarController, animated: false, completion: nil)
        }
    }
    
}
