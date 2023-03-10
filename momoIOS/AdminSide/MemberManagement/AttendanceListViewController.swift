//
//  AttendanceListViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/25.
//

import UIKit

final class AttendanceListViewController: UIViewController {
    private let sortLabel: UILabel = UILabel()
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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.tableView.register(AttendanceListCell.self, forCellReuseIdentifier: AttendanceListCell.identifier)
    }
    
    private func setupLayout() {
        self.view.addSubviews(self.sortLabel, self.tableView)
        
        self.sortLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.sortLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension AttendanceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceListCell.identifier) as? AttendanceListCell else { return UITableViewCell() }
        
        return cell
    }
}

extension AttendanceListViewController: UITableViewDelegate {
    
}
