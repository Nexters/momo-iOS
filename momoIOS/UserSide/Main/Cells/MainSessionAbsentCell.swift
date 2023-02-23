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

        sessionAbsentBtn.setTitle("해당 세션 참여가 어려워요", for: .normal)
        sessionAbsentBtn.setTitleColor(UIColor(hex: 0x727484), for: .normal)
        sessionAbsentBtn.semanticContentAttribute = .forceRightToLeft
        sessionAbsentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        sessionAbsentBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        sessionAbsentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
        sessionAbsentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        sessionAbsentBtn.tintColor = UIColor(hex: 0x727484)
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
        topLine.backgroundColor = UIColor(hex: 0xEEEEEE)
        
        sessionAbsentBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSessionAbsentBtn() {
        self.seesionAbsentBtnAction?()
    }
}

