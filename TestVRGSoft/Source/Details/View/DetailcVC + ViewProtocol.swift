//
//  DetailcVC + ViewProtocol.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 11.10.2021.
//

import UIKit

extension DetailsViewController: DetailsViewProtocol {
    
    func success() {
        criticsPickLabel.alpha = CGFloat(presenter.detailsFilm?.criticsPick ?? 0)
        headlineLabel.text = presenter.detailsFilm?.headline
        summaryShortLabel.text = presenter.detailsFilm?.summaryShort
        presenter.networkService?.downloadImage(urlString: presenter.detailsFilm?.src ?? "Error", completion: { [weak self] image in
            guard self != nil else { return }
            DispatchQueue.main.async {
                self?.srcImageView.image = image
            }
        })
        displayTitleLabel.text = presenter.detailsFilm?.displayTitle
        bylineLabel.text = presenter.detailsFilm?.byline
        openingDateLabel.text = presenter.detailsFilm?.openingDate
    }
    
    func setupImage(image: UIImage) {
    }
    
}
