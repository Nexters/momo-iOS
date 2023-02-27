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
    private let disableButton: UIButton = UIButton()
    
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
        
        self.disableButton.setTitle("비활성화", font: .tag1, color: .gray800)
        self.disableButton.configurate(bgColor: .white, strokeColor: .gray500, strokeWidth: 1, cornerRadius: 6, padding: 0)
        self.disableButton.addTarget(self, action: #selector(showDisableMemberAlert), for: .touchUpInside)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.contentView.addSubviews(self.nameLabel, self.generationLabel, self.jobLabel, self.disableButton)
        
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
        
        self.disableButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(self.jobLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(57)
            make.height.equalTo(28)
        }
    }
    
    // MARK: - Action
    @objc private func showDisableMemberAlert() {
        let alert = CommonBottomAlert()
        alert.configure(title: "\(self.nameLabel.text ?? "홍길동")님을 비활성화 할까요?", description: "비활성화한다면 \(self.nameLabel.text ?? "홍길동")님은 \(self.generationLabel.text ?? "22기") 활동이 중단됩니다.", cancelTitle: "취소", confirmTitle: "비활성화", cancelCompletion: nil) {
            // TODO: 비활성화 로직 추가
        }
        alert.show()
    }
}
