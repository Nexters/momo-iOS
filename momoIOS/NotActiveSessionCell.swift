//
//  NotActiveSessionCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//

import Foundation
import UIKit
import SnapKit

// MARK: - 활동 공백기 때의 cell
 class NotActiveSessionCell: UITableViewCell {
     let title = UILabel()
     let subtitle = UILabel()
     let askBtn = UIButton()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: "NotActiveSessionCell")
         self.initViews()
     }

     private func initViews() {
         self.contentView.snp.makeConstraints() { make in
             make.leading.trailing.equalToSuperview()
             make.height.equalTo(200)
         }
         self.contentView.addSubviews(title, subtitle, askBtn)
         
         title.snp.makeConstraints() { make in
             make.top.equalToSuperview().offset(10)
             make.centerX.equalToSuperview()
         }
         title.text = "활동 기간이 아닙니다"
         title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
         
         subtitle.snp.makeConstraints() { make in
             make.top.equalTo(title.snp.bottom).offset(8)
             make.centerX.equalToSuperview()
         }
         subtitle.text = "다음 기수 활동을 기대해주세요!"
         subtitle.font = UIFont.systemFont(ofSize: 17, weight: .bold)
         subtitle.textColor = .lightGray
         
         askBtn.snp.makeConstraints() { make in
             make.top.equalTo(subtitle.snp.bottom).offset(49)
             make.centerX.equalToSuperview()
             make.width.equalTo(228)
             make.height.equalTo(52)
         }
         askBtn.backgroundColor = .black
         askBtn.layer.cornerRadius = 7
         askBtn.setTitle("문의하기", size: 16, weight: .bold, color: .white)
         
         
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
