//
//  FavoritesTableViewCell.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    
    // MARK: - Variables
    
    static let identifier = "FavoritesTableViewCell"
    var film: CDFilm?
    weak var networkService: NetworkService!
    var coreDataService: CoreDataService!
    var delegate: FavoritesTableViewCellProtocol?
    var filmData: Film!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var displayTitleLabel: UILabel!
    @IBOutlet weak var multimediaImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var switchButton: UIButton!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureFavoriteTableViewVell()
        self.indicatorView.startAnimating()
    }
    
    // MARK: - IBActions
    
    @IBAction func switchValueDidChange(_ sender: Any) {
        guard let gFilm = self.filmData else { return }
        self.coreDataService.delete(film: gFilm, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let deleted):
                if deleted {
                    self?.delegate?.updateTableView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Helpers
    
    func initialization(film: CDFilm, networkService: NetworkService, coreDataService: CoreDataService) {
        self.film = film
        self.networkService = networkService
        self.coreDataService = coreDataService
        guard let dataFilm = self.film else {
            displayTitleLabel.text = "Error loading data"
            self.multimediaImageView.image = UIImage(named: "im_rerror_loading_data")
            return
        }
        let multimedia = Multimedia(type: "", src: dataFilm.src, height: 0, width: 0)
        filmData = Film(isFavorites: false, displayTitle: dataFilm.displayTitle, criticsPick: Int(dataFilm.criticsPick), byline: dataFilm.byline, headline: dataFilm.headline, summaryShort: dataFilm.summaryShort, openingDate: dataFilm.openingDate, multimedia: multimedia)
        self.coreDataService.found(film: self.filmData, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case true:
                self?.switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
                self?.filmData.isFavorites = true
            case false:
                self?.switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
                self?.filmData.isFavorites = false
            }
        })
        displayTitleLabel.text = dataFilm.displayTitle
        guard let urlString = dataFilm.src else {
            self.multimediaImageView.image = UIImage(named: "im_rerror_loading_data")
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            return
        }
        networkService.downloadImage(urlString: urlString, completion: { [weak self] image in
            guard self != nil else { return }
            DispatchQueue.main.async {
                self?.multimediaImageView.image = image
                self?.indicatorView.stopAnimating()
                self?.indicatorView.isHidden = true
            }
        })
    }
}
