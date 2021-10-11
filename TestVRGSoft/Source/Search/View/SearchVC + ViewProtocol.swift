//
//  SearchVC + ViewProtocol.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 08.10.2021.
//

import UIKit

extension SearchViewController: SearchViewProtocol {
    
    // MARK: - SearchViewProtocol
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func clearTableView() {
        tableView.reloadData()
    }
    
}
