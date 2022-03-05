//
//  SeriesListTableViewCell.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import UIKit
import SnapKit

class SeriesListTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = String(describing: self)
    
    //MARK: - Views
    private let posterImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 10.0
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()
    
    private let summaryLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 5
        return lbl
    }()
    
    //MARK: - Methods
    public func setup(with model: Series) {
        configurePosterImageView(with: model.imageUrl ?? "")
        configureNameLabel(with: model.name ?? "")
        configureSummaryLabel(with: model.summary ?? "")
        
        accessoryType = .disclosureIndicator
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = UIImage(named: "placeholder")
        nameLabel.text = ""
        summaryLabel.text = ""
    }
    
    private func configurePosterImageView(with imageUrl: String) {
        guard let url = URL(string: imageUrl) else {posterImageView.image = UIImage(named: "noImage"); posterImageView.contentMode = .scaleAspectFit; return}
        posterImageView.load(url: url)
    }
    
    private func configureNameLabel(with name: String) {
        nameLabel.text = name
    }
    
    private func configureSummaryLabel(with summary: String) {
        summaryLabel.setHtmlAttributedString(with: summary, font: UIFont.systemFont(ofSize: 15, weight: .regular))
    }
}

extension SeriesListTableViewCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(summaryLabel)
    }
    
    func setupConstraints() {
        setupConstraintsOfPosterImageView()
        setupConstraintsOfNameLabel()
        setupConstraintsOfSummaryLabel()
    }
    
    private func setupConstraintsOfPosterImageView() {
        posterImageView.snp.remakeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(120)
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func setupConstraintsOfNameLabel() {
        nameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).inset(-5)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(posterImageView.snp.top)
        }
    }
    
    private func setupConstraintsOfSummaryLabel() {
        summaryLabel.snp.remakeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
        }
    }
}
