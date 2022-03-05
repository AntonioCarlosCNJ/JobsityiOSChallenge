//
//  SeriesDetailRouter.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

protocol SeriesDetailRouter {
    func goToDetailEpisode(with episode: EpisodeModel)
}

class SeriesDetailRouterImpl: SeriesDetailRouter {
    
    //MARK: - Properties
    weak var navigationController: UINavigationController?
    
    //MARK: - Methods
    func goToDetailEpisode(with episode: EpisodeModel) {
        guard let navigationController = navigationController else {return}

        navigationController.pushViewController(EpisodeDetailFactory.makeController(with: episode, navigationController: navigationController), animated: true)
    }
}


