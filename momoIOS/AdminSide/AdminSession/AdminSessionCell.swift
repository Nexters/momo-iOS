//
//  AdminSessionCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/09.
//

import UIKit
import SnapKit

// MARK: - 어드민 세션 table view cell
class AdminSessionCell: UITableViewCell {
    let mainView = UIView()
    let sessionWeekLabel = UILabel()
    let sessionDdayLabel = PaddingLabel(radius: 8, color: .main, verticalInset: 4, horizontalInset: 9)
    let sessionDateLabel = UILabel()
    let rightArrowImg = UIImageView()
    let sessionKeyworkLabel = PaddingLabel(radius: 4, color: UIColor(hex: 0xF6F6F6), verticalInset: 4, horizontalInset: 10)
    let sessionDetailLabel = UILabel()
    let cellHeight = UILabel()
    let checkCodeLayout = UIView()
    let checkCodeLabel = UILabel()
    let checkLockImg = UIImageView()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "AdminSessionCell")
        
        self.selectionStyle = .none
        setBaseView()
        setBaseConstraints()
    }
    
    private func setBaseView() {
        self.contentView.addSubviews(mainView)
        self.contentView.backgroundColor = UIColor(hex: 0xF6F6F6)
        self.mainView.backgroundColor = .white
        
        self.mainView.addSubviews(sessionWeekLabel, sessionDdayLabel, sessionDateLabel, rightArrowImg, sessionKeyworkLabel, sessionDetailLabel, cellHeight)
        sessionWeekLabel.text = "1주차"
        sessionWeekLabel.textColor = .gray800
        sessionWeekLabel.font = .title20
        
        sessionDdayLabel.text = "Today"
        sessionDdayLabel.font = .pretendard(size: 14, weight: .w600)
        sessionDdayLabel.textColor = .white
        
        sessionDateLabel.text = "2023.01.07"
        sessionDateLabel.textColor = .gray800
        sessionDateLabel.font = .body14
        
        rightArrowImg.image = UIImage(systemName: "arrow.right")
        rightArrowImg.tintColor = .gray600
        
        sessionKeyworkLabel.text = "우리 조를 구성해봐요!"
        sessionKeyworkLabel.textColor = .gray800
        sessionKeyworkLabel.font = .body14
        
        setAttrString(str: "팀별로 구현할 서비스의 핵심 기능과 개발 일정을 구성원이 다 함께 기획합니다. 2달 간의 정규 활동을 통해 서비스를 런칭할 수 있도록 열정 가득한 시작을 함께해보세요!")
        sessionDetailLabel.numberOfLines = 0
        
        checkCodeLayout.backgroundColor = UIColor(hex: 0xDFD0FF)
        
        checkCodeLabel.text = "출석체크 코드 8237"
        checkCodeLabel.font = .body18
        checkCodeLabel.textColor = .main
        
        checkLockImg.image = UIImage(named: "lock")
    }
    
    func setAttrString(str: String) {
        let attrStr = NSMutableAttributedString(string: str)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        attrStr.addAttributes([.font: UIFont.body14, .foregroundColor: UIColor.gray700, .paragraphStyle: paragraph], range: NSRange(location: 0, length: str.count))
        sessionDetailLabel.attributedText = attrStr
    }

    private func setBaseConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(6)
        }

        sessionWeekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }

        sessionDdayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sessionWeekLabel)
            make.leading.equalTo(sessionWeekLabel.snp.trailing).offset(8)
        }
        
        sessionDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(44)
            make.centerY.equalTo(sessionWeekLabel)
        }

        rightArrowImg.snp.makeConstraints { make in
            make.size.equalTo(15)
            make.centerY.equalTo(sessionDateLabel)
            make.trailing.equalToSuperview().inset(27)
        }

        sessionKeyworkLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionWeekLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().inset(20)
        }

        sessionDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionKeyworkLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    
        cellHeight.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(sessionDetailLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    func setCheckCodeView() {
        mainView.addSubviews(checkCodeLayout, checkCodeLabel, checkLockImg)
        
        checkCodeLayout.addSubviews(checkCodeLabel, checkLockImg)
        cellHeight.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(checkCodeLayout.snp.top)
            make.top.equalTo(sessionDetailLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(20)
        }
        
        checkCodeLayout.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(72)
        }
        
        checkCodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        checkLockImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(52)
            make.height.equalTo(36)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
