//
//  EpisodeDetailViewController.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

protocol EpisodeDetailPresenter {}

class EpisodeDetailViewController: UIViewController, EpisodeDetailPresenter {
    
    //MARK: - Properties
    var detailView: EpisodeDetailView?

    //MARK: - View LifeCycle
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView?.viewDidLoad()
    }

}
