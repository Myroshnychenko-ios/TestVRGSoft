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
    
    init(view: LoadViewProtocol, loadDataModel: LoadDataModel)
    func startSetup()
    
}

// MARK: - Presenter

class LoadPresenter: LoadViewPresenterProtocol {
    
    // MARK: - Variables
    
    let view: LoadViewProtocol
    let loadDataModel: LoadDataModel
    
    required init(view: LoadViewProtocol, loadDataModel: LoadDataModel) {
        self.view = view
        self.loadDataModel = loadDataModel
    }
    
    func startSetup() {
        let logo = loadDataModel.logo
        let project = loadDataModel.project
        let background = loadDataModel.background
        self.view.setupView(logo: logo, project: project, background: background)
    }
    
}
