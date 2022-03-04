//
//  SeriesDetailService.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import Foundation

protocol SeriesDetailService: NetworkService {
    func listEpisodes(seriesId: Int, handle: @escaping ServiceCompletion<[EpisodeModel]>)
}

class SeriesDetailServiceImpl: SeriesDetailService {
    typealias Target = SeriesDetailTarget
    
    func listEpisodes(seriesId: Int, handle: @escaping ServiceCompletion<[EpisodeModel]>) {
        request(target: .listEpisodes(seriesId), then: handle)
    }
}
