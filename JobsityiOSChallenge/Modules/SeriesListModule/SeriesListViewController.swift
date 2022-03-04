//
//  SeriesListViewController.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import UIKit

protocol SeriesListPresenter {
    func presentSeries(with model: [SeriesModel])
    func presentSearchedResults(with model: [SeriesSearchModel])
    func presentError(with error: SeriesListServiceError)
}

class SeriesListViewController: UIViewController, SeriesListPresenter {
    
    //MARK: - Properties
    var listView: SeriesListView?
    
    //MARK: - View LifeCycle
    override func loadView() {
        super.loadView()
        view = listView
        listView?.setNavigationItem(with: navigationItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView?.viewDidLoad()
    }
    
    func presentSeries(with model: [SeriesModel]) {
        listView?.updateSeriesModel(with: model)
    }
    
    func presentError(with error: SeriesListServiceError) {
        print(error.description)
    }
    
    func presentSearchedResults(with model: [SeriesSearchModel]) {
        listView?.updateSeriesSearchModel(with: model)
    }
}
