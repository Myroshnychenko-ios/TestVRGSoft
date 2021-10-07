//
//  FilmTableViewCell.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    
    static let identifier = "FilmTableViewCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var displayTitleLabel: UILabel!
    @IBOutlet weak var multimediaImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var switchButton: UIButton!
    var film: Film?
    weak var networkService: NetworkService!
    var switchSelected: Bool = false
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureFilmTableViewVell()
        self.indicatorView.startAnimating()
    }
    
    // MARK: - IBActions
    
    @IBAction func switchValueDidChange(_ sender: Any) {
        switchSelected = !switchSelected
        if switchSelected {
            switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
            film?.isFavorites = true
        } else {
            switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
            film?.isFavorites = false
        }    }
    
    // MARK: - Helpers
    
    func initialization(film: Film?, networkService: NetworkService, coreDataService: String?) {
        self.film = film
        self.networkService = networkService
        guard let dataFilm = self.film else {
            displayTitleLabel.text = "Error loading data"
            self.multimediaImageView.image = UIImage(named: "im_rerror_loading_data")
            return
        }
        if dataFilm.isFavorites {
            switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
        } else {
            switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
        }
        displayTitleLabel.text = dataFilm.displayTitle
        guard let multimedia = dataFilm.multimedia else {
            self.multimediaImageView.image = UIImage(named: "im_rerror_loading_data")
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            return
        }
        let urlString = multimedia.src
        networkService.downloadImage(urlString: urlString ?? "error", completion: { [weak self] image in
            guard self != nil else { return }
            DispatchQueue.main.async {
                self?.multimediaImageView.image = image
                self?.indicatorView.stopAnimating()
                self?.indicatorView.isHidden = true
            }
        })
    }
}
