//
//  ModuleBuilder.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

protocol Builder {
    
    static func createLoadModule() -> UIViewController
}

class ModelBuilder: Builder {
    
    static func createLoadModule() -> UIViewController {
        let model = LoadDataModel(logo: DBConstants.rVGLogo, project: DBConstants.rVGProject, background: DBConstants.rVGBackground)
        let view = LoadViewController()
        let presenter = LoadPresenter(view: view, loadDataModel: model)
        view.presenter = presenter
        return view
    }
    
}
