//
//  ViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/01/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // MARK: - Views
    private let mainButton: UIButton = UIButton()
    private let otherButton: UIButton = UIButton()
    private let adminButton: UIButton = UIButton()
    private let registerPlaceButton = UIButton()
    private let newNextersButton: UIButton = UIButton()
    private let moimSettingButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupButtonActions()
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.mainButton.setTitle("Main으로 이동", for: .normal)
        self.otherButton.setTitle("가입화면으로 이동", for: .normal)
        self.adminButton.setTitle("어드민 세션", for: .normal)
        self.registerPlaceButton.setTitle("장소등록 화면", for: .normal)
        self.newNextersButton.setTitle("새 기수 시작 화면", for: .normal)
        self.moimSettingButton.setTitle("모임 설정 관리 화면", for: .normal)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubviews(mainButton, otherButton, adminButton, registerPlaceButton, newNextersButton, moimSettingButton)
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupButtonActions() {
        self.mainButton.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        self.otherButton.addTarget(self, action: #selector(goToOtherViewController), for: .touchUpInside)
        self.adminButton.addTarget(self, action: #selector(goToAdminViewController), for: .touchUpInside)
        self.registerPlaceButton.addTarget(self, action: #selector(goToRegisterPlaceViewController), for: .touchUpInside)
        self.newNextersButton.addTarget(self, action: #selector(goToNewNextersViewController), for: .touchUpInside)
        self.moimSettingButton.addTarget(self, action: #selector(goToMoimSettingViewController), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func goToMainViewController() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc private func goToOtherViewController() {
        self.navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    @objc private func goToAdminViewController() {
        self.navigationController?.pushViewController(AdminSessionTableViewController(), animated: true)
    }
    
    @objc private func goToNewNextersViewController() {
        self.navigationController?.pushViewController(InputMoimYearController(), animated: true)
    }
    
    @objc private func goToMoimSettingViewController() {
        self.navigationController?.pushViewController(MoimManagementcontrolelr(), animated: true)
    }
    
    @objc private func goToRegisterPlaceViewController() {
        self.navigationController?.pushViewController(RegisterPlaceViewController(), animated: true)
    }
}
