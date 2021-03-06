//
//  FilmsViewController.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

protocol FilmTableViewCellProtocol {
    func updateTableView()
}

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startRequestFilms()
        tableView.reloadData()
    }
    
}
