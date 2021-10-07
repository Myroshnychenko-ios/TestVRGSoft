//
//  FavoritesVC + ViewProtocol.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension FavoritesViewController: FavoritesViewProtocol {
    
    func success() {
        if presenter.films?.count == 0 {
            tableView.reloadData()
            let alertController = UIAlertController(title: "Error", message: "Your don`t have favorites films", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
