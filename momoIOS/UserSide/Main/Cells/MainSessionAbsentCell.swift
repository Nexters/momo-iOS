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
    let topLine = UIView()
    let sessionAbsentBtn = UIButton()
    var seesionAbsentBtnAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainSessionAbsentCell")
        self.selectionStyle = .none
        
        self.initViews()
        self.setConstraints()
    }
    
    private func initViews() {
        self.contentView.addSubviews(topLine, sessionAbsentBtn)

        topLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        
        sessionAbsentBtn.setTitle("해당 세션 참여가 어려워요", font: .body16, color: .gray600)
        sessionAbsentBtn.setImage(UIImage(systemName: "chevron.right"), tintColor: .gray600, padding: 15, direction: .trailing)
        sessionAbsentBtn.addTarget(self, action: #selector(didTapSessionAbsentBtn), for: .touchUpInside)
    }
    
    private func setConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(72)
        }
        
        topLine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        sessionAbsentBtn.snp.makeConstraints { make in
            make.top.equalTo(topLine.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSessionAbsentBtn() {
        self.seesionAbsentBtnAction?()
    }
}
