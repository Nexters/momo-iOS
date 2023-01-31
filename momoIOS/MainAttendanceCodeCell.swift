//
//  MainAttendanceCodeCell.swift
//  momoIOS
//
//  Created by 임수현 on 2023/01/31.
//

import UIKit
import SnapKit

class MainAttendanceCodeCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let codeStackView: UIStackView = UIStackView()
    private let descriptionLabel: UILabel = UILabel()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MainAttendanceCodeCell")
        
        self.setupViews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupViews() {
        // TODO: ViewModel 바라보도록 수정 필요
        self.contentView.backgroundColor = .darkGray
        self.contentView.layer.cornerRadius = 12
        
        self.titleLabel.text = "출석체크 코드 입력"
        self.titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        self.titleLabel.textColor = .white
        self.contentView.addSubview(self.titleLabel)
        
        self.codeStackView.axis = .horizontal
        self.codeStackView.alignment = .center
        self.codeStackView.spacing = 14
        for _ in 0..<4 {
            let lineView = UIView()
            lineView.backgroundColor = .white
            self.codeStackView.addArrangedSubview(lineView)
        }
        self.contentView.addSubview(self.codeStackView)
        
        self.descriptionLabel.text = "운영진이 공지해준 출석체크 코드를 입력해주세요!"
        self.descriptionLabel.font = .systemFont(ofSize: 14)
        self.descriptionLabel.textColor = .lightGray
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.centerX.equalToSuperview()
        }
        
        self.codeStackView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(103)
            make.centerX.equalToSuperview()
        }
        
        self.codeStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.width.equalTo(44)
            }
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.codeStackView.snp.bottom).offset(26)
            make.bottom.equalToSuperview().inset(35)
            make.centerX.equalToSuperview()
        }
    }
}
