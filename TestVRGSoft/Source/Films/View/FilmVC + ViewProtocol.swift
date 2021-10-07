//
//  FilmVC + ViewProtocol.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension FilmViewController: FilmViewProtocol {
    
    // MARK: - FilmViewProtocol
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
