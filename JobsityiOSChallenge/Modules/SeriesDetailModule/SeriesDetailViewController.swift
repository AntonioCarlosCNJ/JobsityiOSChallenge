//
//  SeriesDetailViewController.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

protocol SeriesDetailPresenter {
    func presentError(with errorMessage: String)
    func presentEpisodes(with seasonModels: [SeasonModel])
}

class SeriesDetailViewController: UIViewController, SeriesDetailPresenter {
    
    //MARK: - Properties
    var detailView: SeriesDetailView?

    //MARK: - View LifeCycle
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView?.viewDidLoad()
        detailView?.setNavigationTitle(in: navigationItem)
    }
    
    func presentEpisodes(with seasonModels: [SeasonModel]) {
        detailView?.updateSeasonModels(with: seasonModels)
    }
    
    func presentError(with errorMessage: String) {
        print(errorMessage)
    }

}
