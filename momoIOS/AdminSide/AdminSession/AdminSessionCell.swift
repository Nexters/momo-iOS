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
    let sessionDdayLabel = PaddingLabel(radius: 8, color: .main)
    let sessionDateLabel = UILabel()
    let rightArrowImg = UIImageView()
    let sessionKeyworkLabel = PaddingLabel(radius: 4, color: UIColor(hex: 0xF6F6F6))
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
        sessionWeekLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        sessionDdayLabel.text = "Today"
        sessionDdayLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        sessionDdayLabel.textColor = .white
        
        sessionDateLabel.text = "2023.01.07"
        sessionDateLabel.textColor = .gray800
        sessionDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        rightArrowImg.image = UIImage(systemName: "arrow.right")
        rightArrowImg.tintColor = UIColor(hex: 0x797979)
        
        sessionKeyworkLabel.text = "우리 조를 구성해봐요!"
        sessionKeyworkLabel.textColor = .gray800
        sessionKeyworkLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        sessionDetailLabel.text = "팀별로 구현할 서비스의 핵심 기능과 개발 일정을 구성원이 다 함께 기획합니다. 2달 간의 정규 활동을 통해 서비스를 런칭할 수 있도록 열정 가득한 시작을 함께해보세요!"
        sessionDetailLabel.numberOfLines = 0
        sessionDetailLabel.textAlignment = .justified
        sessionDetailLabel.textColor = .gray700
        sessionDetailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
            make.right.equalToSuperview().inset(27)
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
            make.height.equalTo(60)
        }
        checkCodeLayout.backgroundColor = .main
        
        checkCodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        checkCodeLabel.text = "출석체크 코드 8237"
        checkCodeLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(500))
        checkCodeLabel.textColor = .white
        
        checkLockImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(52)
            make.height.equalTo(36)
            make.centerY.equalToSuperview()
        }
        checkLockImg.image = UIImage(named: "Lock")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PaddingLabel: UILabel {
    var topInset: CGFloat = 4.0
    var bottomInset: CGFloat = 4.0
    var leftInset: CGFloat = 10.0
    var rightInset: CGFloat = 10.0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }

    convenience init(radius: CGFloat, color: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = color
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset) }
    }
}
