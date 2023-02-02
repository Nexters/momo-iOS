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
    private let historyTableView = UITableView(frame: .zero)
    
    // MARK: - Lifecycles
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureHistoryTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        registerCells()
        view.addSubview(historyTableView)
    }
    private func registerCells() {
        self.historyTableView.register(AttendanceHistoryCell.self, forCellReuseIdentifier: "AttendanceHistoryCell")
    }
}

extension PersonalInformationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "AttendanceHistoryCell", for: indexPath)
    }
}
