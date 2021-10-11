//
//  DetailsVC + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 11.10.2021.
//

import UIKit

extension DetailsViewController {
    
    // MARK: - Configure details view controller
    
    func configureDetailsView() {
        configureBackgroundImageView()
        configureCriticsPickLabel()
        configureSwitchButton()
        configureHeadLineLabel()
        configureSumaryShortLabel()
        configureDisplayTitleLabel()
        configureBylineLabel()
        configureOpeningDateLabel()
    }
    
    private func configureBackgroundImageView() {
        backgroundImageView.image = UIImage(named: DBConstants.rVGBackground)
    }
    
    private func configureCriticsPickLabel() {
        criticsPickLabel.text = "CRITIC’S PICK"
        criticsPickLabel.numberOfLines = 0
        criticsPickLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        criticsPickLabel.textColor = .rVGBlue
        criticsPickLabel.textAlignment = .left
    }
    
    private func configureSwitchButton() {
        let multimedia = Multimedia(type: "", src: presenter.detailsFilm?.src, height: 0, width: 0)
        film = Film(isFavorites: false, displayTitle: presenter.detailsFilm?.displayTitle, criticsPick: presenter.detailsFilm?.criticsPick, byline: presenter.detailsFilm?.byline, headline: presenter.detailsFilm?.headline, summaryShort: presenter.detailsFilm?.summaryShort, openingDate: presenter.detailsFilm?.openingDate, multimedia: multimedia)
        presenter.coreDataService?.found(film: self.film, completion: { result in
            switch result {
            case true:
                self.switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
                self.presenter.detailsFilm?.isFavorites = true
            case false:
                self.switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
                self.presenter.detailsFilm?.isFavorites = false
            }
        })
    }
    
    private func configureHeadLineLabel() {
        headlineLabel.numberOfLines = 5
        headlineLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        headlineLabel.textColor = .rVGBlue
        headlineLabel.textAlignment = .left
    }
    
    private func configureSumaryShortLabel() {
        summaryShortLabel.numberOfLines = 10
        summaryShortLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        summaryShortLabel.textColor = .rVGBlue
        summaryShortLabel.textAlignment = .left
    }
    
    private func configureDisplayTitleLabel() {
        displayTitleLabel.numberOfLines = 0
        displayTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        displayTitleLabel.textColor = .rVGBlue
        displayTitleLabel.textAlignment = .left
    }
    
    private func configureBylineLabel() {
        bylineLabel.numberOfLines = 0
        bylineLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        bylineLabel.textColor = .rVGBlue
        bylineLabel.textAlignment = .left
    }
    
    private func configureOpeningDateLabel() {
        openingDateLabel.numberOfLines = 0
        openingDateLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        openingDateLabel.textColor = .rVGBlue
        openingDateLabel.textAlignment = .left
    }
}
