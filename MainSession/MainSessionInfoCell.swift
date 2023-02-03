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
    let sessionInfoLayout = UIView()
    let sessionTimeLabel = UILabel()
    let sessionTime = UILabel()
    let sessionPlaceLabel = UILabel()
    let sessionPlace = UILabel()
    let sessionPlaceAddress = UILabel()
    let findRoadBtn = UIButton()
    let line = UIView()
    let moreDetailBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionTimeCell")
        self.initViews()
        self.setViewConstraints()
        self.setLabelConstraints()
        self.setBtnConstraints()
    }

    private func initViews() {
        self.contentView.addSubviews(sessionInfoLayout)
    
        sessionInfoLayout.layer.borderColor = UIColor.systemGray5.cgColor
        sessionInfoLayout.layer.borderWidth = 1
        sessionInfoLayout.layer.cornerRadius = 12
        sessionInfoLayout.addSubviews(sessionTimeLabel, sessionTime, sessionPlaceLabel, sessionPlace, sessionPlaceAddress, findRoadBtn, line, moreDetailBtn)

        findRoadBtn.layer.cornerRadius = 7
        findRoadBtn.setTitle("길찾기", size: 12, weight: .medium, color: .black)
        findRoadBtn.backgroundColor = .systemGray5
        
        line.backgroundColor = .systemGray6
        
        moreDetailBtn.setTitle("세션 상세정보", size: 13, weight: .medium, color: .lightGray)
        moreDetailBtn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        moreDetailBtn.semanticContentAttribute = .forceRightToLeft
        moreDetailBtn.contentHorizontalAlignment = .fill
        moreDetailBtn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 10), forImageIn: .normal)
        moreDetailBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        
        setLabelAttribute()
    }
    
    private func setLabelAttribute() {
        sessionTimeLabel.text = "시간"
        sessionTimeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        sessionTime.text = "23.01.07 토요일 pm1:00~pm5:00"
        sessionTime.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        sessionPlaceLabel.text = "장소"
        sessionPlaceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        sessionPlace.text = "마루 180"
        sessionPlace.lineBreakMode = .byTruncatingTail
        sessionPlace.textAlignment = .left
        sessionPlace.font = UIFont.systemFont(ofSize: 14, weight: .medium)

        sessionPlaceAddress.text = "서울특별시 강남구 역삼로 180"
        sessionPlaceAddress.sizeToFit()
        sessionPlaceAddress.textColor = UIColor(hex: 0x5A5A5A)
        sessionPlaceAddress.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private func setLabelConstraints() {
        sessionTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(22)
            make.width.equalTo(25)
        }
    
        sessionTime.snp.makeConstraints { make in
            make.top.equalTo(sessionTimeLabel)
            make.leading.equalTo(sessionTimeLabel.snp.trailing).offset(8)
        }
        
        sessionPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionTimeLabel.snp.bottom).offset(12)
            make.width.equalTo(25)
            make.leading.equalTo(sessionTimeLabel)
        }
        
        sessionPlace.snp.makeConstraints { make in
            make.top.equalTo(sessionPlaceLabel)
            make.leading.equalTo(sessionPlaceLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        sessionPlaceAddress.snp.makeConstraints { make in
            make.top.equalTo(sessionPlaceLabel.snp.bottom).offset(12)
            make.leading.equalTo(sessionTimeLabel)
        }
    }

    private func setViewConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }
        
        sessionInfoLayout.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(202)
        }
        
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-61)
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-11)
            make.height.equalTo(1)
        }
        
    }
    
    private func setBtnConstraints() {
        findRoadBtn.snp.makeConstraints { make in
            make.centerY.equalTo(sessionPlaceAddress)
            make.leading.equalTo(sessionPlaceAddress.snp.trailing).offset(13)
            make.width.equalTo(67)
            make.height.equalTo(30)
        }

        moreDetailBtn.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(23)
            make.width.equalTo(130)
            make.height.equalTo(16)
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
