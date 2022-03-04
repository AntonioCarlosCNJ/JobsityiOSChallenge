//
//  SeriesDetailView.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

protocol SeriesDetailView: UIView {
    func viewDidLoad()
    func setNavigationTitle(in navigationItem: UINavigationItem)
    func updateSeasonModels(with seasonModels: [SeasonModel])
}

class SeriesDetailViewImpl: UIView, SeriesDetailView {
    
    //MARK: - Properties
    var interactor: SeriesDetailInteractor?
    var model: Series
    var seasonModels: [SeasonModel] = []
    
    //MARK: - Initializer
    init(with model: Series) {
        self.model = model
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let mainInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let airsTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private let genresLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private let summaryLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let tableHeaderViewLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.text = "Episodes List"
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
    }()
    
    //MARK: - Methods
    func viewDidLoad() {
        interactor?.getEpisodes(with: model.id)
        
        backgroundColor = .white
        
        configureTableView()
        configurePosterImageView()
        configureNameLabel()
        configureGenresLabel()
        configureAirsTimeLabel()
        configureSummaryLabel()
        
        setupView()
    }
    
    func setNavigationTitle(in navigationItem: UINavigationItem) {
        navigationItem.title = model.name
    }
    
    func updateSeasonModels(with seasonModels: [SeasonModel]) {
        self.seasonModels = seasonModels
        reloadData()
    }
    
    private func configureTableView() {
        tableView.tableHeaderView = tableHeaderViewLabel
    }
    
    private func configurePosterImageView() {
        guard let url = URL(string: model.imageUrl ?? "") else {return}
        posterImageView.load(url: url)
    }
    
    private func configureNameLabel() {
        nameLabel.text = model.name
    }
    
    private func configureGenresLabel() {
        genresLabel.attributedText(withString: "Genres: \((model.genres?.joined(separator: ", ")) ?? "")", boldString: "Genres", font: UIFont.systemFont(ofSize: 15))
    }
    
    private func configureAirsTimeLabel() {
        guard let premieredDate = model.premieredDate else {return}
        
        if let endedDate = model.endedDate {
            airsTimeLabel.text = "Time Airs: \(getDayBetweenDates(premieredDate, endedDate)) days."
        } else {
            airsTimeLabel.text = "Time Airs: \(getDayBetweenDates(premieredDate, Date.now)) days. (Still on Air)"
        }
        
        airsTimeLabel.attributedText(withString: airsTimeLabel.text ?? "", boldString: "Time Airs", font: UIFont.systemFont(ofSize: 15))
    }
    
    private func configureSummaryLabel() {
        summaryLabel.setHtmlAttributedString(with: "\(model.summary?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "") ?? "")", font: UIFont.systemFont(ofSize: 15))
        summaryLabel.textAlignment = .center
    }
    
    private func getDayBetweenDates(_ date1: Date, _ date2: Date) -> Int {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: date1)
        let date2 = calendar.startOfDay(for: date2)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.snp.updateConstraints { make in
                make.height.equalTo(self.tableView.contentSize.height)
            }
        }
    }
}

extension SeriesDetailViewImpl: ViewCode {
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(mainInformationStackView)
        contentView.addSubview(tableView)
        
        mainInformationStackView.addArrangedSubview(nameLabel)
        mainInformationStackView.addArrangedSubview(summaryLabel)
        mainInformationStackView.addArrangedSubview(genresLabel)
        mainInformationStackView.addArrangedSubview(airsTimeLabel)
    }
    
    func setupConstraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        
        setupPosterImageViewConstraints()
        setupMainInformationStackViewConstraints()
        setupConstraintsOfTableView()

        genresLabel.snp.makeConstraints { make in
            make.width.equalTo(mainInformationStackView.snp.width)
        }

        airsTimeLabel.snp.makeConstraints { make in
            make.width.equalTo(mainInformationStackView.snp.width)
        }
        
        summaryLabel.snp.makeConstraints { make in
            make.width.equalTo(mainInformationStackView.snp.width)
        }
    }

    private func setupScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupContentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    private func setupPosterImageViewConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(60)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
            make.top.equalTo(contentView.snp.top).inset(10)
        }
    }
    
    private func setupMainInformationStackViewConstraints() {
        mainInformationStackView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(10)
        }
    }
    
    private func setupConstraintsOfTableView() {
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(mainInformationStackView.snp.bottom).inset(-10)
            make.trailing.leading.equalTo(mainInformationStackView)
            make.height.equalTo(tableView.contentSize.height)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

extension SeriesDetailViewImpl: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonModels[section].episodes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasonModels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(seasonModels[section].season)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = seasonModels[indexPath.section].episodes[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(episode.number ?? 1). \(episode.name ?? "")"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
