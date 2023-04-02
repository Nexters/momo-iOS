//
//  MainSessionTimeCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//
import UIKit
import SnapKit

// MARK: - 메인 세션 시간 정보 cell
class MainSessionTimeCell: UITableViewCell {
    let sessionWeekLabel = UILabel()
    let sessionDateLabel = UILabel()
    let sessionDdayLabel = PaddingLabel(radius: 8, color: .main, verticalInset: 4, horizontalInset: 9)
    let bottomLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionTimeCell")
        self.selectionStyle = .none
        
        self.initViews()
        self.setConstraints()
    }
    
    private func initViews() {
        self.backgroundColor = .clear
        self.contentView.addSubviews(sessionWeekLabel, sessionDateLabel, sessionDdayLabel, bottomLine)
        
        sessionWeekLabel.text = "1주차"
        sessionWeekLabel.textColor = .gray800
        sessionWeekLabel.font = .pretendard(size: 28, weight: .w600)
        
        sessionDateLabel.text = "23.01.07 토요일 Pm 1:00"
        sessionDateLabel.textColor = UIColor(hex: 0x222222, alpha: 0.6)
        sessionDateLabel.font = .body14
        
        sessionDdayLabel.text = "D-3"
        sessionDdayLabel.textColor = .white
        sessionDdayLabel.font = .pretendard(size: 14, weight: .w600)
        
        bottomLine.backgroundColor = UIColor(hex: 0x000000, alpha: 0.1)
    }
    
    private func setConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        
        sessionWeekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        sessionDateLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionWeekLabel.snp.bottom).offset(8)
            make.leading.equalTo(sessionWeekLabel)
        }
        
        sessionDdayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sessionWeekLabel)
            make.leading.equalTo(sessionWeekLabel.snp.trailing).offset(10)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
