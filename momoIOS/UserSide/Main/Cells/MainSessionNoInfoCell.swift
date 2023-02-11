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
    let sessionInfoLayout = UIView()
    let noInfoMessageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionNoInfoCell")
        self.contentView.addSubviews(sessionInfoLayout, noInfoMessageLabel)
        self.initViews()
    }
    
    private func initViews() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(260)
        }

        sessionInfoLayout.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(236)
        }
        sessionInfoLayout.layer.borderColor = UIColor.systemGray5.cgColor
        sessionInfoLayout.layer.borderWidth = 1
        sessionInfoLayout.layer.cornerRadius = 12
        
        sessionInfoLayout.addSubview(noInfoMessageLabel)
        noInfoMessageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        noInfoMessageLabel.text = "상세정보가 업데이트 될 예정입니다"
        noInfoMessageLabel.textColor = UIColor(hex: 0x737373)
        noInfoMessageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
