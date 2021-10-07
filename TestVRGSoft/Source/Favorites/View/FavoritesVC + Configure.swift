//
//  FavoritesVC + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension FavoritesViewController {
    
    // MARK: - Configure favorites view controller
    
    func configureFavoritesView() {
        configureBackgroundImageView()
        configureTableView()
    }
    
    private func configureBackgroundImageView() {
        backgroundImageView.image = UIImage(named: DBConstants.rVGBackground)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: FavoritesTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        tableView.backgroundColor = .rVGGlass
    }
    
}
