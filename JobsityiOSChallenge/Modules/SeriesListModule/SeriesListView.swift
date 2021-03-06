//
//  SeriesListView.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import UIKit
import SnapKit

protocol SeriesListView: UIView {
    func viewDidLoad()
    func setNavigationItem(with navigationItem: UINavigationItem)
    func updateSeriesModel(with model: [SeriesModel])
    func updateSeriesSearchModel(with model: [SeriesSearchModel])
    func showErrorMessage(_ errorMessage: String, in vc: UIViewController)
    func startLoading()
    func stopLoading()
}

enum ViewState {
    case listing
    case searching
    case error
}

class SeriesListViewImpl: UIView, SeriesListView {
    
    //MARK: - Properties
    var interactor: SeriesListInteractor?
    
    var seriesModel: [SeriesModel] = []
    var searchSeriesModel: [SeriesSearchModel] = []
    
    var viewState: ViewState = .listing
    var navigationItem: UINavigationItem?
    var query: String = ""
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
        return activity
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.placeholder = " Search Here....."
        searchBar.delegate = self
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "empty"))
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    //MARK: - Methods
    func viewDidLoad() {
        configureActivityIndicatorToShowTheFirstLoading()
        interactor?.getSeries()
        
        configureTableView()
        setNavigationTitle()
        
        tableView.reloadData()
    }
    
    func setNavigationItem(with navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem
    }
    
    func updateSeriesModel(with model: [SeriesModel]) {
        seriesModel.append(contentsOf: model)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateSeriesSearchModel(with model: [SeriesSearchModel]) {
        searchSeriesModel = model
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
            self.activityIndicator.snp.removeConstraints()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showErrorMessage(_ errorMessage: String, in vc: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.createErrorAlert(with: errorMessage) {
                self.viewState == .listing ? self.interactor?.getSeries() : self.interactor?.searchSeries(with: self.query)
            }
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureTableView() {
        tableView.register(SeriesListTableViewCell.self, forCellReuseIdentifier: SeriesListTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setNavigationTitle() {
        navigationItem?.titleView = searchBar
    }
    
    private func toggleCancelButton(to value: Bool) {
        searchBar.setShowsCancelButton(value, animated: true)
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = value
        }
    }
    
    private func toggleEmptyImageView(to value: Bool) {
        emptyImageView.isHidden = value
    }
    
    private func configureActivityIndicatorToShowTheFirstLoading() {
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        activityIndicator.startAnimating()
    }
}

extension SeriesListViewImpl: ViewCode {
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(emptyImageView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.width.equalTo(emptyImageView.snp.height).multipliedBy(0.7)
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension SeriesListViewImpl: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = viewState == .listing ? seriesModel.count : searchSeriesModel.count
        toggleEmptyImageView(to: rowCount == 0 ? ((interactor?.isFirstLoading) ?? false)  : true)
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: Series = viewState == .listing ? seriesModel[indexPath.row] : searchSeriesModel[indexPath.row]
        interactor?.didSelectSeries(model: model)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesListTableViewCell.identifier, for: indexPath) as? SeriesListTableViewCell {
            let seriesModel: Series = viewState == .listing ? seriesModel[indexPath.row] : searchSeriesModel[indexPath.row]
            cell.setup(with: seriesModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && viewState != .searching && interactor?.isFirstLoading == false {
            activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
            
            self.tableView.tableFooterView = activityIndicator
            self.tableView.tableFooterView?.isHidden = false
            
            startLoading()
            interactor?.getSeries()
        }
    }
}

extension SeriesListViewImpl: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewState = .searching
        toggleCancelButton(to: true)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        toggleCancelButton(to: true)
        guard let query = searchBar.text else {return}
        self.query = query
        interactor?.searchSeries(with: self.query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewState = .listing
        toggleCancelButton(to: false)
        tableView.reloadData()
    }
}
