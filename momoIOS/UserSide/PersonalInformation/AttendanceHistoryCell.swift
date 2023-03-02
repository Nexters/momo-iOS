//
//  AttendanceHistoryCell.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/02.
//

import UIKit
import SnapKit

class AttendanceHistoryCell: UITableViewCell {

    // MARK: - Properties
    
    static let id = "AttendanceHistoryCell"

    private let attendanceStatusContainerView = UIView()
    
    var weekLabel: UILabel = {
        let label = UILabel()
        label.text = "1주차 (1/7)"
        label.font = .body14
        label.textColor = .gray600
        return label
    }()
    
    var statusIcon: UILabel = {
        let icon = UILabel()
        icon.text = "🔵"
        icon.font = .pretendard(size: 14, weight: .w500)
        return icon
    }()
    
    var attendanceStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "정상 출석"
        label.font = .pretendard(size: 16, weight: .w600)
        label.textColor = .gray700
        return label
    }()
    
    var attendedDatetime: UILabel = {
        let label = UILabel()
        label.text = "2023.01.07 12:00"
        label.font = .body14
        label.textColor = .gray600
        return label
    }()
    
    var dailyAttendanceScore = PaddingLabel(radius: 5, color: UIColor(hex: 0x7FCBE5, alpha: 0.2))
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AttendanceHistoryCell.id)
        
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.accessoryType = .none
    }
    
    // MARK: - Helpers
    
    private func setupHistoryIndexView() -> UIView {
        let historyDateContainerView = UIView()
        historyDateContainerView.addSubviews(weekLabel)
        weekLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(historyDateContainerView)
            make.left.equalTo(historyDateContainerView)
        }
        return historyDateContainerView
    }
    
    private func setupAttendanceStatusContainerView() {
        attendanceStatusContainerView.addSubviews(statusIcon, attendanceStatusLabel, attendedDatetime)
        statusIcon.snp.makeConstraints { make in
            make.top.equalTo(attendanceStatusContainerView.snp.top)
            make.leading.equalTo(attendanceStatusContainerView.snp.leading)
        }
        attendanceStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(attendanceStatusContainerView.snp.top)
            make.leading.equalTo(statusIcon.snp.trailing).offset(6)
        }
        attendedDatetime.snp.makeConstraints { make in
            make.top.equalTo(attendanceStatusLabel.snp.bottom).offset(5)
            make.left.equalTo(attendanceStatusLabel.snp.left)
        }
    }
    
    private func setupCell() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.greaterThanOrEqualTo(84)
        }
        
        let historyDateContainerView = setupHistoryIndexView()
        setupAttendanceStatusContainerView()
        
        contentView.addSubviews(historyDateContainerView, attendanceStatusContainerView, dailyAttendanceScore)
        historyDateContainerView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.width.equalTo(74)
        }
        
        attendanceStatusContainerView.snp.makeConstraints { make in
            make.top.equalTo(historyDateContainerView)
            make.leading.equalTo(historyDateContainerView.snp.trailing).offset(16)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        
        dailyAttendanceScore.snp.makeConstraints { make in
            make.top.equalTo(historyDateContainerView)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
    
}
