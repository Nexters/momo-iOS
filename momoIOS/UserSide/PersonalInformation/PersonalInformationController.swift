//
//  PersonalInformationController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/02.
//

import UIKit
import SnapKit

class PersonalInformationController: UIViewController {
    
    // MARK: - Properties
    
    // 임시 데이터
    private let data = [0: ("출석", 3),
                        1: ("지각", 0),
                        2: ("결석", 0)]
    // indexPath.row: (title.text, result.text)
    
    private let attendanceType: [AttendanceType: Attendance]
    = [AttendanceType.present: Attendance(icon: "🔵", toString: "정상출석", textColor: UIColor.attendanceCheck, backgroundColor: UIColor(hex: 0x7FCBE5, alpha: 0.2), score: 0),
       AttendanceType.late: Attendance(icon: "🟡", toString: "지각", textColor: UIColor(hex: 0xFF8E26), backgroundColor: UIColor(hex: 0xFFF8E4), score: -5),
       AttendanceType.AWOL: Attendance(icon: "🔴", toString: "결석 (무단)", textColor: UIColor(hex: 0xFE505B), backgroundColor: UIColor(hex: 0xFFEFEF), score: -15),
       AttendanceType.AWL: Attendance(icon: "🔴", toString: "결석 (통보)", textColor: UIColor(hex: 0xFE505B), backgroundColor: UIColor(hex: 0xFFEFEF), score: -10)]
    
    private var numberOfHistory = 8
    private let heightOfHistoryCell = 84
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var baseLayer: UIImageView = {
        let layer = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 197))
        layer.image = UIImage(named: "profileBackgroundImage")
        layer.contentMode = .scaleAspectFill
        return layer
    }()
    
    private let profileView = ProfileView()
    private let historyTableView = UITableView()
    private let resultCollectionContainerView = UIView()
    private let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private lazy var tableViewHeader: UILabel = {
        let header = UILabel()
        header.text = "출석 히스토리"
        header.font = .pretendard(size: 16, weight: .w600)
        header.textColor = UIColor.gray700
        return header
    }()
    
    private let borderView: UIView = {
        let border = UIView()
        border.backgroundColor = UIColor(hex: 0xF1F1F1)
        border.snp.makeConstraints { make in
            make.height.equalTo(0.75)
        }
        return border
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.scrollView.backgroundColor = .clear
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.scrollView.showsVerticalScrollIndicator = false
        self.contentView.backgroundColor = .clear
        self.setupCustomNav()
        self.setupLayout()
    }
    
    // MARK: - Selectors
    
    @objc private func goBackToMainVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        // back button (left)
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBackToMainVC))
        navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        // title (center)
        let title = UILabel()
        title.text = "나의 정보"
        title.textColor = .textbox2
        title.font = .body16
        navigationItem.titleView = title
        
        // logout (right)
        let logout = UILabel()
        logout.text = "로그아웃"
        logout.textColor = .textbox2
        logout.font = .body14
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logout)
    }
    
    private func setupResultCollectionView() {
        self.resultCollectionView.delegate = self
        self.resultCollectionView.dataSource = self
        resultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        resultCollectionView.backgroundColor = .clear
        resultCollectionView.register(AttendanceResultCell.self, forCellWithReuseIdentifier: AttendanceResultCell.id)
        resultCollectionContainerView.addSubview(resultCollectionView)
        resultCollectionView.layer.masksToBounds = false
        resultCollectionView.isScrollEnabled = false
        
        resultCollectionView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(resultCollectionContainerView)
            make.horizontalEdges.equalTo(resultCollectionContainerView)
        }
    }
    
    private func setupHistoryTableView() {
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.register(AttendanceHistoryCell.self, forCellReuseIdentifier: AttendanceHistoryCell.id)
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.allowsSelection = false
        historyTableView.separatorStyle = .none
        historyTableView.isScrollEnabled = false
    }
    
    private func setupViews() {
        view.addSubviews(scrollView, baseLayer)
        scrollView.addSubview(contentView)
        contentView.addSubviews(profileView, resultCollectionContainerView, tableViewHeader, borderView, historyTableView)
        view.sendSubviewToBack(baseLayer)
        
        setupResultCollectionView()
        setupHistoryTableView()
    }
    
    private func setupLayout() {
        setupViews()
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(2000)
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(scrollView.contentLayoutGuide)
            make.verticalEdges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        resultCollectionContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(24)
            make.top.equalTo(profileView.snp.bottom).offset(26)
            make.height.equalTo(110)
        }
        
        tableViewHeader.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(24)
            make.top.equalTo(resultCollectionView.snp.bottom).offset(35)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(tableViewHeader.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        historyTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(borderView.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalTo(heightOfHistoryCell * numberOfHistory)
        }
    }
}

extension PersonalInformationController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceHistoryCell.id, for: indexPath) as! AttendanceHistoryCell
        let data = attendanceType.randomElement()!.value
        cell.weekLabel.text = "\(8-indexPath.row)주차 (1/7)"
        cell.statusIcon.text = "\(data.icon)"
        cell.attendanceStatusLabel.text = data.toString
        cell.dailyAttendanceScore.text = "\(data.score)"
        cell.dailyAttendanceScore.verticalInset = 4
        cell.dailyAttendanceScore.horizontalInset = 10
        cell.dailyAttendanceScore.backgroundColor = data.backgroundColor
        cell.dailyAttendanceScore.textColor = data.textColor
        return cell
    }
}

extension PersonalInformationController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 72) / 3, height: 108)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: AttendanceResultCell.id, for: indexPath) as! AttendanceResultCell
        let data = data[indexPath.row]!
        cell.cellTitle.text = data.0
        cell.attendanceResult.text = indexPath.row == 2 ? "\(String(describing: data.1))/2" : "\(String(describing: data.1))"
        return cell
    }
}
