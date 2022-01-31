import Foundation
import UIKit

struct HeroesResponse: Codable {
    var data: HeroesData
}

struct HeroesData: Codable {
    var results: [Heroes]
}

struct Heroes: Codable {
    var name: String
    var description: String
    var thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    var imageURL: String
    var imageType: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "path"
        case imageType = "extension"
      }
    }


