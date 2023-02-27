//
//  MoimManagementController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/09.
//

import UIKit
import SnapKit

class MoimManagementController: UIViewController {
    
    // MARK: - Properties
    
    var securityCode: String = "12345"
    
    private lazy var gradientBaseLayer: UIImageView = {
        let baseLayer = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 197))
        baseLayer.image = UIImage(named: "profileBackgroundImage")
        baseLayer.contentMode = .scaleAspectFill
        return baseLayer
    }()
    
    private let profileView = ProfileView()
    private let moimSettingTableView = UITableView()
    
    private lazy var toEndThisMoimLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 기수를 종료할까요?"
        label.font = .title20
        label.textColor = .gray800
        return label
    }()
    
    private lazy var toEndThisMoimButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료하기", size: 16, weight: .w500, color: .white)
        button.configurate(bgColor: .gray500, strokeColor: .none, strokeWidth: 0, cornerRadius: 8, padding: 0)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let alert = CommonBottomAlert()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xF6F6F6)
        self.setupCustomNav()
        self.setupLayout()
    }
    
    // MARK: - Selectors
    
    @objc private func toEndThisMoim() {
        alert.show()
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
        imageView.image = UIImage(named: "nextersLogoWhite")?.withRenderingMode(.alwaysOriginal)
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

        alert.configure(
            title: "현재 기수를 종료할까요?", description: "종료한다면 모든 기록들이 사라집니다.", cancelTitle: "취소", confirmTitle: "종료하기", cancelCompletion: nil, confirmCompletion: nil
        )
        
        self.toEndThisMoimButton.addTarget(self, action: #selector(toEndThisMoim), for: .touchUpInside)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(93)
            make.leading.equalToSuperview().inset(24)
        }

        toEndThisMoimButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
    }
}

extension MoimManagementController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoimSettingCell.id) as! MoimSettingCell
        cell.settingTitle.text = indexPath.row == 0 ? "로그아웃" : "가입보안코드 확인"
        cell.settingSubtitle.text = indexPath.row == 0 ? "→" : securityCode
        return cell
    }
}
