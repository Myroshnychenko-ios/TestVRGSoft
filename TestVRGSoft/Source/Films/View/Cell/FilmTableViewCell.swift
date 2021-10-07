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
    var coreDataService: CoreDataService!
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
            guard let dataFilm = film else { return }
            self.coreDataService.saveFilm(film: dataFilm, completion: { [weak self] result in
                guard self != nil else {return}
                switch result {
                case .success(let saved):
                    self?.switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
                    self?.film?.isFavorites = saved
                case .failure(let error):
                    self?.switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
                    self?.film?.isFavorites = false
                    print(error.localizedDescription)
                }
            })
        } else {
            guard let dataFilm = film else { return }
            self.coreDataService.deleteFilm(film: dataFilm, completion: { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let deleted):
                    self?.switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
                    self?.film?.isFavorites = !deleted
                case .failure(let error):
                    self?.switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
                    self?.film?.isFavorites = true
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    // MARK: - Helpers
    
    func initialization(film: Film?, networkService: NetworkService, coreDataService: CoreDataService) {
        self.film = film
        self.networkService = networkService
        self.coreDataService = coreDataService
        guard let dataFilm = self.film else {
            displayTitleLabel.text = "Error loading data"
            self.multimediaImageView.image = UIImage(named: "im_rerror_loading_data")
            return
        }
        self.coreDataService.isSavedFilm(film: dataFilm, completion: { result in
            switch result {
            case true:
                self.switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
                self.film?.isFavorites = true
                self.switchSelected = true
            case false:
                self.switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
                self.film?.isFavorites = false
                self.switchSelected = false
            }
        })
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
