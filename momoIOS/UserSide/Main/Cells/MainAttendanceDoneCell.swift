//
//  MainAttendanceDoneCell.swift
//  momoIOS
//
//  Created by 임수현 on 2023/01/31.
//

import UIKit
import SnapKit

class MainAttendanceDoneCell: UITableViewCell {
    private let attendanceDoneImageView: UIImageView = UIImageView(image: UIImage(named: "attendanceDone"))
    private let titleLabel: UILabel = UILabel()
    private let timeStatusContainerView: UIStackView = UIStackView()
    private let timeLabel: UILabel = UILabel()
    private let statusLabel: UILabel = UILabel()
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
        self.setupAttendanceDoneImageView()
        self.setupTitleLabel()
        self.setupTimeStatusViews()
        self.setupHistoryButton()
    }
    
    private func setupAttendanceDoneImageView() {
        self.attendanceDoneImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.attendanceDoneImageView)
    }
    
    private func setupTitleLabel() {
        self.titleLabel.text = "출석이 완료되었습니다"
        self.titleLabel.font = .pretendard(size: 24, weight: .w600)
        self.titleLabel.textColor = .gray800
        self.contentView.addSubview(self.titleLabel)
    }
    
    private func setupTimeStatusViews() {
        self.timeStatusContainerView.axis = .horizontal
        self.timeStatusContainerView.spacing = 8
        self.timeStatusContainerView.alignment = .center
        
        self.timeLabel.text = "2023.01.07 PM12:30"
        self.timeLabel.font = .body16
        self.timeLabel.textColor = .gray800
        self.timeStatusContainerView.addArrangedSubview(self.timeLabel)
        
        let view = UIView()
        view.backgroundColor = .black
        self.timeStatusContainerView.addArrangedSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(12)
        }
        
        self.statusLabel.text = "정상출석 완료!" // "지각(-5점)"
        self.statusLabel.font = .body16
        self.statusLabel.textColor = .gray800
        self.timeStatusContainerView.addArrangedSubview(self.statusLabel)
        
        self.contentView.addSubview(self.timeStatusContainerView)
    }
    
    private func setupHistoryButton() {
        self.historyButton.addTarget(self, action: #selector(didTapHistoryButton), for: .touchUpInside)
        self.historyButton.setTitle("출석 히스토리  →", font: .body16, color: .gray800)
        self.historyButton.configurate(bgColor: .p200, cornerRadius: 24, edgeInsets: .init(top: 12, leading: 24, bottom: 12, trailing: 20))
        self.contentView.addSubview(self.historyButton)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        let screenWidth = UIScreen.main.bounds.width
        self.attendanceDoneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(163/375 * screenWidth)
            make.height.equalTo(106/375 * screenWidth)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.attendanceDoneImageView.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
        }
        
        self.timeStatusContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        self.historyButton.snp.makeConstraints { make in
            make.top.equalTo(self.timeStatusContainerView.snp.bottom).offset(28)
            make.bottom.equalToSuperview().inset(45)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func didTapHistoryButton() {
        self.historyButtonAction?()
    }
}
