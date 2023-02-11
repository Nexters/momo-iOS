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
        title.font = .systemFont(ofSize: 15, weight: .medium)
        title.textColor = .rgba(138, 138, 138, 1)
        return title
    }()
    
    var attendanceResult: UILabel = {
        let result = UILabel()
        result.font = .systemFont(ofSize: 40, weight: .regular)
        result.textColor = .rgba(53, 53, 53, 1)
        return result
    }()
    
    var resultScore: UILabel = {
        let score = UILabel()
        score.font = .systemFont(ofSize: 13, weight: .medium)
        score.textColor = .rgba(217, 91, 91, 1)
        return score
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
        layer.shadowColor = UIColor.rgba(191, 191, 191, 1).cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        contentView.addSubviews(cellTitle, attendanceResult, resultScore)
        
        cellTitle.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(10)
        }
        
        attendanceResult.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(cellTitle.snp.bottom).offset(9)
        }
        
        resultScore.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(attendanceResult.snp.bottom)
        }
    }
}
