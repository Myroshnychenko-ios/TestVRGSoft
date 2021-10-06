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
            let tabBarController = UITabBarController()
            filmViewController.title = "film"
            tabBarController.setViewControllers([filmViewController], animated: false)
            tabBarController.modalPresentationStyle = .fullScreen
            navigationController.present(tabBarController, animated: false, completion: nil)
        }
    }
    
}
