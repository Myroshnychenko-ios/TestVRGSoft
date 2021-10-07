//
//  Extensions.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

extension UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didReloadData indexPath: IndexPath) {
        tableView.reloadData()
    }
    
}
