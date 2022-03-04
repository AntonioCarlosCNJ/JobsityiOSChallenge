//
//  NetworkConstants.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import Foundation

struct NetworkConstants {
 
    struct URLs {
        static var baseURL: URL {
            guard let url =  URL(string: "https://api.tvmaze.com/") else {
                fatalError("Error to convert string url")
            }
            return url
        }
    }
}
