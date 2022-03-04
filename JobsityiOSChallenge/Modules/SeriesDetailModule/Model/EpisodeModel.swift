//
//  EpisodeModel.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import Foundation

struct EpisodeModel: Decodable {
    let name: String?
    let number: Int?
    let season: Int?
    let summary: String?
    let imageUrl: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try? values.decode(String.self, forKey: .name)
        number = try? values.decode(Int.self, forKey: .number)
        season = try? values.decode(Int.self, forKey: .season)
        summary = try? values.decode(String.self, forKey: .summary)
        
        let imageValues = try? values.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .imageUrl)
        
        imageUrl = try? imageValues?.decode(String.self, forKey: .original)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case number
        case season
        case summary
        case imageUrl = "image"
    }
    
    enum ImageCodingKeys: String, CodingKey {
        case original
    }
}
