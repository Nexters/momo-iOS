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
    let tableView: UITableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setTableView()
        setBaseView()
    }
    
    private func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AdminSessionCell.self, forCellReuseIdentifier: "AdminSessionCell")
//        self.tableView.estimatedRowHeight = 153
//        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setBaseView() {
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.tableView.separatorStyle = .none
    }
}

extension AdminSessionTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdminSessionCell") as? AdminSessionCell else {return UITableViewCell()}
        // MARK: todo: cell logic
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 153
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
        //return UITableView.automaticDimension
    }
}

