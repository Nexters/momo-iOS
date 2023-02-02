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
    
    private let username = "김넥터"
    private let userJob = "designer"
    private let userYear = 22
    private let email = "nexters@naver.com"
    
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
    
    private let historyTableView = UITableView()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupCustomNav()
        setupLayout()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        // back button (left)
        let navBar = navigationController?.navigationBar
        navBar?.topItem?.title = ""
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        
        // title (center)
        let title = UILabel()
        title.text = "나의 정보"
        title.textColor = .black
        navigationItem.titleView = title
        
        // logout (right)
        let logout = UILabel()
        logout.text = "로그아웃"
        logout.textColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logout)
    }

    private func setupUserProfileImage() {
        view.addSubviews(profileImageView, userActiveStatus)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(36)
            make.centerX.equalToSuperview()
        }
        userActiveStatus.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY).offset(10)
            make.left.equalTo(profileImageView.snp.centerX).offset(10)
        }
    }
    
    private func setupUserProfileInformation() {
        view.addSubviews(userBasicInfomationView, userAdditionalInformationView)
        userBasicInfomationView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        userAdditionalInformationView.snp.makeConstraints { make in
            make.top.equalTo(userBasicInfomationView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTableHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 38))
        header.backgroundColor = UIColor.rgba(250, 250, 250, 1)
        
        let label = UILabel(frame: header.frame)
        label.text = "출석 히스토리"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
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
        registerCells()
        view.addSubview(historyTableView)
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.allowsSelection = false
        
        let header = setupTableHeader()
        historyTableView.tableHeaderView = header
        
        historyTableView.separatorStyle = .none
        historyTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.height.equalTo(320)
            make.bottom.equalToSuperview()
        }
    }
    
    private func registerCells() {
        historyTableView.register(AttendanceHistoryCell.self, forCellReuseIdentifier: AttendanceHistoryCell.id)
    }
    
    private func setupLayout() {
        setupUserProfileImage()
        setupUserProfileInformation()
        setupHistoryTableView()
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
