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
    
    private lazy var gradientBaseLayer: UIView = {
        let baseLayer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 197))
        baseLayer.backgroundColor = UIColor.rgba(34, 35, 40, 1)
        return baseLayer
    }()
    
    private let profileView = ProfileView()
    private let moimSettingTableView = UITableView()
    
    private lazy var toEndThisMoimLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 기수를 종료할까요?"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .gray800
        return label
    }()
    
    private lazy var toEndThisMoimButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료하기", size: 16, weight: .medium, color: .white)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .gray500
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
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
    
    private func setupCustomNav() {
        // custom nav
        let navBar = self.navigationController?.navigationBar
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        // logo item (left)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NextersLogoWhite")?.withRenderingMode(.alwaysOriginal)
        let logoItem = UIBarButtonItem(customView: imageView)
        logoItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        logoItem.customView?.heightAnchor.constraint(equalToConstant: 16).isActive = true
        logoItem.customView?.widthAnchor.constraint(equalToConstant: 126).isActive = true
        navigationItem.leftBarButtonItem = logoItem
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
        // background
        view.addSubviews(gradientBaseLayer)
        
        view.addSubviews(profileView, toEndThisMoimLabel, toEndThisMoimButton)
        setupSettingTableView()
    }
    
    private func setupLayout() {
        setupViews()
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }

        moimSettingTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(profileView.snp.bottom).offset(40)
            make.height.equalTo(100)
        }

        toEndThisMoimLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(93)
            make.horizontalEdges.equalToSuperview().inset(24)
        }

        toEndThisMoimButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(60)
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
