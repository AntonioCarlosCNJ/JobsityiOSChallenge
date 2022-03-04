//
//  RequestErrorModel.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import Foundation

struct RequestErrorModel {
    let error: Error?
    let response: HTTPURLResponse?
    
    init(error: Error?, response: HTTPURLResponse?) {
        self.error = error
        self.response = response
    }
}
