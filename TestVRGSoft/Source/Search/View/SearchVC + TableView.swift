//
//  SearchVC + TableView.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Delegate/DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.films?.films?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.delegate = self
        let film = presenter.films?.films?[indexPath.row]
        let networkService = NetworkService(dateWith: nil, dateOn: nil)
        let coreDataService = CoreDataService()
        cell.initialization(film: film, networkService: networkService, coreDataService: coreDataService)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.pushDetailsViewController(filmIndex: indexPath.row)
    }
    
}

extension SearchViewController: SearchTableViewCellProtocol {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
}
