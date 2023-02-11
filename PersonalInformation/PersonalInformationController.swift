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
    private let data = [0: ("출석", 3, nil),
                        1: ("지각", 0, nil),
                        2: ("결석", 0, -30)]
    // indexPath.row: (title.text, result.text, score?.text)
    
    private let profileView = ProfileView()
    private let historyTableView = UITableView()
    private let resultCollectionContainerView = UIView()
    private let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private lazy var hintLatePenalty = setupHintPenalty("-5점")
    private lazy var hintAbsentPenalty = setupHintPenalty("통보 -10 / 무단 -15")
    
    private lazy var tableViewHeader: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 38))
        header.backgroundColor = UIColor.rgba(250, 250, 250, 1)
        
        let label = UILabel(frame: header.frame)
        label.text = "출석 히스토리"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor.rgba(84, 84, 84, 1)
        label.textAlignment = .left
        
        header.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(header.snp.left).offset(20)
            make.centerY.equalTo(header.snp.centerY)
        }
        return header
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
        // custom nav
        let navBar = self.navigationController?.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .rgba(24, 24, 24, 0.16)
        appearance.backgroundColor = .white
        navBar?.scrollEdgeAppearance = appearance
        
        // back button (left)
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBackToMainVC))
        
        // title (center)
        let title = UILabel()
        title.text = "나의 정보"
        title.textColor = .black
        title.font = .systemFont(ofSize: 15)
        navigationItem.titleView = title
        
        // logout (right)
        let logout = UILabel()
        logout.text = "로그아웃"
        logout.textColor = .gray
        logout.font = .systemFont(ofSize: 15)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logout)
    }
    
    private func setupHintPenalty(_ hint: String) -> UILabel {
        let hintLabel = UILabel()
        hintLabel.text = hint
        hintLabel.font = .systemFont(ofSize: 13)
        hintLabel.textColor = .rgba(152, 152, 152, 1)
        return hintLabel
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
            make.verticalEdges.equalTo(resultCollectionContainerView).inset(20)
            make.horizontalEdges.equalTo(resultCollectionContainerView).inset(20)
        }
        
        view.addSubviews(resultCollectionContainerView, hintLatePenalty, hintAbsentPenalty)
    }
    
    private func setupHistoryTableView() {
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.register(AttendanceHistoryCell.self, forCellReuseIdentifier: AttendanceHistoryCell.id)
        view.addSubviews(tableViewHeader, historyTableView)
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.allowsSelection = false
        historyTableView.separatorStyle = .none
    }
    
    private func setupViews() {
        view.addSubview(profileView)
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
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.height.equalTo(135)
        }
        
        hintAbsentPenalty.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(25)
            make.top.equalTo(resultCollectionContainerView.snp.bottom)
        }
        hintLatePenalty.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultCollectionContainerView.snp.bottom)
        }
        
        tableViewHeader.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(hintLatePenalty.snp.bottom).offset(26)
            make.height.equalTo(38)
        }
        historyTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(tableViewHeader.snp.bottom)
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
        return CGSize(width: (view.frame.width - 60) / 3, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: AttendanceResultCell.id, for: indexPath) as! AttendanceResultCell
        let data = data[indexPath.row]!
        cell.cellTitle.text = data.0
        cell.attendanceResult.text = indexPath.row == 2 ? "\(String(describing: data.1))/2" : "\(String(describing: data.1))"
        if let score = data.2 {
            cell.resultScore.text = "\(score)"
        }
        return cell
    }
}
