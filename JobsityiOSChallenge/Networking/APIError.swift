//
//  APIError.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import Foundation

enum APIError: Error {
    case errorDecode
    case failed(error: Error)
    case unknownError
    
    //Should handle a specific message for each error
    var message: String {
        return "Something goes wrong, please try again..."
    }
}
