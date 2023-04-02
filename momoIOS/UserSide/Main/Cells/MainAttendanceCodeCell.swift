//
//  MainAttendanceCodeCell.swift
//  momoIOS
//
//  Created by 임수현 on 2023/01/31.
//

import UIKit
import SnapKit

class MainAttendanceCodeCell: UITableViewCell {
    private let lockImageView: UIImageView = UIImageView(image: UIImage(named: "lock"))
    private let titleLabel: UILabel = UILabel()
    private let codeStackView: UIStackView = UIStackView()
    private let descriptionLabel: UILabel = UILabel()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainAttendanceCodeCell")
        
        self.selectionStyle = .none
        self.setupViews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupViews() {
        // TODO: ViewModel 바라보도록 수정 필요
        self.backgroundColor = .clear
        self.lockImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.lockImageView)
        
        self.titleLabel.text = "출석체크 코드 입력"
        self.titleLabel.font = .pretendard(size: 24, weight: .w600)
        self.titleLabel.textColor = .white
        self.contentView.addSubview(self.titleLabel)
        
        self.descriptionLabel.text = "운영진이 공지해준 출석체크 코드를 입력해주세요!"
        self.descriptionLabel.font = .body16
        self.descriptionLabel.textColor = .init(white: 1, alpha: 0.8)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.codeStackView.axis = .horizontal
        self.codeStackView.alignment = .center
        self.codeStackView.spacing = 14
        for _ in 0..<4 {
            self.codeStackView.addArrangedSubview(self.makeEmptyRoundBox())
        }
        self.contentView.addSubview(self.codeStackView)
    }
    
    private func makeEmptyRoundBox() -> UIView {
        let view = UILabel()
        view.layer.backgroundColor = UIColor.init(white: 1, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
        return view
    }
    
    // MARK: - Layout
    private func setupLayout() {
        let screenWidth = UIScreen.main.bounds.width
        self.lockImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.equalToSuperview().inset(143/375 * screenWidth)
            make.trailing.equalToSuperview().inset(83/375 * screenWidth)
            make.width.equalTo(148/375 * screenWidth)
            make.height.equalTo(107/375 * screenWidth)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lockImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.codeStackView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(28)
            make.bottom.equalToSuperview().inset(51)
            make.centerX.equalToSuperview()
        }
        
        self.codeStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(56)
                make.height.equalTo(68)
            }
        }
    }
}
