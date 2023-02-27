//
//  MemberListViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/25.
//

import UIKit
import SnapKit

final class MemberListViewController: UIViewController {
    private let sortLabel: UILabel = UILabel()
    private let addMemberButton: UIButton = UIButton()
    private let resetAllButton: UIButton = UIButton()
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        self.sortLabel.text = "이름순"
        self.sortLabel.font = .body16
        self.sortLabel.textColor = .gray800
        
        self.addMemberButton.setTitle("회원등록", font: .body16, color: .gray500)
        self.addMemberButton.configurate(padding: 0)
        self.addMemberButton.addTarget(self, action: #selector(goToAddIndividualMemberViewController), for: .touchUpInside)
        self.resetAllButton.setTitle("전체 초기화", font: .body16, color: .gray500)
        self.resetAllButton.configurate(padding: 0)
        self.resetAllButton.addTarget(self, action: #selector(showResetAllAlert), for: .touchUpInside)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.tableView.register(MemberListCell.self, forCellReuseIdentifier: MemberListCell.identifier)
    }
    
    private func setupLayout() {
        self.view.addSubviews(self.sortLabel, self.addMemberButton, self.resetAllButton, self.tableView)
        
        self.sortLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
        }
        
        self.resetAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.sortLabel)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.addMemberButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.sortLabel)
            make.trailing.equalTo(self.resetAllButton.snp.leading).offset(-13)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.sortLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action
    @objc private func goToAddIndividualMemberViewController() {
        let viewController = AddIndividualMemberViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showResetAllAlert() {
        let alert = CommonBottomAlert()
        alert.configure(title: "회원정보를 초기화 할까요?", description: "한번 초기화된 회원정보는 되돌릴 수 없습니다.\n되돌리고 싶다면 다시 엑셀을 업로드해야 합니다.", cancelTitle: "취소", confirmTitle: "초기화", cancelCompletion: nil) {
            // TODO: 초기화 로직 추가
        }
        alert.show()
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberListCell.identifier) as? MemberListCell else { return UITableViewCell() }
        
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    
}
