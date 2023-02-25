//
//  MainSessionNoInfoCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//
import UIKit
import SnapKit

// MARK: - 메인 세션 정보가 없을 때의 cell
class MainSessionNoInfoCell: UITableViewCell {
    let mainView = UIView()
    let titleLabel = UILabel()
    let titleLine = UIView()
    let sessionNoInfoImage = UIImageView()
    let noInfoMessageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionNoInfoCell")
        self.selectionStyle = .none
        
        self.initViews()
    }
    
    private func initViews() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(326)
        }
        self.contentView.addSubview(mainView)
        self.contentView.backgroundColor = UIColor(hex: 0xF6F6F6)

        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        mainView.backgroundColor = .white
        mainView.addSubviews(titleLabel, titleLine, sessionNoInfoImage, noInfoMessageLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        titleLabel.text = "상세정보"
        titleLabel.textColor = .gray800
        titleLabel.font = .title20
        
        titleLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        titleLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        
        sessionNoInfoImage.snp.makeConstraints { make in
            make.top.equalTo(titleLine.snp.bottom).offset(46)
            make.centerX.equalToSuperview()
            make.width.equalTo(82)
            make.height.equalTo(80)
        }
        sessionNoInfoImage.image = UIImage(named: "mainSessionNoInfoImage")
        
        noInfoMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(sessionNoInfoImage.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
        }
        noInfoMessageLabel.text = "상세정보가 업데이트 될 예정이에요"
        noInfoMessageLabel.textColor = .gray600
        noInfoMessageLabel.font = .body16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
