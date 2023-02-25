//
//  MainSessionInfoCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//
import UIKit
import SnapKit

// MARK: - 메인 세션 정보 cell
class MainSessionInfoCell: UITableViewCell {
    let mainView = UIView()
    let titleLabel = UILabel()
    let topLine = UIView()
    let bottomLine = UIView()
    let verticalLine = UIView()
    
    let sessionTimeLabel = PaddingLabel(radius: 4, color: UIColor(hex: 0xF4EFFF), verticalInset: 4, horizontalInset: 12)
    let sessionTime = UILabel()
    let sessionPlaceLabel = PaddingLabel(radius: 4, color: UIColor(hex: 0xF4EFFF), verticalInset: 4, horizontalInset: 12)
    let sessionPlace = UILabel()
    
    let findRoadBtn = UIButton()
    let moreDetailBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionInfoCell")
        self.selectionStyle = .none
        
        self.initViews()
        self.setTopConstraints()
        self.setBottomConstraints()
    }

    private func initViews() {
        self.contentView.addSubview(mainView)
        self.contentView.backgroundColor = UIColor(hex: 0xF6F6F6)
        mainView.backgroundColor = .white
        
        self.mainView.addSubviews(titleLabel, topLine, sessionTimeLabel, sessionTime, sessionPlaceLabel, sessionPlace, bottomLine, verticalLine, findRoadBtn, moreDetailBtn)

        titleLabel.text = "상세정보"
        titleLabel.textColor = .gray800
        titleLabel.font = .title20
        
        topLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        bottomLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        verticalLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        
        findRoadBtn.setTitle("길찾기", font: .body16, color: .gray700)
        findRoadBtn.setImage(UIImage(named: "findRoadButton"), tintColor: .gray600, padding: 7, direction: .leading)
        
        moreDetailBtn.setTitle("세션 상세정보", font: .body16, color: .gray700)
        moreDetailBtn.setImage(UIImage(named: "clockButton"), tintColor: .gray600, padding: 7, direction: .leading)
        
        sessionTimeLabel.text = "시간"
        sessionTimeLabel.textColor = .main
        sessionTimeLabel.font = .body14

        sessionTime.text = "2023.01.07 토요일 오후 1:00"
        sessionTime.textAlignment = .right
        sessionTime.textColor = UIColor(hex: 0x454545)
        sessionTime.font = .body16
        
        sessionPlaceLabel.text = "장소"
        sessionPlaceLabel.textColor = .main
        sessionPlaceLabel.font = .body14
        
        sessionPlace.text = "서울특별시 강남구 역삼로 마루180 지하 1층"
        sessionPlace.textColor = UIColor(hex: 0x454545)
        sessionPlace.textAlignment = .right
        sessionPlace.numberOfLines = 0
        sessionPlace.font = .body16
    }
    
    private func setTopConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(280)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.bottom.equalToSuperview()
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
        
        sessionTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(topLine.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
    
        sessionTime.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(27)
            make.centerY.equalTo(sessionTimeLabel)
        }
        
        sessionPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionTimeLabel.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(24)
        }
        
        sessionPlace.snp.makeConstraints { make in
            make.centerY.equalTo(sessionPlaceLabel)
            make.leading.equalTo(sessionPlaceLabel.snp.trailing).offset(50)
            make.trailing.equalToSuperview().inset(27)
        }
    }
    
    private func setBottomConstraints() {
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(sessionPlace.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        verticalLine.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.width.equalTo(1)
        }
        
        findRoadBtn.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.height.equalTo(72)
            make.leading.equalToSuperview()
        }

        moreDetailBtn.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.height.equalTo(72)
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
