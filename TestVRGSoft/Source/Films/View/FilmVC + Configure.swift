//
//  FilmVC + Configure.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension FilmViewController {
    
    // MARK: - Configure film view controller
    
    func configureFilmView() {
        configureBackgroundImageView()
        configureTableView()
    }
    
    private func configureBackgroundImageView() {
        backgroundImageView.image = UIImage(named: DBConstants.rVGBackground)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: FilmTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.backgroundColor = .rVGGlass
    }
    
}
