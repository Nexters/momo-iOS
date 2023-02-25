//
//  AttendanceResultCell.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/03.
//

import UIKit
import SnapKit

class AttendanceResultCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let id: String = "AttendanceResultCell"
    
    var cellTitle: UILabel = {
        let title = UILabel()
        title.font = .body14
        title.textColor = .gray600
        return title
    }()
    
    var attendanceResult: UILabel = {
        let result = UILabel()
        result.font = .pretendard(size: 39, weight: .w400)
        result.textColor = .gray800
        return result
    }()
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.backgroundColor = .white
        setupCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setupCell()
    }
    
    // MARK: - Helpers
    private func setupCell() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: 0xEBEBEB).cgColor
        layer.cornerRadius = 8
        contentView.addSubviews(cellTitle, attendanceResult)
        
        cellTitle.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(16)
        }
        
        attendanceResult.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(cellTitle.snp.bottom).offset(10)
        }
    }
}
