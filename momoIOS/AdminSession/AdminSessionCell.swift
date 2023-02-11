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
    let sessionDdayLayout = UIView()
    let sessionDdayLabel = UILabel()
    let sessionDateLabel = UILabel()
    let rightArrowImg = UIImageView()
    let sessionKeyworkLabel = UILabel()
    let sessionDetailLabel = UILabel()
    let cellHeight = UILabel()
    let checkCodeLayout = UIView()
    let checkCodeLabel = UILabel()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "AdminSessionCell")
        
        self.selectionStyle = .none
        setBaseView()
        setBaseConstraints()
    }
    
    private func setBaseView() {
        self.contentView.addSubviews(mainView)
        mainView.layer.cornerRadius = 13
        mainView.backgroundColor = UIColor(hex: 0xF5F5F5)
        
        self.mainView.addSubviews(sessionWeekLabel, sessionDdayLayout, sessionDdayLabel, sessionDateLabel, rightArrowImg, sessionKeyworkLabel, sessionDetailLabel, cellHeight)
        sessionWeekLabel.text = "1주차"
        sessionWeekLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        sessionDdayLayout.layer.cornerRadius = 6
        sessionDdayLayout.backgroundColor = UIColor(hex: 0x7087FF)
        
        sessionDdayLabel.text = "D-2"
        sessionDdayLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        sessionDdayLabel.textColor = .white
        
        sessionDateLabel.text = "2023.01.07"
        sessionDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        rightArrowImg.image = UIImage(systemName: "arrow.right")
        rightArrowImg.tintColor = UIColor(hex: 0x9F9F9F)
        
        sessionKeyworkLabel.text = "#기획 #MVP #와이어프레임"
        sessionKeyworkLabel.textColor = UIColor(hex: 0x717171)
        sessionKeyworkLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        sessionDetailLabel.text = "팀별로 구현할 서비스의 핵심 기능과 개발 일정을 구성원이 다 함께 기획합니다. 2달 간의 정규 활동을 통해 서비스를 런칭할 수 있도록 열정 가득한 시작을 함께해보세요!"
        sessionDetailLabel.numberOfLines = 0
        sessionDetailLabel.textAlignment = .justified
        sessionDetailLabel.textColor = UIColor(hex: 0x717171)
        sessionDetailLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }

    private func setBaseConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(6)
        }

        sessionWeekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }

        sessionDdayLabel.snp.makeConstraints { make in
            make.center.equalTo(sessionDdayLayout)
        }

        sessionDdayLayout.snp.makeConstraints { make in
            make.centerY.equalTo(sessionWeekLabel)
            make.leading.equalTo(sessionWeekLabel.snp.trailing).offset(8)
            make.width.greaterThanOrEqualTo(sessionDdayLabel.intrinsicContentSize.width + 22)
            make.height.equalTo(28)
        }

        sessionDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalTo(sessionWeekLabel)
        }

        rightArrowImg.snp.makeConstraints { make in
            make.size.equalTo(15)
            make.centerY.equalTo(sessionDateLabel)
            make.right.equalToSuperview().inset(20)
        }

        sessionKeyworkLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionWeekLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        sessionDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionKeyworkLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    
        cellHeight.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(sessionDetailLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    func setCheckCodeView() {
        mainView.addSubviews(checkCodeLayout, checkCodeLabel)
        
        cellHeight.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(checkCodeLayout.snp.top)
            make.top.equalTo(sessionDetailLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(20)
        }
        
        checkCodeLayout.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(56)
        }
        checkCodeLayout.layer.masksToBounds = true
        checkCodeLayout.layer.cornerRadius = 13
        checkCodeLayout.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        checkCodeLayout.backgroundColor = UIColor(hex: 0x9272EC)
        
        checkCodeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkCodeLayout)
            make.leading.equalTo(checkCodeLayout).offset(20)
        }
        checkCodeLabel.text = "출석체크 코드 8237"
        checkCodeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        checkCodeLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
