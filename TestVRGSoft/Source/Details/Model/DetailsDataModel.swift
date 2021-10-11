//
//  DetailsDataModel.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 11.10.2021.
//

import Foundation

// MARK: - Details film model

struct DetailsFilm {
    var isFavorites: Bool = false
    var displayTitle: String
    var criticsPick: Int
    var byline: String
    var headline: String
    var summaryShort: String
    var openingDate: String
    var src: String?
}
