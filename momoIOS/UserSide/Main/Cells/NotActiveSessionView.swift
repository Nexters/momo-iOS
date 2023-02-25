//
//  NotActiveSessionCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//
import UIKit
import SnapKit

// MARK: - 활동 공백기 때의 cell
 class NotActiveSessionView: UIView {
     let img = UIImageView()
     let title = UILabel()
     let subtitle = UILabel()
     let askBtn = UIButton()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         self.initViews()
         self.setConstraints()
     }

     private func initViews() {
         self.addSubviews(img, title, subtitle, askBtn)
         
         img.image = UIImage(named: "notActiveSessionImg")
         
         title.text = "활동기간이 아닙니다"
         title.font = .title20
         title.textColor = .gray700
 
         subtitle.text = "궁금한 점이 있으면 운영진에게 문의해주세요"
         subtitle.font = .body16
         subtitle.textColor = .gray600

         askBtn.setTitle("문의하기", font: .body18, color: .white)
         askBtn.configurate(bgColor: .main, strokeColor: nil, strokeWidth: 0, cornerRadius: 8, padding: 10)
     }
     
     private func setConstraints() {
         img.snp.makeConstraints { make in
             make.width.equalTo(258)
             make.height.equalTo(256)
             make.centerX.equalToSuperview()
             make.top.equalToSuperview().offset(80)
         }
         
         title.snp.makeConstraints { make in
             make.top.equalTo(img.snp.bottom).offset(40)
             make.centerX.equalToSuperview()
         }
         
         subtitle.snp.makeConstraints { make in
             make.top.equalTo(title.snp.bottom).offset(8)
             make.centerX.equalToSuperview()
         }
         
         askBtn.snp.makeConstraints { make in
             make.centerX.equalToSuperview()
             make.leading.trailing.equalToSuperview().inset(24)
             make.bottom.equalToSuperview().inset(40)
             make.height.equalTo(60)
         }
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
