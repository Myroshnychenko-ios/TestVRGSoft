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
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createDetailsModule(router: RouterProtocol, detailsFilm: DetailsFilm) -> UIViewController
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
        let preseter = FilmPresenter(view: view, networkService: networkService, router: router)
        view.presenter = preseter
        return view
    }
    
    func createFavoritesModule(router: RouterProtocol) -> UIViewController {
        let view = FavoritesViewController()
        let coreDataService = CoreDataService()
        let presenter = FavoritesPresenter(view: view, coreDataService: coreDataService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let networkService = NetworkService(dateWith: nil, dateOn: nil)
        let presenter = SearchPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailsModule(router: RouterProtocol, detailsFilm: DetailsFilm) -> UIViewController {
        let view = DetailsViewController()
        let networkService = NetworkService(dateWith: nil, dateOn: nil)
        let coreDataService = CoreDataService()
        let presenter = DetailsPresenter(view: view, networkService: networkService, coreDataService: coreDataService, detailsFilm: detailsFilm)
        view.presenter = presenter
        return view
    }
    
}
