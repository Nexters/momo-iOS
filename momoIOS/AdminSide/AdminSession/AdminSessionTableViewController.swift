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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AdminSessionCell.self, forCellReuseIdentifier: "AdminSessionCell")
    }
    
    private func setBaseView() {
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.tableView.separatorStyle = .none
    }
    
    private func setNavCustom() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        let title = UIBarButtonItem(title: "넥스터즈", style: .plain, target: nil, action: nil)
        let addSession = UIBarButtonItem(title: "세션 등록", style: .plain, target: self, action: #selector(didTapAddSessionButton))
        
        self.navigationItem.leftBarButtonItem = title
        self.navigationItem.rightBarButtonItem = addSession
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
            cell.sessionKeyworkLabel.text = ""
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
            cell.sessionDdayLabel.text = "today"
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
        return 160.0
    }
}
