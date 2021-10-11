//
//  SearchTVCell + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 08.10.2021.
//

import UIKit

extension SearchTableViewCell {
    
    // MARK: - Configure film table view cell
    
    func configureSearchTableViewVell() {
        configureBackgroundView()
        configureDisplayTitleLabel()
        configureMultimediaImageView()
    }
    
    private func configureBackgroundView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func configureDisplayTitleLabel() {
        displayTitleLabel.numberOfLines = 0
        displayTitleLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        displayTitleLabel.textColor = .rVGGrey
        displayTitleLabel.textAlignment = .center
    }
    
    private func configureMultimediaImageView() {
        multimediaImageView.layer.cornerRadius = 20
    }
    
}
