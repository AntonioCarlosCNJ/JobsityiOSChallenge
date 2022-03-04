//
//  SeriesListService.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

protocol SeriesListService: NetworkService {
 
    func list(page: Int, handle: @escaping ServiceCompletion<[SeriesModel]>)
    func search(query: String, handle: @escaping ServiceCompletion<[SeriesSearchModel]>)
}

class SeriesListServiceImpl: SeriesListService {
    typealias Target = ServiceListTarget
    
    func list(page: Int, handle: @escaping ServiceCompletion<[SeriesModel]>) {
        request(target: .list(page), then: handle)
    }
    
    func search(query: String, handle: @escaping ServiceCompletion<[SeriesSearchModel]>) {
        request(target: .search(query), then: handle)
    }
}
