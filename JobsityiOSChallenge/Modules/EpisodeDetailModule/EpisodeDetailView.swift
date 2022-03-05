//
//  EpisodeDetailView.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

protocol EpisodeDetailView: UIView {
    func viewDidLoad()
}

class EpisodeDetailViewImpl: UIView, EpisodeDetailView {
    
    //MARK: - Properties
    var interactor: EpisodeDetailInteractor?
    var episode: EpisodeModel
    
    //MARK: - Initializers
    init(with episode: EpisodeModel) {
        self.episode = episode
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Views
    private let vStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let numberLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let seasonLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let summaryLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //MARK: - Methods
    func viewDidLoad() {
        backgroundColor = .white
        
        configureNameLabel()
        configureSeasonLabel()
        configureNumberLabel()
        configurePosterImageView()
        configureSummaryLabel()
        
        setupView()
    }
    
    private func configureNameLabel() {
        nameLabel.text = episode.name
    }
    
    private func configureSeasonLabel() {
        seasonLabel.attributedText(withString: "Season: \(episode.season ?? 0)", boldString: "Season", font: .systemFont(ofSize: 15))
    }
    
    private func configureNumberLabel() {
        numberLabel.attributedText(withString: "Episode Number: \(episode.number ?? 0)", boldString: "Episode Number", font: .systemFont(ofSize: 15))
    }
    
    private func configurePosterImageView() {
        guard let url = URL(string: episode.imageUrl ?? "") else {posterImageView.image = UIImage(named: "noImage"); posterImageView.contentMode = .scaleAspectFit; return}
        posterImageView.load(url: url)
    }
    
    private func configureSummaryLabel() {
        summaryLabel.setHtmlAttributedString(with: "\(episode.summary?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "") ?? "")", font: UIFont.systemFont(ofSize: 15))
        summaryLabel.textAlignment = .center
    }
}

extension EpisodeDetailViewImpl: ViewCode {
    func setupHierarchy() {
        addSubview(vStackView)
        
        vStackView.addArrangedSubview(nameLabel)
        vStackView.addArrangedSubview(hStackView)
        
        hStackView.addArrangedSubview(seasonLabel)
        hStackView.addArrangedSubview(numberLabel)
        
        vStackView.addArrangedSubview(posterImageView)
        vStackView.addArrangedSubview(summaryLabel)
    }
    
    func setupConstraints() {
        setupVStackViewConstraints()
        setupHStackViewContraints()
        setupSeasonLabelAndNumberLabelContrainsts()
        setupPosterImageViewConstraints()
        setupSummaryLabelConstraints()
    }
    
    private func setupVStackViewConstraints() {
        vStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(30)
        }
    }
    
    private func setupHStackViewContraints() {
        hStackView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(posterImageView)
        }
    }
    
    private func setupSeasonLabelAndNumberLabelContrainsts() {
        seasonLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    private func setupPosterImageViewConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(vStackView)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(0.6)
        }
    }
    
    private func setupSummaryLabelConstraints() {
        summaryLabel.snp.makeConstraints { make in
            make.trailing.leading.equalTo(posterImageView)
        }
    }
}
