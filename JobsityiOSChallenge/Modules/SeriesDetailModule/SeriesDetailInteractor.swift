//
//  SeriesDetailInteractor.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import Foundation

protocol SeriesDetailInteractor {
    func getEpisodes(with id: Int)
}

class SeriesDetailInteractorImpl: SeriesDetailInteractor {
    
    //MARK: - Properties
    var presenter: SeriesDetailPresenter?
    var router: SeriesDetailRouter?
    private let service: SeriesDetailServiceImpl?
    
    //MARK: - Initializers
    init(service: SeriesDetailServiceImpl) {
        self.service = service
    }
    
    //MARK: - Methods
    func getEpisodes(with id: Int) {
        service?.listEpisodes(seriesId: id, handle: {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let episodes):
                self.presenter?.presentEpisodes(with: self.createSeasonModels(with: episodes))
            case .error(let error):
                self.presenter?.presentError(with: SeriesDetailServiceError(code: error?.response?.statusCode ?? 500))
            }
        })
    }
    
    private func createSeasonModels(with episodes: [EpisodeModel]?) -> [SeasonModel] {
        guard let episodes = episodes else {return []}

        var seasonModels = [SeasonModel]()
        
        episodes.forEach { episode in
            if let seasonModelIndex = seasonModels.firstIndex(where: {$0.season == episode.season}) {
                seasonModels[seasonModelIndex].episodes.append(episode)
            } else {
                seasonModels.append(SeasonModel(season: episode.season ?? 0, episodes: [episode]))
            }
        }
        
        return seasonModels
    }
    
}
