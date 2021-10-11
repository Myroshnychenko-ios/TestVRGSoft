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
    
    init(view: FavoritesViewProtocol, coreDataService: CoreDataService, router: RouterProtocol)
    func fetchFilms()
    func pushDetailsViewController(filmIndex: Int)
    var films: [CDFilm]? { get set }
    
}

class FavoritesPresenter: FavoritesViewPresenterProtocol {
    
    // MARK: - Variables
    
    weak var view: FavoritesViewProtocol?
    let coreDataService: CoreDataService!
    var router: RouterProtocol?
    var films: [CDFilm]?
    
    // MARK: - Lifecycle
    
    required init(view: FavoritesViewProtocol, coreDataService: CoreDataService, router: RouterProtocol) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
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
    
    func pushDetailsViewController(filmIndex: Int) {
        let displayTitle = self.films?[filmIndex].displayTitle ?? "Error loading data"
        let criticsPick = self.films?[filmIndex].criticsPick ?? 0
        let byline = self.films?[filmIndex].byline ?? "Error loading data"
        let headline = self.films?[filmIndex].headline ?? "Error loading data"
        let summaryShort = self.films?[filmIndex].summaryShort ?? "Error loading data"
        let openingDate = self.films?[filmIndex].openingDate ?? "Error loading data"
        let src = self.films?[filmIndex].src ?? "Error loading data"
        let film = DetailsFilm(displayTitle: displayTitle, criticsPick: Int(criticsPick), byline: byline, headline: headline, summaryShort: summaryShort, openingDate: openingDate, src: src)
        self.router?.pushDetailsViewController(detailsFilm: film)
    }
    
}
