//
//  SeriesListServiceError.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import Foundation

struct SeriesListServiceError {
    let code: Int
    var description: String {
        switch code {
        case 424:
            return "You exceeded the API calls, please wait at least 30 seconds to request again!"
        default:
            return "Something goes Wrong. Try Again!"
        }
    }
    
    init(code: Int) {
        self.code = code
    }
}


