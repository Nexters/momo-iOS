//
//  AdminSessionTableViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/09.
//

import UIKit
import SnapKit

// MARK: - 어드민 세션 목록 테이블 뷰
class AdminSessionTableViewController: UIViewController {
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBaseView()
        setTableView()
        setNavCustom()
    }
    
    private func setTableView() {
        self.tableView.backgroundColor = UIColor(hex: 0xF6F6F6)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AdminSessionCell.self, forCellReuseIdentifier: "AdminSessionCell")
    }
    
    private func setBaseView() {
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNavCustom() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 20
        let logo = UIButton()
        logo.setImage(UIImage(named: "NextersLogo"), for: .normal)
        logo.adjustsImageWhenHighlighted = false
        let title = UIBarButtonItem(customView: logo)
        
        // MARK: - UIButton extension에 넣어두기
        let addCustomView = UIButton()
        addCustomView.setTitle("세션 등록", for: .normal)
        addCustomView.setTitleColor(UIColor.gray800, for: .normal)
        addCustomView.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        addCustomView.setImage(UIImage(named: "addSessionButton"), for: .normal)
        addCustomView.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        addCustomView.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        addCustomView.addTarget(self, action: #selector(didTapAddSessionButton), for: .touchUpInside)
        addCustomView.sizeToFit()
    
        let addsessions = UIBarButtonItem(customView: addCustomView)
        addsessions.target = self
        addsessions.action = #selector(didTapAddSessionButton)
        
        self.navigationItem.leftBarButtonItems = [spacer, title]
        self.navigationItem.rightBarButtonItem = addsessions
    }
    
    @objc func didTapAddSessionButton(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(AddSessionViewController(), animated: true)
    }
}

extension AdminSessionTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdminSessionCell") as? AdminSessionCell else {return UITableViewCell()}
            cell.sessionKeyworkLabel.isHidden = true
            cell.sessionWeekLabel.text = "1주차"
            cell.sessionDetailLabel.text = ""
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdminSessionCell") as? AdminSessionCell else {return UITableViewCell()}
            cell.sessionWeekLabel.text = "2주차"
            cell.sessionDetailLabel.text = ""
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdminSessionCell") as? AdminSessionCell else {return UITableViewCell()}
            cell.sessionWeekLabel.text = "3주차"
            cell.sessionDetailLabel.text = "test\ntest\ntest\ntest\ntest\ntest\ntest\ntest\ntest\n"
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdminSessionCell") as? AdminSessionCell else {return UITableViewCell()}
            cell.sessionDdayLabel.text = "D-2"
            cell.sessionWeekLabel.text = "4주차"
            cell.setCheckCodeView()
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "AdminSessionCell") ?? UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}
