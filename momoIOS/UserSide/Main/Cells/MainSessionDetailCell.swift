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
    let titleLabel = UILabel()
    let topLine = UIView()
    let sessionMessageTitle = PaddingLabel(radius: 4, color: UIColor(hex: 0xF8F8F9), verticalInset: 10, horizontalInset: 13)
    let sessionMessageContent = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionDetailCell")
        self.selectionStyle = .none
        
        self.initViews()
        self.setConstraints()
    }
    
    private func initViews() {
        self.contentView.addSubviews(titleLabel, topLine, sessionMessageTitle, sessionMessageContent)
        
        titleLabel.text = "무엇을 하나요?"
        titleLabel.font = .title20
        titleLabel.textColor = .gray800
        
        topLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        
        sessionMessageTitle.text = "1주차, 우리 조를 구성해봐요!"
        sessionMessageTitle.font = .body16
        sessionMessageTitle.textColor = .gray800
        sessionMessageTitle.textAlignment = .left
        sessionMessageTitle.numberOfLines = 0
        
        setAttrString(str: "팀별로 구현할 서비스의 핵심 기능과 개발 일정을 구성원이 다 함께 기획합니다. 2달 간의 정규 활동을 통해 서비스를 런칭할 수 있도록 열정 가득한 시작을 함께해보세요!")
        sessionMessageContent.numberOfLines = 0
    }
    
    func setAttrString(str: String) {
        let attrStr = NSMutableAttributedString(string: str)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        attrStr.addAttributes([.font: UIFont.body14, .foregroundColor: UIColor.gray700, .paragraphStyle: paragraph], range: NSRange(location: 0, length: str.count))
        sessionMessageContent.attributedText = attrStr
    }
    
    private func setConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(228)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        topLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        sessionMessageTitle.snp.makeConstraints { make in
            make.top.equalTo(topLine.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        sessionMessageContent.snp.makeConstraints { make in
            make.top.equalTo(sessionMessageTitle.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
