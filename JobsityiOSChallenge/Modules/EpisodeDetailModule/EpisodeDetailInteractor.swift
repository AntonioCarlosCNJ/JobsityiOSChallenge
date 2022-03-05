//
//  EpisodeDetailInteractor.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import Foundation

protocol EpisodeDetailInteractor {}

class EpisodeDetailInteractorImpl: EpisodeDetailInteractor {
    
    //MARK: - Properties
    var presenter: EpisodeDetailPresenter?
    var router: EpisodeDetailRouter?
    
}
