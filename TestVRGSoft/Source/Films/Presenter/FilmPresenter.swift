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
    
    init(view: FilmViewProtocol, networkService: NetworkService)
    func startRequestFilms()
    var films: Films? { get set }
    
}

class FilmPresenter: FilmViewPresenterProtocol {
    
    // MARK: - Variables
    
    weak var view: FilmViewProtocol?
    let networkService: NetworkService!
    var films: Films?
    
    // MARK: - Lifecycle
    
    required init(view: FilmViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    // MARK: - Protocol methods
    
    func startRequestFilms() {
        networkService.requestFilms(completion: { [weak self] result in
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
