//
//  LoadVC + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

extension LoadViewController {
    
    // MARK: - Configure loading view controller
    
    func configureLoadView() {
        configureLogoView()
        configureProjectLabel()
    }
    
    private func configureLogoView() {
        logoView.backgroundColor = .white
        logoView.layer.cornerRadius = 35
        logoView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        logoView.layer.shadowOffset = CGSize(width: 5, height: 5)
        logoView.layer.shadowOpacity = 0.16
        logoView.layer.shadowRadius = 15
    }
    
    private func configureProjectLabel() {
        projectLabel.numberOfLines = 0
        projectLabel.font = UIFont(name: "HelveticaNeue-Light", size: 50)
        projectLabel.textColor = .rVGGreen
        projectLabel.textAlignment = .center
    }
    
}
