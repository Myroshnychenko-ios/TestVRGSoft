//
//  FavoritesTVCell + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension FavoritesTableViewCell {
    
    // MARK: - Configure film table view cell
    
    func configureFavoriteTableViewVell() {
        configureBackgroundView()
        configureDisplayTitleLabel()
        configureMultimediaImageView()
       // configureSwitchButton()
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
    
//    private func configureSwitchButton() {
//        switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
//    }
    
}
