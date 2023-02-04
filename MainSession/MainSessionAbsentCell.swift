//
//  MainSessionAbsentCell.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/01.
//
import SnapKit
import UIKit

// MARK: - 메인 세션 불참 버튼 cell
class MainSessionAbsentCell: UITableViewCell {
    let sessionAbsentBtn = UIButton()
    let sessionabsentDescription = UILabel()
    
    var seesionAbsentBtnAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionTimeCell")
        self.initViews()
        self.setConstraints()
    }
    
    private func initViews() {
        self.contentView.addSubviews(sessionAbsentBtn, sessionabsentDescription)

        sessionAbsentBtn.setTitle("해당 세션 참여가 어려워요", for: .normal)
        sessionAbsentBtn.setTitleColor(.black, for: .normal)
        sessionAbsentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        sessionAbsentBtn.layer.borderWidth = 1
        sessionAbsentBtn.layer.borderColor = UIColor(hex: 0xB9B9B9).cgColor
        sessionAbsentBtn.layer.cornerRadius = 10
        sessionAbsentBtn.addTarget(self, action: #selector(didTapSessionAbsentBtn), for: .touchUpInside)
        
        sessionabsentDescription.text = "통보 결석은 세션 시작 하루전까지 유효합니다."
        sessionabsentDescription.sizeToFit()
        sessionabsentDescription.textColor = UIColor(hex: 0x8E8E8E)
        sessionabsentDescription.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    private func setConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        sessionAbsentBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(51)
        }
        
        sessionabsentDescription.snp.makeConstraints { make in
            make.top.equalTo(sessionAbsentBtn.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSessionAbsentBtn() {
        self.seesionAbsentBtnAction?()
    }
}
