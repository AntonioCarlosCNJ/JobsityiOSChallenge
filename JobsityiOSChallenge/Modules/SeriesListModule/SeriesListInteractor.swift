//
//  SeriesListInteractor.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import Foundation

protocol SeriesListInteractor {
    var isFirstLoading: Bool {get}
    
    func getSeries()
    func searchSeries(with query: String)
    func didSelectSeries(model: Series)
}

class SeriesListInteractorImpl: SeriesListInteractor {
    
    //MARK: - Properties
    var presenter: SeriesListPresenter?
    var router: SeriesListRouter?
    private let service: SeriesListServiceImpl
    
    var isFirstLoading: Bool {
        return page == 0
    }
    private var isFetching: Bool = false
    private var page: Int = 0
    
    //MARK: - Initializers
    init(service: SeriesListServiceImpl) {
        self.service = service
    }
    
    //MARK: - Methods
    func getSeries() {
        guard !isFetching else {return}
        isFetching = true
        service.list(page: page, handle: {[weak self] result in
            guard let self = self else {return}
            self.isFetching = false
            switch result {
            case .success(let seriesModel):
                self.presenter?.presentSeries(with: seriesModel ?? [])
                self.page += 1
            case .error(let error):
                self.presenter?.presentError(with: error?.message ?? "")
            }
        })
    }
    
    func searchSeries(with query: String) {
        service.search(query: query, handle: {[weak self] result in
            switch result {
            case .success(let seriesModel):
                self?.presenter?.presentSearchedResults(with: seriesModel ?? [])
            case .error(let error):
                self?.presenter?.presentError(with: error?.message ?? "")
            }
        })
    }
    
    func didSelectSeries(model: Series) {
        router?.goToSeriesDetail(with: model)
    }
    
}
