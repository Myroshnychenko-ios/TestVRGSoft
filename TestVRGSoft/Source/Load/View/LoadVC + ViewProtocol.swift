//
//  LoadVC + ViewProtocol.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

extension LoadViewController: LoadViewProtocol {
    
    // MARK: - LoadViewProtocol
    
    func setupView(logo: String, project: String, background: String) {
        configureLoadView()
        logoImageView.image = UIImage(named: logo)
        projectLabel.text = project
        backgroundImageView.image = UIImage(named: background)
        startAnimate()
    }
    
}
