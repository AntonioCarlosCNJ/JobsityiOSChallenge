//
//  SeriesDetailFactory.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

final class SeriesDetailFactory {
    
    static func makeController(with seriesModel: Series, navigationController: UINavigationController) -> SeriesDetailViewController {
        let vc = SeriesDetailViewController()
        
        let view = SeriesDetailViewImpl(with: seriesModel)
        vc.detailView = view
        
        let interactor = SeriesDetailInteractorImpl(service: SeriesDetailServiceImpl())
        view.interactor = interactor
        
        let router = SeriesDetailRouterImpl()
        router.navigationController = navigationController
        
        interactor.presenter = vc
        interactor.router = router
        
        return vc
    }
    
}
