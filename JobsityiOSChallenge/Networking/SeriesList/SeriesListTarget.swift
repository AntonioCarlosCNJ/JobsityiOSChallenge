//
//  SeriesListTarget.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import Foundation

enum ServiceListTarget {
    case list(_ page: Int)
    case search(_ query: String)
}

extension ServiceListTarget: NetworkTarget {
    var path: String {
        switch self {
        case .list(_):
            return "shows"
        case .search(_):
            return "search/shows"
        }
    }
    
    var method: Method {
        switch self {
        case .list(_), .search(_):
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .list(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        case .search(let query):
            return [URLQueryItem(name: "q", value: query)]
        }
    }
}
