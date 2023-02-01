//
//  MainSessionDetailCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//

import Foundation
import SnapKit
import UIKit

// MARK: - 메인 세션 내용 정보 cell
class MainSessionDetailCell: UITableViewCell {
    let sessionMessageLayout = UIView()
    let sessionMessageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionDetailCell")
        self.initViews()
    }
    
    private func initViews() {
        self.contentView.addSubviews(sessionMessageLabel, sessionMessageLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/*
 sessionMessageLayout.snp.makeConstraints() { make in
     make.top.equalTo(sessionDdayLayout.snp.bottom).offset(19)
     make.leading.equalToSuperview().offset(26)
     make.trailing.equalToSuperview().offset(-26)
     make.height.equalTo(123)
 }
 sessionMessageLayout.layer.cornerRadius = 12
 sessionMessageLayout.backgroundColor = .systemGray5
 sessionMessageLayout.addSubview(sessionMessageLabel)
 
 sessionMessageLabel.snp.makeConstraints() { make in
     make.center.equalToSuperview()
     make.top.equalToSuperview().offset(21)
     make.leading.equalToSuperview().offset(16)
     make.trailing.equalToSuperview().offset(-16)
 }
 sessionMessageLabel.text = "#기획 #MVP #와이어프레임\n\n팀별로 구현할 서비스의 핵심 기능과 개발 일정을 구성원이 다 함께 기획합니다. 2달 간의 정규 활동을 통해 서비스를 런칭할 수 있도록 열정 가득한 시작을 함께해보세요!"
 sessionMessageLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
 sessionMessageLabel.textColor = UIColor(Hex: 0x717171)
 sessionMessageLabel.textAlignment = .justified
 sessionMessageLabel.numberOfLines = 0
