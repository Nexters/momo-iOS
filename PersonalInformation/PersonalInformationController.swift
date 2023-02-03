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
    
    private let username = "김넥터"
    private let userJob = "designer"
    private let userYear = 22
    private let email = "nexters@naver.com"
    
    private let historyTableView = UITableView()
    private let resultCollectionContainerView = UIView()
    private let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private lazy var hintLatePenalty = setupHintPenalty("-5점")
    private lazy var hintAbsentPenalty = setupHintPenalty("통보 -10 / 무단 -15")
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 93, height: 93))
        imageView.image = UIImage(named: "\(userJob)")!
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 93 / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.rgba(208, 208, 208, 1).cgColor
        
        return imageView
    }()
    
    private lazy var userActiveStatus: UIView = {
        let statusView = UIView()
        
        let status = UILabel()
        status.text = "\(userYear)기 참여중"
        status.font = .systemFont(ofSize: 13, weight: .bold)
        status.textColor = .white
        
        statusView.addSubview(status)
        status.snp.makeConstraints { make in
            make.edges.equalTo(statusView).inset(9)
        }
        statusView.backgroundColor = UIColor.rgba(116, 207, 130, 1)
        statusView.layer.cornerRadius = 5
        return statusView
    }()
    
    private lazy var userBasicInfomationView: UIStackView = {
        let usernameLabel = UILabel()
        let jobLabel = UILabel()
        let jobLabelView = UIView()
        let view = UIStackView(arrangedSubviews: [usernameLabel, jobLabelView])
        view.axis = .horizontal
        view.spacing = 10
        
        usernameLabel.text = username
        usernameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        usernameLabel.textColor = .black
        
        jobLabel.text = userJob.uppercased()
        jobLabel.font = .systemFont(ofSize: 13)
        jobLabelView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(jobLabelView).inset(5)
            make.horizontalEdges.equalTo(jobLabelView).inset(10)
        }
        jobLabelView.backgroundColor = UIColor.rgba(243, 243, 243, 1)
        
        return view
    }()
    
    private lazy var userAdditionalInformationView: UILabel = {
        let label = UILabel()
        label.text = email
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.rgba(118, 118, 118, 1)
        return label
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

    private func setupUserProfileImage() {
        view.addSubviews(profileImageView, userActiveStatus, userBasicInfomationView, userAdditionalInformationView)
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
    
    private func setupTableHeader() -> UIView {
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
    }
    
    private func setupHistoryTableView() {
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.register(AttendanceHistoryCell.self, forCellReuseIdentifier: AttendanceHistoryCell.id)
        view.addSubview(historyTableView)
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.allowsSelection = false
        historyTableView.separatorStyle = .none
        
        let header = setupTableHeader()
        historyTableView.tableHeaderView = header
    }
    
    private func setupViews() {
        setupUserProfileImage()
        setupResultCollectionView()
        setupHistoryTableView()
    }
    
    private func setupLayout() {
        setupViews()
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(36)
            make.centerX.equalToSuperview()
        }
        userActiveStatus.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY).offset(10)
            make.left.equalTo(profileImageView.snp.centerX).offset(10)
        }
        
        userBasicInfomationView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        userAdditionalInformationView.snp.makeConstraints { make in
            make.top.equalTo(userBasicInfomationView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        resultCollectionContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(userAdditionalInformationView.snp.bottom).offset(27)
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
        
        historyTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(hintLatePenalty.snp.bottom).offset(26)
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
