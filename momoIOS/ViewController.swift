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
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(self.mainButton)
        stackView.addArrangedSubview(self.otherButton)
        stackView.addArrangedSubview(self.adminButton)
        stackView.addArrangedSubview(self.registerPlaceButton)
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
    }
    
    // MARK: - Actions
    @objc private func goToMainViewController() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc private func goToOtherViewController() {
        self.navigationController?.pushViewController(RegistrationController(), animated: true)
<<<<<<< HEAD
    }
    
    @objc private func goToAdminViewController() {
        self.navigationController?.pushViewController(AdminSessionTableViewController(), animated: true)
=======
>>>>>>> 96a0356 ([STYLE][#34] 회원관리/모임관리 구분을 위해 폴더명 변경)
    }
    
    @objc private func goToRegisterPlaceViewController() {
        self.navigationController?.pushViewController(RegisterPlaceViewController(), animated: true)
    }
}
