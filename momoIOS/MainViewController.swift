//
//  MainViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/01/28.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let tableView: UITableView = UITableView(frame: .zero)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCells()
        self.view.addSubview(tableView)
    }
    
    private func registerCells() {
        self.tableView.register(MainAttendanceCodeCell.self, forCellReuseIdentifier: "MainAttendanceCodeCell")
        self.tableView.register(MainAttendanceDoneCell.self, forCellReuseIdentifier: "MainAttendanceDoneCell")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action
    private func goToAttendanceVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func goToHistoryVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "MainAttendanceCodeCell") ?? UITableViewCell()
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainAttendanceDoneCell") as? MainAttendanceDoneCell else {
                return UITableViewCell()
            }
            cell.historyButtonAction = { [weak self] in
                self?.goToHistoryVC()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: // (MainAttendanceCodeCell) 출석 코드 입력 셀
            self.goToAttendanceVC()
        default:
            break
        }
    }
}
