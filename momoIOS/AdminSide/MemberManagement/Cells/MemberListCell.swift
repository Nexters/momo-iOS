//
//  MemberListCell.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/26.
//

import UIKit
import SnapKit

final class MemberListCell: UITableViewCell {
    static let identifier = "MemberListCell"
    
    private let nameLabel: UILabel = UILabel()
    private let generationLabel: UILabel = UILabel()
    private let jobLabel: UILabel = UILabel()
    private let attendanceStatusButton: UIButton = UIButton()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.identifier)
        
        self.selectionStyle = .none
        self.setupViews()
        self.setupLayout()
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.nameLabel.text = "홍길동"
        self.nameLabel.font = .body16
        self.nameLabel.textColor = .gray800
        
        self.generationLabel.text = "22기"
        self.generationLabel.font = .body16
        self.generationLabel.textColor = .gray800
        
        self.jobLabel.text = "Developer"
        self.jobLabel.font = .body16
        self.jobLabel.textColor = .gray800
        
        self.attendanceStatusButton.setTitle("출석", font: .tag2, color: .white)
        self.attendanceStatusButton.configurate(bgColor: .attendanceCheck, cornerRadius: 6, edgeInsets: .init(top: 0, leading: 11, bottom: 0, trailing: 11))
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.contentView.addSubviews(self.nameLabel, self.generationLabel, self.jobLabel, self.attendanceStatusButton)
        
        self.contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(56)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        
        self.generationLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(92)
            make.leading.greaterThanOrEqualTo(self.nameLabel.snp.trailing).offset(12)
        }
        
        self.jobLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(141)
            make.leading.greaterThanOrEqualTo(self.generationLabel.snp.trailing).offset(12)
        }
        
        self.attendanceStatusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(self.jobLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(57)
            make.height.equalTo(28)
        }
    }
}
