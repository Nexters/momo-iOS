//
//  MainViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/01/28.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let backgroundImageView: UIImageView = UIImageView(image: UIImage(named: "gradi_light"))
    private let tableView: UITableView = UITableView(frame: .zero)
    private let notActiveSession = NotActiveSessionView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
        self.setNavCustom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - navigation controller custom
    private func setNavCustom() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        let location = UIBarButtonItem(image: UIImage(systemName: "location.circle"), style: .plain, target: nil, action: nil)
        let myLocation = UIBarButtonItem(title: "서울특별시 강남구 역삼로", style: .plain, target: nil, action: nil)
        let GPS = UIBarButtonItem(image: UIImage(systemName: "scope"), style: .plain, target: nil, action: nil)
        let profile = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(goToUserProfileVC))
        
        self.navigationItem.leftBarButtonItems = [location, myLocation, GPS]
        self.navigationItem.rightBarButtonItem = profile
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.view.backgroundColor = .white
        self.backgroundImageView.isHidden = true
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.backgroundView = self.backgroundImageView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCells()
        self.view.addSubview(tableView)
    }
    
    private func registerCells() {
        self.tableView.register(MainAttendanceCodeCell.self, forCellReuseIdentifier: "MainAttendanceCodeCell")
        self.tableView.register(MainAttendanceDoneCell.self, forCellReuseIdentifier: "MainAttendanceDoneCell")
        self.tableView.register(MainSessionTimeCell.self, forCellReuseIdentifier: "MainSessionTimeCell")
        self.tableView.register(MainSessionDetailCell.self, forCellReuseIdentifier: "MainSessionDetailCell")
        self.tableView.register(MainSessionInfoCell.self, forCellReuseIdentifier: "MainSessionInfoCell")
        self.tableView.register(MainSessionNoInfoCell.self, forCellReuseIdentifier: "MainSessionNoInfoCell")
        self.tableView.register(MainSessionAbsentCell.self, forCellReuseIdentifier: "MainSessionAbsentCell")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(notActiveSession)
        notActiveSession.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        notActiveSession.isHidden = true
    }
    
    // MARK: - Action
    private func goToAttendanceVC() {
        let attendanceCodeDetailVC = AttendanceCodeDetailViewController()
        self.navigationController?.pushViewController(attendanceCodeDetailVC, animated: true)
    }
    
    private func showAbsenceModal() {
        CommonBottomAlert.absenceConfirmAlert().show()
    }
        
    @objc private func goToUserProfileVC() {
        let controller = PersonalInformationController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func isClear(cell: UITableViewCell) -> Bool {
        cell is MainSessionTimeCell || cell is MainAttendanceCodeCell || cell is MainAttendanceDoneCell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "MainSessionTimeCell") ?? UITableViewCell()
        case 1:
            guard let codeCell = tableView.dequeueReusableCell(withIdentifier: "MainAttendanceCodeCell") as? MainAttendanceCodeCell else {
                return UITableViewCell()
            }
            return codeCell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainAttendanceDoneCell") as? MainAttendanceDoneCell else {
                return UITableViewCell()
            }
            cell.historyButtonAction = { [weak self] in
                self?.goToUserProfileVC()
            }
            return cell
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: "MainSessionDetailCell") ?? UITableViewCell()
        case 4:
            return tableView.dequeueReusableCell(withIdentifier: "MainSessionInfoCell") ?? UITableViewCell()
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: "MainSessionNoInfoCell") ?? UITableViewCell()
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSessionAbsentCell") as? MainSessionAbsentCell else {
                return UITableViewCell()
            }
            cell.seesionAbsentBtnAction = { [weak self] in
                self?.showAbsenceModal()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1: // (MainAttendanceCodeCell) 출석 코드 입력 셀
            self.goToAttendanceVC()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isClear(cell: cell) {
            self.backgroundImageView.isHidden = false
        } else if tableView.isLast(for: indexPath) {
            self.backgroundImageView.isHidden = true
        }
    }
}
