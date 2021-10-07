//
//  ModuleBuilder.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createLoadModule(router: RouterProtocol) -> UIViewController
    func createFilmModule(router: RouterProtocol) -> UIViewController
    func createFavoritesModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createLoadModule(router: RouterProtocol) -> UIViewController {
        let model = LoadDataModel(logo: DBConstants.rVGLogo, project: DBConstants.rVGProject, background: DBConstants.rVGBackground)
        let view = LoadViewController()
        let presenter = LoadPresenter(view: view, loadDataModel: model, router: router)
        view.presenter = presenter
        return view
    }
    
    func createFilmModule(router: RouterProtocol) -> UIViewController {
        let view = FilmViewController()
        let networkService = NetworkService(dateWith: nil, dateOn: nil)
        let preseter = FilmPresenter(view: view, networkService: networkService)
        view.presenter = preseter
        return view
    }
    
    func createFavoritesModule(router: RouterProtocol) -> UIViewController {
        let view = FavoritesViewController()
        let coreDataService = CoreDataService()
        let presenter = FavoritesPresenter(view: view, coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }
    
}
