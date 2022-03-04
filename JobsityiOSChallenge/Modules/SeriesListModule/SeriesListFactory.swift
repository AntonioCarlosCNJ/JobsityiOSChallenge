//
//  SeriesListFactory.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import UIKit

final class SeriesListFactory {
    
    static func makeController(navigationController: UINavigationController) -> SeriesListViewController {
        let vc = SeriesListViewController()
        
        let view = SeriesListViewImpl()
        vc.listView = view
        
        let interactor = SeriesListInteractorImpl(service: SeriesListServiceImpl())
        view.interactor = interactor
        
        let router = SeriesListRouterImpl()
        router.navigationController = navigationController
        
        interactor.presenter = vc
        interactor.router = router
        
        return vc
    }
}
