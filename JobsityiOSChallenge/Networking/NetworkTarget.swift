//
//  NetworkTarget.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import Foundation

enum Method: String {
    case get = "GET"
}

protocol Target {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: Method { get }
    
    var header: [String: String]? { get }
    
    var queryItems: [URLQueryItem] { get }
}

protocol NetworkTarget: Target { }

extension NetworkTarget {
    
    var baseURL: URL { NetworkConstants.URLs.baseURL }
    
    var header: [String : String]? { ["Content-Type": "application/json"] }
}
