//
//  SeriesModel.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import Foundation

protocol Series: Decodable {
    var id: Int {get set}
    var name: String? {get set}
    var imageUrl: String? {get set}
    var premieredDate: Date? {get set}
    var endedDate: Date? {get set}
    var genres: [String]? {get set}
    var summary: String? {get set}
}

fileprivate enum CodingKeys: String, CodingKey {
    case id
    case name
    case imageUrl = "image"
    case premieredDate = "premiered"
    case endedDate = "ended"
    case genres
    case summary
}

fileprivate enum ImageCodingKeys: String, CodingKey {
    case original
}

struct SeriesSearchModel: Series {
    var id: Int
    var name: String?
    var imageUrl: String?
    var premieredDate: Date?
    var endedDate: Date?
    var genres: [String]?
    var summary: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: SearchCodingKeys.self)
        
        let showContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .show)
        id = try showContainer.decode(Int.self, forKey: .id)
        name = try? showContainer.decode(String.self, forKey: .name)
        
        let imageValues =  try? showContainer.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .imageUrl)
        imageUrl = try? imageValues?.decode(String.self, forKey: .original)
        
        let dateFormatter = DateFormatter.yyyyMMdd
        
        let premieredDateString = try? showContainer.decode(String.self, forKey: .premieredDate)
        premieredDate = dateFormatter.date(from: premieredDateString ?? "")
        
        let endedDateString = try? showContainer.decode(String.self, forKey: .endedDate)
        endedDate = dateFormatter.date(from: endedDateString ?? "")
        
        genres = try? showContainer.decode([String].self, forKey: .genres)
        summary = try? showContainer.decode(String.self, forKey: .summary)
    }
    
    enum SearchCodingKeys: String, CodingKey {
        case show
        case rate
    }
}

struct SeriesModel: Series {
    var id: Int
    var name: String?
    var imageUrl: String?
    var premieredDate: Date?
    var endedDate: Date?
    var genres: [String]?
    var summary: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        
        let imageValues =  try values.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .imageUrl)
        imageUrl = try imageValues.decode(String.self, forKey: .original)
        
        let dateFormatter = DateFormatter.yyyyMMdd
        
        let premieredDateString = try? values.decode(String.self, forKey: .premieredDate)
        premieredDate = dateFormatter.date(from: premieredDateString ?? "")
        
        let endedDateString = try? values.decode(String.self, forKey: .endedDate)
        endedDate = dateFormatter.date(from: endedDateString ?? "")
        
        genres = try values.decode([String].self, forKey: .genres)
        summary = try values.decode(String.self, forKey: .summary)
    }
}


