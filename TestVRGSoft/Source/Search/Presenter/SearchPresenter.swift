//
//  SearchPresenter.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 08.10.2021.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    
    // MARK: - View protocol
    
    func success()
    func failure(error: Error)
    func clearTableView()
    
}

protocol SearchViewPresenterProtocol: AnyObject {
    
    // MARK: - Presenter protocol
    
    init(view: SearchViewProtocol, networkService: NetworkService, router: RouterProtocol)
    func startRequestFilms(search: String)
    func pushDetailsViewController(filmIndex: Int)
    var films: Films? { get set }
    
}

class SearchPresenter: SearchViewPresenterProtocol {
    
    // MARK: - Variables
    
    weak var view: SearchViewProtocol?
    let networkService: NetworkService!
    var router: RouterProtocol?
    var films: Films?
    
    // MARK: - Lifecycle
    
    required init(view: SearchViewProtocol, networkService: NetworkService, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: - Protocol methods
    
    func startRequestFilms(search: String) {
        if search == "" {
            films = nil
            self.view?.clearTableView()
        } else {
            networkService.requestFilms(search: search, completion: { [weak self] result in
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
