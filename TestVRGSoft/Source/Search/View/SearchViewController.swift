//
//  SearchViewController.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

protocol SearchTableViewCellProtocol {
    func updateTableView()
}

class SearchViewController: UIViewController {
    
    
    // MARK: - Variables
    
    var presenter: SearchViewPresenterProtocol!
    var searchText = ""
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchView()
    }
}
