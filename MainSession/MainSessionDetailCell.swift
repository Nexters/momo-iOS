//
//  MainSessionDetailCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//
import SnapKit
import UIKit

// MARK: - 메인 세션 내용 정보 cell
class MainSessionDetailCell: UITableViewCell {
    let sessionMessageLayout = UIView()
    let sessionMessageTitle = UILabel()
    let sessionMessageContent = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionDetailCell")
        self.initViews()
        self.setConstraints()
    }
    
    private func initViews() {
        self.contentView.addSubview(sessionMessageLayout)
        sessionMessageLayout.layer.cornerRadius = 12
        sessionMessageLayout.backgroundColor = .systemGray5
        sessionMessageLayout.addSubviews(sessionMessageTitle, sessionMessageContent)
        
        sessionMessageTitle.text = "#기획 #MVP #와이어프레임"
        sessionMessageTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        sessionMessageTitle.textColor = UIColor(hex: 0x717171)
        sessionMessageTitle.textAlignment = .left
        sessionMessageTitle.numberOfLines = 0
        
        sessionMessageContent.text = "팀별로 구현할 서비스의 핵심 기능과 개발 일정을 구성원이 다 함께 기획합니다. 2달 간의 정규 활동을 통해 서비스를 런칭할 수 있도록 열정 가득한 시작을 함께해보세요!"
        sessionMessageContent.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        sessionMessageContent.textColor = UIColor(hex: 0x717171)
        sessionMessageContent.textAlignment = .justified
        sessionMessageContent.numberOfLines = 0
    }
    
    private func setConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.leading.trailing.equalToSuperview()
        }
        
        sessionMessageLayout.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(123)
        }
        
        sessionMessageTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        sessionMessageContent.snp.makeConstraints { make in
            make.top.equalTo(sessionMessageTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
