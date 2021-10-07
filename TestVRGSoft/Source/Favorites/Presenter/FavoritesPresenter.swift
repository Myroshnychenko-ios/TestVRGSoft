//
//  FavoritesPresenter.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
    
    // MARK: - View protocol
    
    func success()
    func failure(error: Error)
    
}

protocol FavoritesViewPresenterProtocol: AnyObject {
    
    // MARK: - Presenter protocol
    
    init(view: FavoritesViewProtocol, coreDataService: CoreDataService)
    func fetchFilms()
    var films: [CDFilm]? { get set }
    
}

class FavoritesPresenter: FavoritesViewPresenterProtocol {
    
    // MARK: - Variables
    
    weak var view: FavoritesViewProtocol?
    let coreDataService: CoreDataService!
    var films: [CDFilm]?
    
    // MARK: - Lifecycle
    
    required init(view: FavoritesViewProtocol, coreDataService: CoreDataService) {
        self.view = view
        self.coreDataService = coreDataService
    }
    
    // MARK: - Protocol methods
    
    func fetchFilms() {
        coreDataService.fetch(completion: { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self?.films = films
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        })
    }
}
