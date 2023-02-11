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
    let sessionDateLaebl = UILabel()
    let sessionDdayLayout = UIView()
    let sessionDdayLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionTimeCell")
        self.initViews()
        self.setConstraints()
    }
    
    private func initViews() {
        self.contentView.addSubviews(sessionWeekLabel, sessionDateLaebl, sessionDdayLayout, sessionDdayLabel)
        
        sessionWeekLabel.text = "1주차"
        sessionWeekLabel.textColor = .black
        sessionWeekLabel.sizeToFit()
        sessionWeekLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        sessionDateLaebl.text = "23.01.07 토요일 pm1:00"
        sessionDateLaebl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        sessionDdayLayout.backgroundColor = UIColor(hex: 0x7087FF)
        sessionDdayLayout.layer.cornerRadius = 6
        
        sessionDdayLayout.addSubview(sessionDdayLabel)
        sessionDdayLabel.text = "D-3"
        sessionDdayLabel.textColor = .white
        sessionDdayLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private func setConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        sessionWeekLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        sessionDateLaebl.snp.makeConstraints { make in
            make.top.equalTo(sessionWeekLabel)
            make.leading.equalTo(sessionWeekLabel.snp.trailing).offset(10)
        }
        
        sessionDdayLayout.snp.makeConstraints { make in
            make.centerY.equalTo(sessionWeekLabel)
            make.leading.equalTo(sessionDateLaebl.snp.trailing).offset(10)
            make.height.equalTo(28)
            make.width.equalTo(47)
        }
        
        sessionDdayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
