//
//  FilmDataModel.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import Foundation

struct Results: Decodable {
    var results: [Film]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Film: Decodable {
    var displayTitle: String?
    var criticsPick: Int?
    var byline: String?
    var headline: String?
    var summaryShort: String?
    var openingDate: String?
    var multimedia: Multimedia?
    
    enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case criticsPick = "critics_pick"
        case byline = "byline"
        case headline = "headline"
        case summaryShort = "summary_short"
        case openingDate = "opening_date"
        case multimedia = "multimedia"
    }
}

struct Multimedia: Decodable {
    var type: String?
    var src: String?
    var height: Int?
    var width: Int?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case src = "src"
        case height = "height"
        case width = "width"
    }
}
