//
//  SeriesListRouter.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import UIKit

protocol SeriesListRouter {
    func goToSeriesDetail(with model: Series)
}

class SeriesListRouterImpl: SeriesListRouter {
    
    //MARK: - Properties
    weak var navigationController: UINavigationController?
    
    func goToSeriesDetail(with model: Series) {
        guard let navigationController = navigationController else {return}

        navigationController.pushViewController(SeriesDetailFactory.makeController(with: model, navigationController: navigationController), animated: true)
    }
}
