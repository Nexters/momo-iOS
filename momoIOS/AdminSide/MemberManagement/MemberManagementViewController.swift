//
//  MemberManagementViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/25.
//

import MobileCoreServices
import SnapKit
import UIKit

final class MemberManagementViewController: UIViewController {
    // MARK: - Properties
    private let pages: [UIViewController] = [MemberListViewController(), AttendanceListViewController()]
    
    // MARK: - UI Components
    private let memberButton: UIButton = UIButton()
    private let attendanceButton: UIButton = UIButton()
    private let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    @available(iOS 14.0, *)
    private var excelButtonMenu: UIMenu {
        let actions = [
            UIAction(
                title: "엑셀 불러오기",
                image: UIImage(systemName: "arrow.down.doc"),
                handler: { [weak self] _ in
                    self?.selectImportExcelButton()
                }
            ),
            UIAction(
                title: "엑셀 내보내기",
                image: UIImage(systemName: "arrow.up.doc"),
                handler: { [weak self] _ in
                    self?.selectExportExcelButton()
                })
        ]
        
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: actions)
    }
    
    private var excelButtonAlert: UIAlertController {
        let alert = UIAlertController(title: nil, message: "회원등록", preferredStyle: .actionSheet)
        
        let importAction = UIAlertAction(
            title: "엑셀 불러오기",
            style: .default,
            handler: { [weak self] _ in
                self?.selectImportExcelButton()
            }
        )
        let exportAction = UIAlertAction(
            title: "엑셀 내보내기",
            style: .default,
            handler: { [weak self] _ in
                self?.selectExportExcelButton()
            }
        )
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(importAction)
        alert.addAction(exportAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigation()
        self.setupViews()
        self.setupLayout()
        self.selectMemberButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        let emptyView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 1))
        let logoImage = UIImage(named: "nextersLogoBlack")
        let logoView = UIImageView(image: logoImage)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: emptyView), UIBarButtonItem(customView: logoView)]
        
        let excelImage = UIImage(named: "naviExcel")?.withRenderingMode(.alwaysOriginal)
        let excelButton = UIButton()
        excelButton.setTitle("회원등록", font: .body16, color: .gray800)
        excelButton.setImage(excelImage, tintColor: .clear, padding: 7, direction: .leading)
        excelButton.configurate(edgeInsets: .init(top: 20, leading: 8, bottom: 20, trailing: 8))
        
        if #available(iOS 14.0, *) {
            excelButton.menu = self.excelButtonMenu
            excelButton.showsMenuAsPrimaryAction = true
        } else {
            excelButton.addTarget(self, action: #selector(selectExcelButton), for: .touchUpInside)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: excelButton)
    }
    
    private func setupViews() {
        self.view?.backgroundColor = .background
        self.setupButtons()
        self.setupPageViewController()
    }
    
    private func setupButtons() {
        self.memberButton.setTitle("회원", font: .body18, color: .gray800)
        self.memberButton.addTarget(self, action: #selector(selectMemberButton), for: .touchUpInside)
        
        self.attendanceButton.setTitle("출석", font: .body18, color: .gray800)
        self.attendanceButton.addTarget(self, action: #selector(selectAttendanceButton), for: .touchUpInside)
        
        [self.memberButton, self.attendanceButton].forEach { (button: UIButton) in
            button.configurate(padding: 9)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 12
            button.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        }
    }
    
    private func setupPageViewController() {
        self.addChild(self.pageViewController)
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        if let firstvc = self.pages.first {
            self.pageViewController.setViewControllers([firstvc], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Layout
    func setupLayout() {
        self.view.addSubviews(self.memberButton, self.attendanceButton, self.pageViewController.view)
        
        self.memberButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(3)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
        
        self.attendanceButton.snp.makeConstraints { make in
            make.top.size.equalTo(self.memberButton)
            make.leading.equalTo(self.memberButton.snp.trailing)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
        
        self.pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(self.memberButton.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.pageViewController.didMove(toParent: self)
    }
    
    // MARK: - Action
    @objc private func selectMemberButton() {
        self.memberButton.backgroundColor = .white
        self.attendanceButton.backgroundColor = .clear
        guard let memberListViewConttoller = self.pages[safe: 0] else { return }
        self.pageViewController.setViewControllers([memberListViewConttoller], direction: .reverse, animated: true)
    }
    
    @objc private func selectAttendanceButton() {
        self.memberButton.backgroundColor = .clear
        self.attendanceButton.backgroundColor = .white
        guard let attendanceViewController = self.pages[safe: 1] else { return }
        self.pageViewController.setViewControllers([attendanceViewController], direction: .forward, animated: true)
    }
    
    @objc private func selectExcelButton() {
        self.present(self.excelButtonAlert, animated: true, completion: nil)
    }
    
    /// 엑셀 불러오기
    /// - 파일 선택기를 open한다.
    /// - 서버로 전송할 스프레드시트 파일을 선택한다.
    /// - 파일 선택 후에는 delegate의 `documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])` 가 호출된다.
    @objc private func selectImportExcelButton() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeSpreadsheet)], in: .import)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true)
    }
    
    @objc private func selectExportExcelButton() {
        
    }
}

// MARK: - UIPageViewController Delegate, Datasource
extension MemberManagementViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.pages.firstIndex(of: viewController) else {
            return nil
        }
        return self.pages[safe: index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.pages.firstIndex(of: viewController) else {
            return nil
        }
        return self.pages[safe: index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = self.pages.firstIndex(of: currentVC) else {
            return
        }
        if currentIndex == 0 {
            self.memberButton.backgroundColor = .white
            self.attendanceButton.backgroundColor = .clear
        } else if currentIndex == 1 {
            self.memberButton.backgroundColor = .clear
            self.attendanceButton.backgroundColor = .white
        }
    }
}

extension MemberManagementViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // send to server
    }
}
