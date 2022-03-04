//
//  SeriesDetailTarget.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import Foundation

enum SeriesDetailTarget {
    case listEpisodes(_ seriesId: Int)
}

extension SeriesDetailTarget: NetworkTarget {
    var path: String {
        switch self {
        case .listEpisodes(let seriesId):
            return "shows/\(seriesId)/episodes"
        }
    }
    
    var method: Method {
        switch self {
        case .listEpisodes(_):
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .listEpisodes(_):
            return []
        }
    }
}


