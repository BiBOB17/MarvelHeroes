//
//  SearchResponse.swift
//  MarvelHeroesCollection
//
//  Created by Иван Сатинов on 12.01.22.
//

import Foundation
import UIKit

struct SearchResponse {
    var resultCount: Int
    var results: [Heroes]
}


struct Heroes {
    var heroesName: String
    var description: String
    var thumbnail: UIImage
    var stories: String
    var events: String
}
