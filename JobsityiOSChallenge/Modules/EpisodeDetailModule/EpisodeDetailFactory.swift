//
//  EpisodeDetailFactory.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

final class EpisodeDetailFactory {
    
    static func makeController(with episodeModel: EpisodeModel, navigationController: UINavigationController) -> EpisodeDetailViewController {
        let vc = EpisodeDetailViewController()
        
        let view = EpisodeDetailViewImpl(with: episodeModel)
        vc.detailView = view
        
        let interactor = EpisodeDetailInteractorImpl()
        view.interactor = interactor
        
        let router = EpisodeDetailRouterImpl()
        router.navigationController = navigationController
        
        interactor.presenter = vc
        interactor.router = router
        
        return vc
    }
    
}
