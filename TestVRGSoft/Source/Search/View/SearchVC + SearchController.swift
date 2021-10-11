//
//  SearchVC + SearchController.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchText = ""
        self.presenter.startRequestFilms(search: searchText)
    }
    
}
