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
    // indexPath.row: (title.text, result.text, score?.text)
    
    private lazy var baseLayer: UIView = {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 197))
        layer.backgroundColor = UIColor(hex: 0x222328)
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
        resultCollectionView.backgroundColor = .white
        resultCollectionView.register(AttendanceResultCell.self, forCellWithReuseIdentifier: AttendanceResultCell.id)
        
        resultCollectionContainerView.addSubview(resultCollectionView)
        resultCollectionView.layer.masksToBounds = false
        resultCollectionView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(resultCollectionContainerView)
            make.horizontalEdges.equalTo(resultCollectionContainerView)
        }
        
        view.addSubviews(resultCollectionContainerView)
    }
    
    private func setupHistoryTableView() {
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.register(AttendanceHistoryCell.self, forCellReuseIdentifier: AttendanceHistoryCell.id)
        view.addSubviews(tableViewHeader, borderView, historyTableView)
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.allowsSelection = false
        historyTableView.separatorStyle = .none
    }
    
    private func setupViews() {
        view.addSubviews(baseLayer, profileView)
        setupResultCollectionView()
        setupHistoryTableView()
    }
    
    private func setupLayout() {
        setupViews()
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        
        resultCollectionContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(profileView.snp.bottom).offset(26)
            make.height.equalTo(110)
        }
        
        tableViewHeader.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
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
        }
    }
}

extension PersonalInformationController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceHistoryCell.id) {
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .black
            return cell
        }
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
