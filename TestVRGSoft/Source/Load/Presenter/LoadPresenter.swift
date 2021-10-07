//
//  LoadPresenter.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import Foundation

protocol LoadViewProtocol: AnyObject {
    
    // MARK: - View protocol
    
    func setupView(logo: String, project: String, background: String)
    
}

protocol LoadViewPresenterProtocol: AnyObject {
    
    // MARK: - Presenter protocol
    
    init(view: LoadViewProtocol, loadDataModel: LoadDataModel, router: RouterProtocol)
    func startSetup()
    func finishSetup()
    
}

// MARK: - Presenter

class LoadPresenter: LoadViewPresenterProtocol {
    
    // MARK: - Variables
    
    weak var view: LoadViewProtocol?
    let loadDataModel: LoadDataModel
    var router: RouterProtocol?
    
    // MARK: - Lifecycle
    
    required init(view: LoadViewProtocol, loadDataModel: LoadDataModel, router: RouterProtocol) {
        self.view = view
        self.loadDataModel = loadDataModel
        self.router = router
    }
    
    // MARK: - Protocol methods
    
    func startSetup() {
        let logo = loadDataModel.logo
        let project = loadDataModel.project
        let background = loadDataModel.background
        self.view?.setupView(logo: logo, project: project, background: background)
    }
    
    func finishSetup() {
        router?.pushFilmViewController()
    }
    
}
