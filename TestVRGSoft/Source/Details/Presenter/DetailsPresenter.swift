//
//  DetailsPresenter.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 11.10.2021.
//

import Foundation
import UIKit

protocol DetailsViewProtocol: AnyObject {
    
    // MARK: - View protocol
    
    func success()
    
}

protocol DetailsViewPresenterProtocol: AnyObject {
    
    // MARK: - Presenter protocol
    
    init(view: DetailsViewProtocol, networkService: NetworkService, coreDataService: CoreDataService, detailsFilm: DetailsFilm)
    func startSetup()
    var detailsFilm: DetailsFilm? { get set }
    var networkService: NetworkService? { get set }
    var coreDataService: CoreDataService? { get set }
    
}

class DetailsPresenter: DetailsViewPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    var networkService: NetworkService?
    var coreDataService: CoreDataService?
    var detailsFilm: DetailsFilm?
    var srcImage: UIImage?
    
    required init(view: DetailsViewProtocol, networkService: NetworkService, coreDataService: CoreDataService, detailsFilm: DetailsFilm) {
        self.view = view
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.detailsFilm = detailsFilm
    }
    
    func startSetup() {
        self.view?.success()
    }
    
}
