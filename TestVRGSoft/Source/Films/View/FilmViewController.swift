//
//  FilmsViewController.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

class FilmViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: FilmViewPresenterProtocol!
    
    // MARK: - IBOutlets

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFilmView()
        presenter.startRequestFilms()
    }
    
}
