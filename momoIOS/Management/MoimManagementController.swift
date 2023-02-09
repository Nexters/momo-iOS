//
//  MoimManagementController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/09.
//

import UIKit
import SnapKit

class MoimManagementcontrolelr: UIViewController {
    
    // MARK: - Properties
    
    private let profileView = ProfileView()
    private let moimSettingTableView = UITableView()
    
    private lazy var toEndThisMoimLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 기수를 종료할까요?"
        label.font = .systemFont(ofSize: 21, weight: .regular)
        label.textColor = .rgba(37, 41, 48, 1)
        return label
    }()
    
    private lazy var toEndThisMoimButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료하기", size: 16, weight: .semibold, color: .rgba(37, 41, 45, 1))
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 7
        button.layer.borderColor = UIColor.rgba(201, 201, 201, 1).cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .rgba(245, 245, 245, 1)
        setupCustomNav()
        self.setupLayout()
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() { // TODO: 나중에 루트뷰 설정하고 삭제해야하는 코드
        // custom nav
        let navBar = self.navigationController?.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .rgba(24, 24, 24, 0.16)
        appearance.backgroundColor = .rgba(245, 245, 245, 1)
        navBar?.scrollEdgeAppearance = appearance
        
        // back button (left)
        let title = UILabel()
        title.text = "넥스터즈"
        title.textColor = .rgba(56, 56, 56, 1)
        title.font = .systemFont(ofSize: 21, weight: .bold)
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
    }
    
    private func setupSettingTableView() {
        self.moimSettingTableView.delegate = self
        self.moimSettingTableView.dataSource = self
        self.moimSettingTableView.register(MoimSettingCell.self, forCellReuseIdentifier: MoimSettingCell.id)
        view.addSubview(moimSettingTableView)
        moimSettingTableView.showsVerticalScrollIndicator = false
        moimSettingTableView.isScrollEnabled = false
        moimSettingTableView.layer.cornerRadius = 10
        moimSettingTableView.layer.borderColor = UIColor.clear.cgColor
        moimSettingTableView.layer.borderWidth = 1
        moimSettingTableView.layer.masksToBounds = true
    }
    
    private func setupViews() {
        view.addSubviews(profileView, toEndThisMoimLabel, toEndThisMoimButton)
        setupSettingTableView()
    }
    
    private func setupLayout() {
        setupViews()
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        
        moimSettingTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(profileView.snp.bottom).offset(40)
            make.height.equalTo(100)
        }
        
        toEndThisMoimLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(120)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        toEndThisMoimButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(53)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}

extension MoimManagementcontrolelr: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoimSettingCell.id) as! MoimSettingCell
        cell.settingTitle.text = indexPath.row == 0 ? "로그아웃" : "가입보안코드 확인"
        return cell
    }
}
