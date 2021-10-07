//
//  FavoritesVC + TableView.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Delegate/DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.films?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        guard let film = presenter.films?[indexPath.row] else { return cell }
        cell.delegate = self
        let networkService = NetworkService(dateWith: nil, dateOn: nil)
        let coreDataService = CoreDataService()
        cell.initialization(film: film, networkService: networkService, coreDataService: coreDataService)
        return cell
    }
    
}

extension FavoritesViewController: FavoritesTableViewCellProtocol {
    
    func updateTableView() {
        presenter.fetchFilms()
        tableView.reloadData()
    }
    
}
