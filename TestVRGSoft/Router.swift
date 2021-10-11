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
    func pushDetailsViewController(detailsFilm: DetailsFilm)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var tabBarController: UITabBarController?
    
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
            guard let searchViewController = assemblyBuilder?.createSearchModule(router: self) else { return }
            self.tabBarController = UITabBarController()
            filmViewController.title = "New films"
            filmViewController.tabBarItem.image = UIImage(named: "ic_watch_tv")
            searchViewController.title = "Search film"
            searchViewController.tabBarItem.image = UIImage(named: "ic_search")
            searchViewController.navigationController?.isNavigationBarHidden = false
            favoritesViewController.title = "Favorites"
            favoritesViewController.tabBarItem.image = UIImage(named: "ic_favorites")
            tabBarController?.setViewControllers([filmViewController, searchViewController, favoritesViewController], animated: false)
            tabBarController?.modalPresentationStyle = .fullScreen
            tabBarController?.tabBar.backgroundColor = .rVGGreen
            tabBarController?.tabBar.tintColor = .rVGBlue
            navigationController.present(tabBarController ?? UITabBarController(), animated: false, completion: nil)
        }
    }
    
    func pushDetailsViewController(detailsFilm: DetailsFilm) {
        guard let detailsViewController = assemblyBuilder?.createDetailsModule(router: self, detailsFilm: detailsFilm) else { return }
        guard let gTabBarController = self.tabBarController else { return }
        gTabBarController.present(detailsViewController, animated: true, completion: nil)
    }
    
}
