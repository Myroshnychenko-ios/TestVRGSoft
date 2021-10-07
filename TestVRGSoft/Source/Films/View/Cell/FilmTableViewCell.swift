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
    var film: Film?
    weak var networkService: NetworkService!
    var coreDataService: CoreDataService!
    var delegate: FilmTableViewCellProtocol?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var displayTitleLabel: UILabel!
    @IBOutlet weak var multimediaImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var switchButton: UIButton!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureFilmTableViewVell()
        self.indicatorView.startAnimating()
    }
    
    // MARK: - IBActions
    
    @IBAction func switchValueDidChange(_ sender: Any) {
        guard let dataFilm = self.film else { return }
        self.coreDataService.found(film: dataFilm, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case true:
                self?.coreDataService.delete(film: dataFilm, completion: { [weak self] result in
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
            case false:
                self?.coreDataService.save(film: dataFilm, completion: { [weak self] result in
                    guard self != nil else { return }
                    switch result {
                    case .success(let saved):
                        if saved {
                            self?.delegate?.updateTableView()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        })
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
        self.coreDataService.found(film: dataFilm, completion: { result in
            switch result {
            case true:
                self.switchButton.setImage(UIImage(named: "ic_favorites_on"), for: .normal)
                self.film?.isFavorites = true
            case false:
                self.switchButton.setImage(UIImage(named: "ic_favorites_off"), for: .normal)
                self.film?.isFavorites = false
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
