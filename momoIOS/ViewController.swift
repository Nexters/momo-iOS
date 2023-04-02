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
    private let registrationButton: UIButton = UIButton()
    private let mainButton: UIButton = UIButton()
    private let adminButton: UIButton = UIButton()
    private let newNextersButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupButtonActions()
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.registrationButton.setTitle("회원가입 화면", for: .normal)
        self.mainButton.setTitle("유저 메인 화면", for: .normal)
        self.adminButton.setTitle("어드민 화면", for: .normal)
        self.newNextersButton.setTitle("새 기수 시작 화면", for: .normal)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubviews(registrationButton, mainButton, adminButton, newNextersButton)
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupButtonActions() {
        self.registrationButton.addTarget(self, action: #selector(goToRegistrationViewController), for: .touchUpInside)
        self.mainButton.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        self.adminButton.addTarget(self, action: #selector(goToAdminTabBarController), for: .touchUpInside)
        self.newNextersButton.addTarget(self, action: #selector(goToNewNextersViewController), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func goToRegistrationViewController() {
        self.navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    @objc private func goToMainViewController() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc private func goToAdminTabBarController() {
        self.navigationController?.pushViewController(AdminTabBarController(), animated: true)
    }
    
    @objc private func goToNewNextersViewController() {
        self.navigationController?.pushViewController(InputMoimYearController(), animated: true)
    }
}
