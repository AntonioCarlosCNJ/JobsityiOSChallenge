//
//  SeriesListInteractor.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import Foundation

protocol SeriesListInteractor {
    func getSeries()
    func searchSeries(with query: String)
}

class SeriesListInteractorImpl: SeriesListInteractor {
    
    //MARK: - Properties
    var presenter: SeriesListPresenter?
    var router: SeriesListRouter?
    private let service: SeriesListServiceImpl?
    
    private var page: Int = 0
    
    init(service: SeriesListServiceImpl) {
        self.service = service
    }
    
    func getSeries() {
        service?.list(page: page, handle: {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let seriesModel):
                self.presenter?.presentSeries(with: seriesModel ?? [])
                self.page += 1
            case .error(let error):
                self.presenter?.presentError(with: SeriesListServiceError(code: error?.response?.statusCode ?? 500))
            }
        })
    }
    
    func searchSeries(with query: String) {
        service?.search(query: query, handle: {[weak self] result in
            switch result {
            case .success(let seriesModel):
                self?.presenter?.presentSearchedResults(with: seriesModel ?? [])
            case .error(let error):
                self?.presenter?.presentError(with: SeriesListServiceError(code: error?.response?.statusCode ?? 500))
            }
        })
    }
    
}
