//
//  MainAttendanceDoneCell.swift
//  momoIOS
//
//  Created by 임수현 on 2023/01/31.
//

import UIKit
import SnapKit

class MainAttendanceDoneCell: UITableViewCell {
    private let cardView: UIView = UIView()
    private var iconImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let timeStatusContainerView: UIView = UIView()
    private let timeLabel: UILabel = UILabel()
    private let statusLabel: UILabel = UILabel()
    private let scoreLabel: UILabel = UILabel()
    private let historyButton: UIButton = UIButton()
    
    var historyButtonAction: (() -> Void)?
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainAttendanceDoneCell")
        
        self.selectionStyle = .none
        self.setupViews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    // TODO: ViewModel 바라보도록 수정 필요
    private func setupViews() {
        self.backgroundColor = .clear
        self.cardView.backgroundColor = .rgba(128, 135, 201, 1)
        self.cardView.layer.cornerRadius = 12
        self.contentView.addSubview(self.cardView)

        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupTimeStatusViews()
        self.setupScoreLabel()
        self.setupHistoryButton()
    }
    
    private func setupIconImageView() {
        let checkImage = UIImage(systemName: "checkmark.circle")
        self.iconImageView.image = checkImage
        self.iconImageView.tintColor = .white
        self.cardView.addSubview(self.iconImageView)
    }
    
    private func setupTitleLabel() {
        self.titleLabel.text = "출석이 완료되었습니다"
        self.titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        self.titleLabel.textColor = .white
        self.cardView.addSubview(self.titleLabel)
    }
    
    private func setupTimeStatusViews() {
        self.timeLabel.text = "2023.01.07 pm 1:30"
        self.timeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        self.timeLabel.textColor = .white
        self.timeStatusContainerView.addSubview(self.timeLabel)
        
        self.statusLabel.text = "지각😞"
        self.statusLabel.font = .systemFont(ofSize: 13, weight: .medium)
        self.statusLabel.textColor = .white
        self.timeStatusContainerView.addSubview(self.statusLabel)
        
        self.cardView.addSubview(self.timeStatusContainerView)
    }
    
    private func setupScoreLabel() {
        self.scoreLabel.text = "(-5점이 감점되었습니다)"
        self.scoreLabel.font = .systemFont(ofSize: 13, weight: .regular)
        self.scoreLabel.textColor = .white
        self.cardView.addSubview(self.scoreLabel)
    }
    
    private func setupHistoryButton() {
        self.historyButton.addTarget(self, action: #selector(didTapHistoryButton), for: .touchUpInside)
        self.historyButton.setTitle("출석 히스토리", size: 12, weight: .medium, color: .white)
        self.historyButton.configurate(bgColor: .white.withAlphaComponent(0.14), cornerRadius: 6, padding: 10)
        self.cardView.addSubview(self.historyButton)        
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.cardView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(19)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(31)
            make.size.equalTo(42)
            make.centerX.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.bottom).offset(31)
            make.centerX.equalToSuperview()
        }
        
        self.setupTimeStatusLabelsLayout()
        self.timeStatusContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(self.timeStatusContainerView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        self.historyButton.snp.makeConstraints { make in
            make.top.equalTo(self.scoreLabel.snp.bottom).offset(23)
            make.bottom.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTimeStatusLabelsLayout() {
        self.timeLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        self.statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.timeLabel.snp.trailing).offset(7)
            make.trailing.top.bottom.equalToSuperview()
        }        
    }
    
    // MARK: - Actions
    @objc private func didTapHistoryButton() {
        self.historyButtonAction?()
    }
}
