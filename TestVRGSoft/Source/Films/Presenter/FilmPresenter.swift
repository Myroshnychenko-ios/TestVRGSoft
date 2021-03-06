//
//  FilmPresenter.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 06.10.2021.
//

import Foundation

protocol FilmViewProtocol: AnyObject {
    
    // MARK: - View protocol
    
    func success()
    func failure(error: Error)
    
}

protocol FilmViewPresenterProtocol: AnyObject {
    
    // MARK: - Presenter protocol
    
    init(view: FilmViewProtocol, networkService: NetworkService, router: RouterProtocol)
    func startRequestFilms()
    func pushDetailsViewController(filmIndex: Int)
    var films: Films? { get set }
    
}

class FilmPresenter: FilmViewPresenterProtocol {
    
    // MARK: - Variables
    
    weak var view: FilmViewProtocol?
    let networkService: NetworkService!
    var router: RouterProtocol?
    var films: Films?
    
    // MARK: - Lifecycle
    
    required init(view: FilmViewProtocol, networkService: NetworkService, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: - Protocol methods
    
    func startRequestFilms() {
        networkService.requestFilms(search: nil, completion: { [weak self] result in
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
        let displayTitle = self.films?.films?[filmIndex].displayTitle ?? "Error loading data"
        let criticsPick = self.films?.films?[filmIndex].criticsPick ?? 0
        let byline = self.films?.films?[filmIndex].byline ?? "Error loading data"
        let headline = self.films?.films?[filmIndex].headline ?? "Error loading data"
        let summaryShort = self.films?.films?[filmIndex].summaryShort ?? "Error loading data"
        let openingDate = self.films?.films?[filmIndex].openingDate ?? "Error loading data"
        let src = self.films?.films?[filmIndex].multimedia?.src ?? "Error loading data"
        let film = DetailsFilm(displayTitle: displayTitle, criticsPick: criticsPick, byline: byline, headline: headline, summaryShort: summaryShort, openingDate: openingDate, src: src)
        self.router?.pushDetailsViewController(detailsFilm: film)
    }
}
