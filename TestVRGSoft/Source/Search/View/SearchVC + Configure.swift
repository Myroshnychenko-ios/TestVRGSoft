//
//  SearchVC + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension SearchViewController {
    
    // MARK: - Configure search view controller
    
    func configureSearchView() {
        configureBackgroundImageView()
        configureTableView()
        configureSearchController()
    }
    
    private func configureBackgroundImageView() {
        backgroundImageView.image = UIImage(named: DBConstants.rVGBackground)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.backgroundColor = .rVGGlass
    }
    
    private func configureSearchController() {
        searchController.delegate = self
        searchController.becomeFirstResponder()
        searchController.searchBarStyle = .prominent
        searchController.barTintColor = .rVGGreen
        searchController.becomeFirstResponder()
        searchController.searchTextField.textColor = .rVGBlue
        searchController.searchTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
        searchView.backgroundColor = .rVGGreen
    }
    
    @objc func enterPressed() {
        searchController.searchTextField.resignFirstResponder()
        self.presenter.startRequestFilms(search: self.searchText)
    }
    
}
