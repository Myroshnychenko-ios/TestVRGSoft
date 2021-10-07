//
//  FavoritesViewController.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

protocol FavoritesTableViewCellProtocol {
    func updateTableView()
}

class FavoritesViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: FavoritesViewPresenterProtocol!

    // MARK: - IBOutlets

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavoritesView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFilms()
        tableView.reloadData()
    }
    
}
