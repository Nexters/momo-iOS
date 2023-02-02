//
//  AttendanceHistoryCell.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/02.
//

import UIKit

class AttendanceHistoryCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let id = "AttendanceHistoryCell"
    
    private lazy var historyDateContainerView = setupHistoryIndexView()
    private let attendanceStatusContainerView = UIView()
    
    private let weekLabel: UILabel = {
        let label = UILabel()
        label.text = "1주차"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "(1/7)"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let attendanceStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "정상 출석"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .rgba(84, 84, 84, 1)
        return label
    }()
    
    private let attendedDatetime: UILabel = {
        let label = UILabel()
        label.text = "2023.01.07 12:00"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .gray
        return label
    }()
    
    private let dailyAttendanceScore: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.rgba(84, 84, 84, 1)
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AttendanceHistoryCell.id)
        
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Helpers
    
    private func setupHistoryIndexView() -> UIView {
        let historyDateContainerView = UIView()
        historyDateContainerView.addSubviews(weekLabel, dateLabel)
        weekLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(historyDateContainerView)
            make.left.equalTo(historyDateContainerView)
        }
        dateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(historyDateContainerView)
            make.left.equalTo(weekLabel.snp.right).offset(5)
        }
        return historyDateContainerView
    }
    
    private func setupAttendanceStatusContainerView() {
        let statusIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let statusIcon = UIImage(systemName: "checkmark.circle.fill")
        // 결석시 x.circle.fill
        statusIconView.image = statusIcon
        statusIconView.tintColor = .rgba(29, 186, 83, 1)
        statusIconView.contentMode = .scaleAspectFit
        // 지각시 rgba(222, 185, 90, 1)
        // 결석시 rgba(232, 32, 68, 1)
        
        attendanceStatusContainerView.addSubviews(statusIconView, attendanceStatusLabel, attendedDatetime)
        statusIconView.snp.makeConstraints { make in
            make.top.equalTo(attendanceStatusContainerView.snp.top)
            make.left.equalTo(attendanceStatusContainerView.snp.left)
        }
        attendanceStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusIconView)
            make.left.equalTo(statusIconView.snp.right).offset(5)
        }
        attendedDatetime.snp.makeConstraints { make in
            make.top.equalTo(attendanceStatusLabel.snp.bottom).offset(5)
            make.left.equalTo(attendanceStatusLabel.snp.left)
        }
    }
    
    private func setupCell() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.height.greaterThanOrEqualTo(60)
        }
        let historyDateContainerView = setupHistoryIndexView()
        setupAttendanceStatusContainerView()
        
        contentView.addSubviews(historyDateContainerView, attendanceStatusContainerView, dailyAttendanceScore)
        historyDateContainerView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(15)
            make.width.equalTo(80)
        }
        
        attendanceStatusContainerView.snp.makeConstraints { make in
            make.top.equalTo(historyDateContainerView)
            make.left.equalTo(historyDateContainerView.snp.right).offset(20)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        
        dailyAttendanceScore.snp.makeConstraints { make in
            make.top.equalTo(historyDateContainerView)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.width.equalTo(30)
        }
    }
    
}
